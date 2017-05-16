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
    
    var localPeers: [BlipUser] = MultipeerManager.sharedInstance.availablePeers
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localPeerView.peerTable.delegate = self
        localPeerView.peerTable.dataSource = self
        localPeerView.peerTable.register(BlipUserCell.self, forCellReuseIdentifier: BlipUserCell.identifier)
        
        localPeerView.delegate = self
        self.view = localPeerView
        
        MultipeerManager.sharedInstance.startBrowsing()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLocalPeers), name: .availablePeersUpdated, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.localPeerView.peerTable.reloadData()
        }
    }
    
    func updateLocalPeers() {
        self.localPeers = MultipeerManager.sharedInstance.availablePeers
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


