//
//  FriendFinderVC.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/27/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LocalPeerVC: UIViewController {
    
    let localPeerView = LocalPeerView()
    let currentUser = FirebaseManager.sharedInstance.currentBlipUser
    
    var localPeers: [BlipUser] = MultipeerManager.sharedInstance.allAvailablePeers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localPeerView.peerTable.delegate = self
        localPeerView.peerTable.dataSource = self
        localPeerView.peerTable.register(BlipUserCell.self, forCellReuseIdentifier: BlipUserCell.identifier)
        
        localPeerView.delegate = self
        MultipeerManager.sharedInstance.partyDelegate = self
        
        self.view = localPeerView
        
        MultipeerManager.sharedInstance.startBrowsing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localPeerView.peerTable.reloadData()
    }
    
}
// MARK: Tableview delegate and data source
extension LocalPeerVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localPeers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = localPeerView.peerTable.dequeueReusableCell(withIdentifier: BlipUserCell.identifier, for: indexPath) as! BlipUserCell
        cell.blipUser = localPeers[indexPath.row]
        return cell
    }
}

//MARK: Local Peer View Delegate
extension LocalPeerVC: LocalPeerViewDelegate {
    
    func goToPartySquencer() {
        let partySequencerVC = PartySequencerVC()
        navigationController?.pushViewController(partySequencerVC, animated: true)
    }
    
    func returnToDashboard() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension LocalPeerVC: PartyInviteDelegate {
    
    func askIfAttending(fromInvitee invitee: BlipUser, completion: @escaping (Bool) -> Void) {
        
    }
    
    func availablePeersChanged() {
        self.localPeers = MultipeerManager.sharedInstance.allAvailablePeers
        DispatchQueue.main.async {
            self.localPeerView.peerTable.reloadData()
            print("RELOADED DATA")
            print("LOCAL PEERS:")
            print(self.localPeers.count)
            for peer in self.localPeers {
                print(peer.name)
            }
        }
    }
}

