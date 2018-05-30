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

    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var lblTeamName: UILabel!
    @IBOutlet weak var imgTeamLogo: UIImageView!
    @IBOutlet weak var PlayerTable: UITableView!
}

extension TeamListCollectionViewCell{
    
    func setTable <D : UITableViewDelegate & UITableViewDataSource>(delegate : D ,forRow row:Int){
        
        PlayerTable.delegate = delegate
        PlayerTable.dataSource = delegate
        PlayerTable.tag = row
        PlayerTable.reloadData()
        
        
    }
}


