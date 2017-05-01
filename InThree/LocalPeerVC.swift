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
    var localPeers = [BlipUser]()
    var selectedPeers = [BlipUser]()
    var selectedPeerCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localPeerView.peerTable.delegate = self
        localPeerView.peerTable.dataSource = self
        localPeerView.peerTable.register(BlipUserCell.self, forCellReuseIdentifier: BlipUserCell.identifier)
        
        self.view = localPeerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.localPeers = MultipeerManager.sharedInstance.peers
        localPeerView.peerTable.reloadData()
    }
    
}

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
        selectedPeers.append(localPeers[indexPath.row])
        for peer in selectedPeers {
            print("Users listed in selected peers: \(peer.name)")
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let uidForDeselectedPeer = localPeers[indexPath.row].uid
        for (index, blipUser) in selectedPeers.enumerated() {
            if blipUser.uid == uidForDeselectedPeer {
                selectedPeers.remove(at: index)
                for peer in selectedPeers {
                    print("Users listed in selected peers: \(peer.name)")
                }
            }
        }
    }
}

