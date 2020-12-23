//
//  ElectionCell.swift
//  SPV
//
//  Created by HappySanz Tech on 24/11/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class ElectionCell: UITableViewCell {

    @IBOutlet weak var electionYear: UILabel!
    @IBOutlet weak var partyLeader: UILabel!
    @IBOutlet weak var seatsWon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
