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
    let myPeerID = MCPeerID(displayName: (FirebaseManager.sharedInstance.currentBlipUser?.uid)!)//TODO: fix this force unwrap
    var allAvailablePeers = [BlipUser]()
    var party = Party()
    
    let serviceAdvertiser: MCNearbyServiceAdvertiser
    let serviceBrowser: MCNearbyServiceBrowser
    
    var delegate: MultipeerManagerDelegate?
    var partyDelegate: PartyInviteDelegate?
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    
    private override init() {
        serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: service)
        serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: service)
        
        super.init()
        
        serviceAdvertiser.delegate = self
        serviceAdvertiser.startAdvertisingPeer()
        serviceBrowser.delegate = self
        serviceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        serviceAdvertiser.stopAdvertisingPeer()
        serviceBrowser.stopBrowsingForPeers()
    }
    
    func send(score: Score, party: Party) { //Send a score to another user
        guard let scoreData = score.asData() else {
            print("Score data returned nil")
            return
        }
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(scoreData, toPeers: session.connectedPeers, with: .reliable)
                print("Sent score to connected peers")
            } catch{
                print("Errah")
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
        var invitee: BlipUser?
        for peer in self.allAvailablePeers {
            if peer.uid == peerID.displayName {
                invitee = peer
                guard let invitee = invitee else {return}
                partyDelegate?.askIfAttending(fromInvitee: invitee, completion: { (attending) in
                    if attending {
                       invitationHandler(true, self.session)//If a user accepts an invitation, add it to the session.connectedPeers
                    }
                })
            }
        }
    }
}

//MARK: Browser Delegate
extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {

        //TODO: remove peer from peers array

    }
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("Did not start browsing for peers")//TODO: INdicate to user that browser could not be established
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        for blipUser in FirebaseManager.sharedInstance.allBlipUsers {
            if blipUser.uid == peerID.displayName {
                self.allAvailablePeers.append(blipUser)
                break
            }
        }
    }
    
    func invitePeers(_ blipUsers: [BlipUser]) {
        for blipUser in blipUsers {
            let mcPeerID = MCPeerID(displayName: blipUser.uid)
            serviceBrowser.invitePeer(mcPeerID, to: session, withContext: nil, timeout: 10)
        }
    }
}

extension MultipeerManager: MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
            if let newScore = Score(dictionary: json) {
                delegate?.musicChanged(forUID: peerID.displayName, score: newScore, manager: self)
            }
        } catch {
            print("Could not create JSON from received data")
        }
        
        
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .notConnected:
            print("not connected")
        case .connecting:
            print("connecting") //TODO: Enable notifications for newly connected users
        case .connected:
            print("connected")
        }
    }
    
    private func remove(blipUserWithUID uid: String) {
        for (index, blipUser) in allAvailablePeers.enumerated() {
            if uid == blipUser.uid {
                allAvailablePeers.remove(at: index)
                delegate?.connectionLost(forUID: uid, manager: self)
            }
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

protocol MultipeerManagerDelegate {
    
    func connectionLost(forUID uid: String, manager: MultipeerManager)
    func musicChanged(forUID uid: String, score: Score, manager: MultipeerManager)

}

protocol PartyInviteDelegate {
    func askIfAttending(fromInvitee invitee: BlipUser, completion: @escaping (Bool) -> Void)
}


