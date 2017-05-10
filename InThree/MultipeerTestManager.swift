//
//  MultipeerTestUser.swift
//  InThree
//
//  Created by Patrick O'Leary on 5/1/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation

//
//  MultipeerManager.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/27/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import MultipeerConnectivity

final class MultipeerTestManager: NSObject {
    
    static let sharedInstance = MultipeerTestManager()
    let service = "blipbloop-2632"
    let myPeerID = MCPeerID(displayName: "Test User")//TODO: fix this force unwrap
    var peers = [BlipUser]()
    let testUser = BlipUser(uid: "Test User", dictionary: [
            "name": "Test User",
            "email": "test@test.com"
        ])
    
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser
    
    var delegate: MultipeerTestManagerDelegate?
    
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
    
    func send(score: Score) { //Send a score to another user

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
    
    func generateRandomScores() {
        DispatchQueue.global().async {
            let score = Score.random()
            self.send(score: score)
            print("RANDOM SCORE SENT BY TEST USER")
            sleep(8)
            self.generateRandomScores()
        }
    }
}
//MARK: Advertiser Delegate
extension MultipeerTestManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("Boo")// TODO: indicate to user that there is no available connection to broadcast advertiser
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
        print("RECEIVED INVITE uid: \(peerID.displayName)")
        guard let contextUW = context else {return} //TODO: handle this error mo bettah
        do {
            let jsonData = try JSONSerialization.jsonObject(with: contextUW, options: [])
            let jsonDict = jsonData as? [String: Any] ?? [:]
            let newPeer = BlipUser(uid: peerID.displayName, dictionary: jsonDict)
            self.peers.append(newPeer)
        } catch {
            print("UNABLE TO CREATE NEW PEER FROM PEER DATA")
        }
    }
}

//MARK: Browser Delegate
extension MultipeerTestManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Boo")
    }
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("Did not start browsing for peers")//TODO: Indicate to user that browser could not be established
    }
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        guard let data = self.testUser.jsonData() else {return}
        
        browser.invitePeer(peerID, to: session, withContext: data, timeout: 10)
        print("SENT INVITE")
        
    }
}

extension MultipeerTestManager: MCSessionDelegate {
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
    }
    
    
    // Unused delegate functions
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
    }
    
    
}

protocol MultipeerTestManagerDelegate {
    func musicChanged(forUID uid: String, score: Score, manager: MultipeerManager)
}
