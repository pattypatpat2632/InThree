//
//  BlipUserCell.swift
//  InThree
//
//  Created by Patrick O'Leary on 4/30/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class BlipUserCell: UITableViewCell, BlipBloopView {
    
    static let identifier = "BlipUserCell"
    var blipUser: BlipUser? {
        didSet {
            self.setLabel()
        }
    }
    
    let nameLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()

    }
    
    func commonInit() {
        self.backgroundColor = colorScheme.model.baseColor
        
        setConstraints()
        setSubviewProperties()
    }
    
    func setConstraints() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        
    }
    
    func setSubviewProperties() {
        nameLabel.backgroundColor = colorScheme.model.baseColor
        nameLabel.textColor = colorScheme.model.foregroundColor
        if let blipUser = self.blipUser {
            nameLabel.text = blipUser.name
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLabel() {
        self.nameLabel.text = blipUser?.name
    }
}
