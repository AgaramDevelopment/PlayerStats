//
//  TeamListTableViewCell.swift
//  SportsStats
//
//  Created by user on 25/05/18.
//  Copyright © 2018 agaram. All rights reserved.
//

import UIKit

class TeamListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPlayerRole: UILabel!
    @IBOutlet weak var lblPlayerImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
