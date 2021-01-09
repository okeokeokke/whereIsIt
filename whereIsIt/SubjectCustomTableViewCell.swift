//
//  SubjectCustomTableViewCell.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/11/21.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit

class SubjectCustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var subjectColorImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
