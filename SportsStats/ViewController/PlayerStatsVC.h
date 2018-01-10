//
//  PlayerStatsVC.h
//  SportsStats
//
//  Created by apple on 06/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeachView.h"
@interface PlayerStatsVC : UIViewController
@property (nonatomic,strong) IBOutlet SeachView * searchView;

@property (nonatomic,strong) IBOutlet UIScrollView *barchartScroll;
@property (nonatomic,strong) IBOutlet UIButton *PP1Btn;
@property (nonatomic,strong) IBOutlet UIButton *PP2Btn;
@property (nonatomic,strong) IBOutlet UIButton *PP3Btn;
@property (strong, nonatomic) IBOutlet UIView *filterView;
@property (strong, nonatomic) IBOutlet UIView *matchTypeView;
@property (strong, nonatomic) IBOutlet UIView *lastNYearView;
@property (strong, nonatomic) IBOutlet UIView *conditionView;
@property (strong, nonatomic) IBOutlet UIView *competitionView;
@property (strong, nonatomic) IBOutlet UIView *againstView;
@property (strong, nonatomic) IBOutlet UIView *inningsView;
@property (strong, nonatomic) IBOutlet UIView *matchResultView;
@end
