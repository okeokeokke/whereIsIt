//
//  TextTableViewCell.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/10/03.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit

class TextTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tagImage: UIImageView!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var textNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setSubjectName(_ name:String) {
        self.subjectLabel.text = name
        self.textNameLabel.text = name
    }
    
}
