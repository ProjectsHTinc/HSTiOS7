//
//  HomeTableViewCell.swift
//  SPV
//
//  Created by Happy Sanz Tech on 23/10/20.
//  Copyright © 2020 HappySanz Tech. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var descp: UILabel!
    @IBOutlet weak var shareOutlet: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
