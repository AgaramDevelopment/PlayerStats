//
//  PlayerViewController.swift
//  SportsStats
//
//  Created by user on 24/05/18.
//  Copyright © 2018 agaram. All rights reserved.
//

import UIKit
import SDWebImage

class PlayerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var TeamListCollection: UICollectionView!{
        
        didSet {
//            let nib = UINib(nibName: cellIdentifier, bundle: nil)
//            TeamListCollection.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            TeamListCollection.delegate   = self
            TeamListCollection.dataSource = self
        }

    }
    
    func is_iPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    var responseArray = [Any]() //as! [String:Any]
    
    fileprivate let cellIdentifier = "TeamListCollectionViewCell"
    fileprivate var myTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addCustomNavigation()
        webservice()
        
//        myTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateNotificationCount) userInfo:nil repeats:YES];
        myTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(webservice), userInfo: nil, repeats: true)
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        myTimer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCustomNavigation()  {
        
        let navObj = CustomNavigation(nibName: "CustomNavigation_iPad", bundle:Bundle.main)
        self.view.addSubview(navObj.view)
        navObj.tittle_lbl.text="Team Squad";
        navObj.nav_header_img.image = UIImage(named: "withText")
        
        navObj.img1.isHidden=true
        navObj.img2.isHidden=true
        navObj.btnCompName.isHidden=true
        navObj.btnSquad.isHidden=true

        navObj.btn_back.isHidden=false
        navObj.filter_btn.isHidden=true
        navObj.nav_search_view.isHidden=true
        navObj.btn_back.addTarget(self, action: #selector(BackNavigation), for: .touchUpInside)
        
        
    }
    
    
    @objc func BackNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let data : NSDictionary = self.responseArray[tableView.tag] as? NSDictionary{
            
            if let tblcount : NSArray = (data.value(forKey: "Players") as? NSArray){
                NSLog("tblcount \(tblcount.count)")
                return tblcount.count
            }
        }
        
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  "TeamListTableViewCell")as! TeamListTableViewCell
        
        if let TeamArray = self.responseArray[tableView.tag] as? NSDictionary, let PlayerList = (TeamArray.value(forKey: "Players") as? NSArray) {
            
            NSLog("PlayerList \(PlayerList)")
            if let playerName  = PlayerList.object(at: indexPath.row) as? NSDictionary {
                cell.lblPlayerName.text = playerName["PlayerName"] as? String
                cell.lblPlayerRole.text = playerName["PlayerProficiency"] as? String
                
                let playerRole : String = cell.lblPlayerRole.text!
                
                switch playerRole {
                case "All Rounder":
                    cell.lblPlayerImg.image = #imageLiteral(resourceName: "batball")
                case "Batsman":
                    cell.lblPlayerImg.image = #imageLiteral(resourceName: "bat")
                case "Bowler":
                    cell.lblPlayerImg.image = #imageLiteral(resourceName: "ball")
                case "Wicket Keeper":
                    cell.lblPlayerImg.image = #imageLiteral(resourceName: "glove")
                default :
                    print("NO item match")
                }
                
                if let photo =  playerName["PlayerPhoto"] as? String, let url = URL(string: photo) {
                    
                    cell.lblPlayerImg.sd_setImage(with: url, placeholderImage: UIImage(named: "DefaultImg"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        // Perform operation.
                    })
                    
                }

            }
            
//            if let teamName = PlayerList.value(forKey: "TeamName")as? String  {
//                cell.lblPlayerName.text = teamName
//            }
//
//            if let PlayerProficiency = PlayerList.value(forKey: "PlayerProficiency")as? String  {
//                cell.lblPlayerRole.text = PlayerProficiency
//            }
            
//            if let photo =  PlayerList["PlayerPhoto"] as? String, let url = URL(string: photo) {
//
//                cell.lblPlayerImg.sd_setImage(with: url, placeholderImage: UIImage(named: "DefaultImg"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
//                    // Perform operation.
//                })
//
//            }
            
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDataSource
    
//    - (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        
        let width = collectionView.frame.width-40
        let height = collectionView.frame.height

//        if is_iPad() {
//
//        }
        
        return CGSize(width:width/3, height: height)
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let Tablecell = cell as? TeamListCollectionViewCell {
            Tablecell.setTable(delegate: self, forRow: indexPath.row)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NSLog("indexpath \(indexPath.item)")
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.responseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = TeamListCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TeamListCollectionViewCell
        
        
        if let teamName = self.responseArray[indexPath.row] as? NSDictionary{
            
            if let teamName = teamName.value(forKey: "TeamName")as? String  {
                cell.lblTeamName.text = teamName
            }
            
            
            if let url = URL(string: teamName["TeamLogo"] as! String){
                
                cell.imgTeamLogo.sd_setImage(with: url, placeholderImage: UIImage(named: "building"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                    // Perform operation.
                })
                
            }
            
            
            if let tblcount : NSArray = (teamName.value(forKey: "Players") as? NSArray){
                NSLog("tblcount \(tblcount.count)")
                cell.lblNoData.isHidden = tblcount.count > 0 ? true : false

            }
            
        }
        
        
        /*
         cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
         
         cell.layer.shadowOffset = CGSizeZero;
         cell.layer.shadowRadius = 1.0f;
         cell.layer.shadowOpacity = 0.5f;
         cell.layer.masksToBounds = NO;
         cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
         
         */
        
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.darkGray.cgColor
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath

        
        return cell
    }


    
}


extension PlayerViewController{
    
    @objc func webservice(){
        
        let urlStr = URL(string: "http://13.126.151.253:9001/AGAPTService.svc/FETCH_TNPLPLAYERDETAILS")
        var urlReq : URLRequest = URLRequest(url: urlStr!)
        urlReq.httpMethod = "GET"
        let session : URLSession = URLSession(configuration: .default)
        
        let task : URLSessionTask = session.dataTask(with: urlReq) { (data : Data!, response : URLResponse!, error : Error!) in
            
            if error == nil,let usableData = data {
                
                do{
                    let testdata = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                    self.responseArray = testdata["Teams"] as! [Any]
                    
                    DispatchQueue.main.async {
                        self.TeamListCollection.reloadData()
                    }
                }
                catch {
                    print("error trying to convert data to JSON")
                    
                }
                
                NSLog("RESPONSE \(usableData)")
                
            }
        }
        task.resume()

    }
}


