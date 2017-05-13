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
    
    var localPeers: [BlipUser] {
        return MultipeerManager.sharedInstance.allAvailablePeers
    }
    var selectedPeers = [BlipUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localPeerView.peerTable.delegate = self
        localPeerView.peerTable.dataSource = self
        localPeerView.peerTable.register(BlipUserCell.self, forCellReuseIdentifier: BlipUserCell.identifier)
        
        localPeerView.delegate = self
        MultipeerManager.sharedInstance.partyDelegate = self
        
        self.view = localPeerView
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! BlipUserCell
        if !cell.chosen {
            guard selectedPeers.count <= 3 else {
                print("Selected peer count is already at maximum")
                return
            }
            selectedPeers.append(localPeers[indexPath.row])
            print("Number of selected peers: \(selectedPeers.count)")
            for peer in selectedPeers {
                print("Users listed in selected peers: \(peer.name)")
            }
            cell.backgroundColor = localPeerView.colorScheme.model.highlightColor
            cell.chosen = true
        } else {
            cell.backgroundColor = localPeerView.colorScheme.model.baseColor
            let uidForDeselectedPeer = localPeers[indexPath.row].uid
            for (index, blipUser) in selectedPeers.enumerated() {
                if blipUser.uid == uidForDeselectedPeer {
                    selectedPeers.remove(at: index)
                    for peer in selectedPeers {
                        print("Users listed in selected peers: \(peer.name)")
                    }
                }
            }
            cell.chosen = false
        }
        
    }
    
}

//MARK: Local Peer View Delegate
extension LocalPeerVC: LocalPeerViewDelegate {
    
    func goToPartySquencer() {
        inviteSelectedPeers()
        let partySequencerVC = PartySequencerVC()
        navigationController?.pushViewController(partySequencerVC, animated: true)
    }
    
    private func inviteSelectedPeers() {
        if let currentUser = currentUser {
            MultipeerManager.sharedInstance.party.add(member: currentUser)
            MultipeerManager.sharedInstance.invitePeers(self.selectedPeers)
        }
    }
    
    func returnToDashboard() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension LocalPeerVC: PartyInviteDelegate {
    func askIfAttending(fromInvitee invitee: BlipUser, completion: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "Would you like to join the party?", message: "Invited by: \(invitee.name)", preferredStyle: .alert)
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (action) in
            completion(false)
        }
        alertController.addAction(noAction)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (action) in
            completion(true)
            let partyVC = PartySequencerVC()
            self.navigationController?.pushViewController(partyVC, animated: true)
        }
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

