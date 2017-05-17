//
//  MultipeerManager.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/27/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import MultipeerConnectivity

final class MultipeerManager: NSObject {
    
    static let sharedInstance = MultipeerManager()
    let service = "blipbloop-2632"
    var currentUser = FirebaseManager.sharedInstance.currentBlipUser
    let myPeerID = MCPeerID(displayName: (FirebaseManager.sharedInstance.currentBlipUser?.uid)!)
    var availablePeers = [BlipUser]() {
        didSet{
            for peer in availablePeers {
                print(peer.name)
            }
        }
    }
    
    var serviceAdvertiser: MCNearbyServiceAdvertiser?
    var serviceBrowser: MCNearbyServiceBrowser?

    var multipeerDelegate: MultipeerDelegate?
    
    lazy var session: MCSession = {
        
        let session = MCSession(peer: self.myPeerID, securityIdentity: nil, encryptionPreference: .optional)
        session.delegate = self
        return session
        
    }()
    
    private override init() {
        super.init()
    }
    
    func startBrowsing() {
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: service)
        serviceBrowser?.delegate = self
        serviceBrowser?.startBrowsingForPeers()
    }
    
    func startAdvertising() {
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: service)
        serviceAdvertiser?.delegate = self
        serviceAdvertiser?.startAdvertisingPeer()
    }
    
    deinit {
        serviceAdvertiser?.stopAdvertisingPeer()
        serviceBrowser?.stopBrowsingForPeers()
    }
    
    func updateAvailablePeers() {
        print("UPDATING AVAILABLE PEERS")
        availablePeers.removeAll()
        for peer in session.connectedPeers {
            for user in FirebaseManager.sharedInstance.allBlipUsers {
                if user.uid == peer.displayName {
                    availablePeers.append(user)
                    break
                }
            }
        }
        print("post notification")
        NotificationCenter.default.post(name: .availablePeersUpdated, object: nil)
    }
    
    func invite(blipUsers: [BlipUser], toParty party: Party) {
        if let partyID = party.id {
            print("Inviting users with valid party ID")
            do {
                print("writing json")
                let json = try JSONSerialization.data(withJSONObject:["partyid": partyID] , options: [])
                print("json success, sending json to session")
                try session.send(json, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                print("could not convert party ID into JSON and send to connected peers")
            }
        }
    }
    
}

//MARK: Advertiser Delegate
extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("Boo")// TODO: indicate to user that there is no available connection to broadcast advertiser
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        for user in FirebaseManager.sharedInstance.allBlipUsers {
            if user.uid == peerID.displayName {
                multipeerDelegate?.askPermission(fromInvitee: user, completion: { (permission) in
                    if permission {
                        invitationHandler(true, self.session)
                    }
                })
                break
            }
        }
    }
}

//MARK: Browser Delegate
extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("lost peer: \(peerID.displayName)")
    }
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("Did not start browsing for peers")//TODO: INdicate to user that browser could not be established
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {

        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 30.0) //If
        
    }
}

extension MultipeerManager: MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            let partyDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] ?? [:]//TODO: handle error
            for user in FirebaseManager.sharedInstance.allBlipUsers {
                if user.uid == peerID.displayName {
                    guard let partyID = partyDict["partyid"] else {return}
                    multipeerDelegate?.respondToInvite(fromUser: user, withPartyID: partyID)
                    break
                }
            }
        } catch {
            print("could not convert party ID back to String")
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            self.updateAvailablePeers()
        case .connecting:
            print("connecting")
        case .connected:
            //add(peerID: peerID.displayName)
            print("connected")
            self.updateAvailablePeers()
        }
    }
    
    // Unused required delegate functions
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
    }
    
    
}

protocol MultipeerDelegate {
    func askPermission(fromInvitee invitee: BlipUser, completion: @escaping (Bool) -> Void)
    func respondToInvite(fromUser blipUser: BlipUser, withPartyID partyID: String)
}



