//
//  BowlerCell.h
//  SportsStats
//
//  Created by Apple on 12/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BowlerCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * competition_lbl;

@property(nonatomic,strong) IBOutlet UILabel * match_lbl;
@property(nonatomic,strong) IBOutlet UILabel * inns_lbl;
@property(nonatomic,strong) IBOutlet UILabel * runs_lbl;
@property(nonatomic,strong) IBOutlet UILabel * balls_lbl;
@property(nonatomic,strong) IBOutlet UILabel * sr_lbl;
@property(nonatomic,strong) IBOutlet UILabel * eco_lbl;
@property(nonatomic,strong) IBOutlet UILabel * threeWkt_lbl;
@property(nonatomic,strong) IBOutlet UILabel * avg_lbl;
@property(nonatomic,strong) IBOutlet UILabel * noBall_lbl;
@property(nonatomic,strong) IBOutlet UILabel * wides_lbl;
@property(nonatomic,strong) IBOutlet UILabel * wkt_lbl;
@end
