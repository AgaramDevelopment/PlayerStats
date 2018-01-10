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
@property (nonatomic,strong) IBOutlet UIView * searchView;

@property (nonatomic,strong) IBOutlet UIScrollView *barchartScroll;
@property (nonatomic,strong) IBOutlet UIButton *PP1Btn;
@property (nonatomic,strong) IBOutlet UIButton *PP2Btn;
@property (nonatomic,strong) IBOutlet UIButton *PP3Btn;
@end
