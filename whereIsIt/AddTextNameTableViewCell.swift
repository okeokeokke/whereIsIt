//
//  AddTextNameTableViewCell.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/12/05.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit

class AddTextNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tagImage: UIImageView!
    @IBOutlet weak var textNameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
