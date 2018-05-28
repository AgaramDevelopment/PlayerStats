//
//  TeamListCollectionViewCell.swift
//  SportsStats
//
//  Created by user on 25/05/18.
//  Copyright © 2018 agaram. All rights reserved.
//

import UIKit

class TeamListCollectionViewCell: UICollectionViewCell {
    
    
    var responseArray = [Any]()

    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var imgTeamLogo: UIImageView!
//    @IBOutlet weak var PlayerTable: UITableView!{
//
//        didSet {
//            PlayerTable.delegate   = self as? UITableViewDelegate
//            PlayerTable.dataSource = self as? UITableViewDataSource
//        }
//    }
}

//extension TeamListTableViewCell : UITableViewDelegate {
//
//}
//
//extension TeamListTableViewCell : UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.res
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
//
//
//}
