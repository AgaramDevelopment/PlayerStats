//
//  PlayerViewController.swift
//  SportsStats
//
//  Created by user on 24/05/18.
//  Copyright © 2018 agaram. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var TeamListCollection: UICollectionView!{
        
        didSet {
//            let nib = UINib(nibName: cellIdentifier, bundle: nil)
//            TeamListCollection.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            TeamListCollection.delegate   = self
            TeamListCollection.dataSource = self
        }

    }
    
    var responseArray = [Any]() //as! [String:Any]
    
    fileprivate let cellIdentifier = "ImageCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addCustomNavigation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addCustomNavigation()  {
        
        let navObj = CustomNavigation(nibName: "CustomNavigation_iPad", bundle:Bundle.main)
        self.view.addSubview(navObj.view)
        navObj.tittle_lbl.text="sampole";
        navObj.nav_header_img.image = UIImage(named: "withText")
        
        navObj.img1.isHidden=true
        navObj.img2.isHidden=true
        
        navObj.btn_back.isHidden=false
        navObj.filter_btn.isHidden=true
        navObj.nav_search_view.isHidden=true
        navObj.btn_back.addTarget(self, action: #selector(BackNavigation), for: .touchUpInside)
        
        
    }
    
    
    @objc func BackNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}

    
    // MARK: - UICollectionViewDelegate
    extension PlayerViewController: UICollectionViewDelegate {
//        func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//            if let cell = cell as? TeamCollectionViewCell {
////                self.collectionView.animateCell(cell)
//            }
//        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            NSLog("indexpath \(indexPath.item)")
//            UserDefaults.standard.set(self.responseArray[indexPath.item], forKey: "selectedCompetetionArray")
//            let appdel = UIApplication.shared.delegate as! AppDelegate
//            let story = appdel.storyBoard.instantiateViewController(withIdentifier: "tabViewController")
//            appdel.navigationController.pushViewController(story, animated: true)
            
        }
        
    }
    
    // MARK: - UICollectionViewDataSource
    extension PlayerViewController: UICollectionViewDataSource {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
                    return 5
//            return self.responseArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = TeamListCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! TeamListCollectionViewCell
            
            // Set image only when animation type is custom1
//            if animationType == .custom1 {
//
//                //            cell.configure(with: UIImage(named: images[indexPath.row])!)
//
//                let data : NSDictionary = self.responseArray[indexPath.item] as! NSDictionary
//                let url = URL(string: data["IMAGEURL"] as! String)
//                let name = data["COMPETITIONNAME"] as! String
//                cell.lblCompetetionName.text = name
//                cell.sampleImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "building"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
//                    // Perform operation.
//                })
//            }
            
//            self.collectionView.animateCell(cell)
            return cell
        }
    }


