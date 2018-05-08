//
//  DetailCell.h
//  SearchExample
//
//  Created by Apple on 06/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIView * commonviewCell;

@property (nonatomic,strong) IBOutlet UILabel * competition_lbl;

@property(nonatomic,strong) IBOutlet UILabel * match_lbl;
@property(nonatomic,strong) IBOutlet UILabel * inns_lbl;
@property(nonatomic,strong) IBOutlet UILabel * runs_lbl;
@property(nonatomic,strong) IBOutlet UILabel * balls_lbl;
@property(nonatomic,strong) IBOutlet UILabel * sr_lbl;
@property(nonatomic,strong) IBOutlet UILabel * no_lbl;
@property(nonatomic,strong) IBOutlet UILabel * hs_lbl;
@property(nonatomic,strong) IBOutlet UILabel * avg_lbl;
@property(nonatomic,strong) IBOutlet UILabel * db_lbl;
@property(nonatomic,strong) IBOutlet UILabel * dbFrq_lbl;
@property(nonatomic,strong) IBOutlet UILabel * oncePer_lbl;
@property(nonatomic,strong) IBOutlet UILabel * fourPer_lbl;
@property(nonatomic,strong) IBOutlet UILabel * sixPer_lbl;
@property(nonatomic,strong) IBOutlet UILabel * bdry_lbl;
@property(nonatomic,strong) IBOutlet UILabel * bdryFeq_lbl;
@property(nonatomic,strong) IBOutlet UILabel * thirtyplus_lbl;
@property(nonatomic,strong) IBOutlet UILabel * fityplus_lbl;
@property(nonatomic,strong) IBOutlet UILabel * thirtypluspartnership_lbl;
@property(nonatomic,strong) IBOutlet UILabel * fiftpluspartnership_lbl;


@end
