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
    var selectedPeers = [BlipUser]() {
        didSet {
            for peer in selectedPeers {
                print(peer.name)
            }
        }
    }
    
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
        print("updating local peers")
        self.localPeers = MultipeerManager.sharedInstance.availablePeers
        for peer in self.localPeers {
            print(peer.name)
        }
        DispatchQueue.main.async {
            if self.localPeers.count > 0 {
                self.localPeerView.changeTitle(to: "Invite your friends to join:")
            } else {
                self.localPeerView.changeTitle(to: "Finding friends to join the party...")
            }
            self.localPeerView.peerTable.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = localPeerView.peerTable.cellForRow(at: indexPath) as! BlipUserCell
        if !cell.chosen {
            cell.chosen = true
            if let blipUser = cell.blipUser {
                selectedPeers.append(blipUser)
            }
        } else {
            cell.chosen = false
            if let blipUser = cell.blipUser {
                deselect(peer: blipUser)
            }
        }
    }
    
    private func deselect(peer: BlipUser) {
        for (index, selected) in selectedPeers.enumerated() {
            if selected.uid == peer.uid {
                selectedPeers.remove(at: index)
                break
            }
        }
    }
}

//MARK: Local Peer View Delegate
extension LocalPeerVC: LocalPeerViewDelegate {
    
    func goToPartySquencer() {
        guard let currentUser = self.currentUser else {return} //TODO: return user to dashboard because no valid login
        PartyManager.sharedInstance.newParty(byUser: currentUser) { (partyID) in
            MultipeerManager.sharedInstance.invite(blipUsers: self.selectedPeers, toParty: PartyManager.sharedInstance.party)
            let partySequencerVC = PartySequencerVC()
            partySequencerVC.connectedPeers = self.selectedPeers
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(partySequencerVC, animated: true)
                partySequencerVC.partyID = partyID
            }
        }
    }
    
    func returnToDashboard() {
        navigationController?.popViewController(animated: true)
    }
    
}


