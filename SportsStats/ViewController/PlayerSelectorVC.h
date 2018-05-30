//
//  PlayerSelectorVC.h
//  SportsStats
//
//  Created by apple on 06/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerSelectorVC : UIViewController
@property (strong, nonatomic) IBOutlet UIView *dropDownView;
@property (strong, nonatomic) IBOutlet UILabel *playerOrderLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *battingStyleLbl;
@property (strong, nonatomic) IBOutlet UILabel *bowlingStyleLbl;
@property (strong, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UILabel *lblBattingOrder;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionPlayerList;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UICollectionView *lblNoData;

@property (weak, nonatomic) IBOutlet UIView *tapView;
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *FilterViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *lblCompetetionName;


@end
