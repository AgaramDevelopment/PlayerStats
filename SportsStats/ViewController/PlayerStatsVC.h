//
//  PlayerStatsVC.h
//  SportsStats
//
//  Created by apple on 06/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeachView.h"
#import "ExpendedView.h"
@import Charts;

@interface PlayerStatsVC : UIViewController<ExpendDelegate>
//@property (nonatomic,strong) IBOutlet SeachView * searchView;
@property(nonatomic, strong) IBOutlet ExpendedView * objExpendView;



@property (nonatomic, strong) IBOutlet NSArray *optionsForHorizontal;
@property (nonatomic, strong) IBOutlet NSArray *optionsForVertical;

@property (weak, nonatomic) IBOutlet HorizontalBarChartView *viewHorizontalBar;
@property (weak, nonatomic) IBOutlet BarChartView *viewBarChart;

@property (nonatomic,strong) IBOutlet UIScrollView * vertcalScrolview;
@property (nonatomic,strong) IBOutlet UIScrollView * horizatalScrollview;
@property (nonatomic,strong) IBOutlet UIScrollView *barchartScroll;
@property (nonatomic,strong) IBOutlet UIButton *PP1Btn;
@property (nonatomic,strong) IBOutlet UIButton *PP2Btn;
@property (nonatomic,strong) IBOutlet UIButton *PP3Btn;
@property (strong, nonatomic) IBOutlet UILabel *filterLbl;


@property (strong, nonatomic) IBOutlet UIView *filterView;
@property (strong, nonatomic) IBOutlet UIView *matchTypeView;
@property (strong, nonatomic) IBOutlet UIView *lastNYearView;
@property (strong, nonatomic) IBOutlet UIView *conditionView;
@property (strong, nonatomic) IBOutlet UIView *competitionView;
@property (strong, nonatomic) IBOutlet UIView *againstView;
@property (strong, nonatomic) IBOutlet UIView *inningsView;
@property (strong, nonatomic) IBOutlet UIView *matchResultView;
@property (strong, nonatomic) IBOutlet UIView *venueTypeView;
@property (strong, nonatomic) IBOutlet UIButton *applyBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UILabel *matchTypeLbl;
@property (strong, nonatomic) IBOutlet UILabel *lastNYearLbl;
@property (strong, nonatomic) IBOutlet UILabel *conditionLbl;
@property (strong, nonatomic) IBOutlet UILabel *competitionLbl;
@property (strong, nonatomic) IBOutlet UILabel *againstLbl;
@property (strong, nonatomic) IBOutlet UILabel *inningsLbl;
@property (strong, nonatomic) IBOutlet UILabel *matchResultLbl;
@property (strong, nonatomic) IBOutlet UILabel *venueTypeLbl;

//mahesh
@property (nonatomic,strong) IBOutlet UILabel *runsPacelbl;
@property (nonatomic,strong) IBOutlet UILabel *ballsPacelbl;
@property (nonatomic,strong) IBOutlet UILabel *srPacelbl;
@property (nonatomic,strong) IBOutlet UILabel *wktsPacelbl;
@property (nonatomic,strong) IBOutlet UILabel *dbPacelbl;
@property (nonatomic,strong) IBOutlet UILabel *onesPacelbl;
@property (nonatomic,strong) IBOutlet UILabel *bdryperPacelbl;
@property (nonatomic,strong) IBOutlet UILabel *bdryFreqPacelbl;

@property (nonatomic,strong) IBOutlet UILabel *runsSpinlbl;
@property (nonatomic,strong) IBOutlet UILabel *ballsSpinlbl;
@property (nonatomic,strong) IBOutlet UILabel *srSpinlbl;
@property (nonatomic,strong) IBOutlet UILabel *wktsSpinlbl;
@property (nonatomic,strong) IBOutlet UILabel *dbSpinlbl;
@property (nonatomic,strong) IBOutlet UILabel *onesSpinlbl;
@property (nonatomic,strong) IBOutlet UILabel *bdryperSpinlbl;
@property (nonatomic,strong) IBOutlet UILabel *bdryFreqSpinlbl;


//@property (weak, nonatomic) IBOutlet HorizontalBarChartView *viewHorizontalBar;
//@property (weak, nonatomic) IBOutlet BarChartView *viewBarChart;
//@property (nonatomic, strong) IBOutlet NSArray *optionsForHorizontal;
//@property (nonatomic, strong) IBOutlet NSArray *optionsForVertical;
@property (readwrite, strong) NSString* SelectedPlayerCode;

@property(nonatomic, strong) IBOutlet UIImageView * playerimage;

@property (nonatomic,strong) IBOutlet UILabel *playernamelbl;
@property (nonatomic,strong) IBOutlet UILabel *playerCountrylbl;
@property (nonatomic,strong) IBOutlet UILabel *playerTypelbl;
@property (nonatomic,strong) IBOutlet UILabel *playerStylelbl;

@property (nonatomic,strong) IBOutlet UILabel *recentFormBall1;
@property (nonatomic,strong) IBOutlet UILabel *recentFormBall2;
@property (nonatomic,strong) IBOutlet UILabel *recentFormBall3;
@property (nonatomic,strong) IBOutlet UILabel *recentFormBall4;
@property (nonatomic,strong) IBOutlet UILabel *recentFormBall5;

@property (nonatomic,strong) IBOutlet UIButton *battingBtn;
@property (nonatomic,strong) IBOutlet UIButton *bowlingBtn;
@property (strong, nonatomic) IBOutlet UIView *topViewShadow;


@property (nonatomic,strong) IBOutlet UIProgressView *runsPrgss;
@property (nonatomic,strong) IBOutlet UIProgressView *ballsPrgss;
@property (nonatomic,strong) IBOutlet UIProgressView *srPrgss;
@property (nonatomic,strong) IBOutlet UIProgressView *wktsPrgss;
@property (nonatomic,strong) IBOutlet UIProgressView *dbPrgss;
@property (nonatomic,strong) IBOutlet UIProgressView *onesPrgss;
@property (nonatomic,strong) IBOutlet UIProgressView *bdryPrgss;
@property (nonatomic,strong) IBOutlet UIProgressView *bdryFreqPrgss;

@end
