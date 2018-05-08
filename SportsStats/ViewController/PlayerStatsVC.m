//
//  PlayerStatsVC.m
//  SportsStats
//
//  Created by apple on 06/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import "PlayerStatsVC.h"
#import "ExpendedView.h"
#import "CustomNavigation.h"
#import "SeachView.h"
#import "MCBarChartView.h"
#import "HACBarChart.h"
#import "WebService.h"
#import "Config.h"
#import "AppCommon.h"
#import "DayAxisValueFormatter.h"
#import "HorizontalXLblFormatter.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlayerStatsVC ()<MCBarChartViewDelegate,MCBarChartViewDataSource,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource,ExpendDelegate>
{
    NSArray *data3;
    NSArray *values;
    NSMutableArray *myarray;
    
    NSString * yValue;
    NSString * zValue;

    NSMutableArray *playerArray;

    UITableView *dropDownTblView;
    CustomNavigation * objCustomNavigation;
    
    NSMutableArray *playerStaticArray;
    NSMutableArray *playerDropDownArray;
    
    BOOL isMatchTypeOpen;
    BOOL isLastNYearsOpen;
    BOOL isConditionOpen;
    BOOL isCompetitionOpen;
    BOOL isAgainstOpen;
    BOOL isInningsOpen;
    BOOL isMatchResultOpen;
    BOOL isVenueTypeOpen;
    NSString *matchTypeCode, *lastNYearsCode, *conditionCode, *competitionCode, *againstCode, *inningsCode, *matchResultCode, *venueTypeCode;

}
@property (nonatomic,strong)  NSArray *ylist;
@property (nonatomic,strong)  NSArray *zlist;
@property (strong, nonatomic) NSArray * titles_1;

@property (weak, nonatomic) IBOutlet HACBarChart *chart3;
@property (strong, nonatomic) MCBarChartView * BarChartView;

@property(nonatomic,strong) NSMutableArray *tableDataArray;
@property(assign) BOOL searchEnabled;
@property (nonatomic,strong) IBOutlet UITableView * search_Tbl;
//@property (nonatomic,strong) IBOutlet UISearchBar * search_Bar;
@property (nonatomic, strong) NSArray *searchResult;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * horzaticalscrolheight;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * horzaticalScrolWidth;
@property (nonatomic,strong) IBOutlet UIView * BattingViewHeader;
@property (nonatomic,strong) IBOutlet UIView * BowlingViewHeader;


//mahesh
@property (strong, nonatomic) NSMutableArray * PlayerDetailsArray;
@property (strong, nonatomic) NSMutableArray * PlayerCompetitionArray;
@property (strong, nonatomic) NSMutableArray * PaceArray;
@property (strong, nonatomic) NSMutableArray * SpinArray;
@property (strong, nonatomic) NSMutableArray * PaceArray2;
@property (strong, nonatomic) NSMutableArray * SpinArray2;
@property (strong, nonatomic) NSMutableArray * PaceArray3;
@property (strong, nonatomic) NSMutableArray * SpinArray3;
@property (strong, nonatomic) NSMutableArray * ComfortArray;
@property (strong, nonatomic) NSMutableArray * PositionArray;
@property (strong, nonatomic) NSMutableArray * CompetitionArray;
@property (strong, nonatomic) NSMutableArray * AgainstTeamArray;
@property (strong, nonatomic) NSMutableArray * recentFormArray;
@property (strong, nonatomic) NSMutableArray * playerBowlingArray;
@property (strong, nonatomic) NSMutableArray * playersSearchListArray;
@property (strong, nonatomic) NSMutableArray * playerBasicDetailsArray;
@property (strong,nonatomic) NSMutableArray  *  playerBowlingDetaillistArray;

@end

@implementation PlayerStatsVC
@synthesize viewHorizontalBar,viewBarChart;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Shadow
    
    _topViewShadow.clipsToBounds = NO;
    _topViewShadow.layer.shadowColor = [[UIColor blackColor] CGColor];
    _topViewShadow.layer.shadowOffset = CGSizeMake(3,3);
    _topViewShadow.layer.shadowOpacity = 0.1;
    
    [self customnavigationmethod];
    
    self.BattingViewHeader.hidden = NO;
    self.BowlingViewHeader.hidden = YES;

   // [self.battingBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    matchTypeCode= @"";
    lastNYearsCode=@"";
    conditionCode= @"";
    competitionCode=@"";
    againstCode=@"";
    inningsCode=@"";
    matchResultCode=@"";
    venueTypeCode=@"";
    
    self.recentFormBall1.layer.masksToBounds = true;
    self.recentFormBall1.clipsToBounds = true;
    self.recentFormBall1.layer.cornerRadius = self.recentFormBall1.frame.size.width/2;
    
    self.recentFormBall2.layer.masksToBounds = true;
    self.recentFormBall2.clipsToBounds = true;
    self.recentFormBall2.layer.cornerRadius = self.recentFormBall1.frame.size.width/2;
    
    self.recentFormBall3.layer.masksToBounds = true;
    self.recentFormBall3.clipsToBounds = true;
    self.recentFormBall3.layer.cornerRadius = self.recentFormBall1.frame.size.width/2;
    
    self.recentFormBall4.layer.masksToBounds = true;
    self.recentFormBall4.clipsToBounds = true;
    self.recentFormBall4.layer.cornerRadius = self.recentFormBall1.frame.size.width/2;
    
    self.recentFormBall5.layer.masksToBounds = true;
    self.recentFormBall5.clipsToBounds = true;
    self.recentFormBall5.layer.cornerRadius = self.recentFormBall1.frame.size.width/2;
    
    
    
    self.vertcalScrolview.contentSize  = CGSizeMake(0,900);
    self.horizatalScrollview.contentSize = CGSizeMake(1600,300);
    lastNYearsCode = @"3";
    self.filterView.hidden = YES;
    playerDropDownArray = [[NSMutableArray alloc] init];
    playerStaticArray = [[NSMutableArray alloc] initWithObjects:
                         @[
                           @{
                               @"name":@"T20I",
                               @"code":@"MSC024"
                               },
                           @{
                               @"name":@"T20",
                               @"code":@"MSC116"
                               },
                           @{
                               @"name":@"All",
                               @"code":@"All"
                               }
                           ],
                         @[
                           @{
                               @"name":@"1 Year",
                               @"code":@"1"
                               },
                           @{
                               @"name":@"2 Years",
                               @"code":@"2"
                               },
                           @{
                               @"name":@"3 Years",
                               @"code":@"3"
                               },
                           @{
                               @"name":@"All",
                               @"code":@"3"
                               }
                           ],
                         @[
                           @{
                               @"name":@"Ireland",
                               @"code":@"Ireland"
                               },
                           @{
                               @"name":@"New Zealand",
                               @"code":@"New Zealand"
                               },
                           @{
                               @"name":@"Northern Ireland",
                               @"code":@"Northern Ireland"
                               },
                           @{
                               @"name":@"South Africa",
                               @"code":@"South Africa"
                               },
                           @{
                               @"name":@"USA",
                               @"code":@"United States Of America"
                               },
                           @{
                               @"name":@"Zimbabwe",
                               @"code":@"Zimbabwe"
                               },
                           @{
                               @"name":@"Australia",
                               @"code":@"Australia"
                               },
                           @{
                               @"name":@"England",
                               @"code":@"England"
                               },
                           @{
                               @"name":@"Subcontinent",
                               @"code":@"Subcontinent"
                               },
                           @{
                               @"name":@"All",
                               @"code":@"All"
                               }
                           ],
                         @[
                           @{
                               @"name":@"1st",
                               @"code":@"1"
                               },
                           @{
                               @"name":@"2nd",
                               @"code":@"2"
                               },
                           @{
                               @"name":@"All",
                               @"code":@"All"
                               }
                           ],
                         @[
                           @{
                               @"name":@"Win",
                               @"code":@"MSC228"
                               },
                           @{
                               @"name":@"Foreign",
                               @"code":@"MSC229"
                               },
                           @{
                               @"name":@"Loss",
                               @"code":@"Loss"
                               },
                           @{
                               @"name":@"All",
                               @"code":@"All"
                               }
                           ],
                         @[
                           @{
                               @"name":@"Batting Dominated",
                               @"code":@"Batting"
                               },
                           @{
                               @"name":@"Bowling Dominated",
                               @"code":@"Bowling"
                               },
                           @{
                               @"name":@"Spin Dominated",
                               @"code":@"Spin"
                               },
                           @{
                               @"name":@"Fast Dominated",
                               @"code":@"Fast"
                               },
                           @{
                               @"name":@"All",
                               @"code":@"All"
                               }
                           ],nil
                         ];
    
    isMatchTypeOpen = NO;
    isLastNYearsOpen = NO;
    isConditionOpen = NO;
    isCompetitionOpen = NO;
    isAgainstOpen = NO;
    isInningsOpen = NO;
    isMatchResultOpen = NO;
    isVenueTypeOpen = NO;
    dropDownTblView = [[UITableView alloc]init];
    dropDownTblView.dataSource = self;
    dropDownTblView.delegate = self;
    [self ChartViewMethod];
    //_searchView.frame=[self setFramrToMenuViewWithXposition:100];
    [self SearchViewMethod];
    //self.objExpendView =[[ExpendedView alloc]init];
    //self.objExpendView.delegate = self;
    _objExpendView.delegate = self;

    UIBezierPath *path = [UIBezierPath new];
    
    [path moveToPoint:(CGPoint){self.applyBtn.frame.size.width,0 }];//w0
    [path addLineToPoint:(CGPoint){0, 0}];//00
    [path addLineToPoint:(CGPoint){0,self.applyBtn.frame.size.height }];//0h
    [path addLineToPoint:(CGPoint){self.applyBtn.frame.size.width-25, self.applyBtn.frame.size.height}];//wh20
    
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = self.applyBtn.bounds;
    mask.path = path.CGPath;
    self.applyBtn.layer.mask = mask;
    
    
    UIBezierPath *path1 = [UIBezierPath new];
    
    [path1 moveToPoint:(CGPoint){self.cancelBtn.frame.size.width,0 }];//w0
    [path1 addLineToPoint:(CGPoint){25, 0}];//00
    [path1 addLineToPoint:(CGPoint){0,self.cancelBtn.frame.size.height }];//0h
    [path1 addLineToPoint:(CGPoint){self.cancelBtn.frame.size.width, self.cancelBtn.frame.size.height}];//wh20
    
    CAShapeLayer *mask1 = [CAShapeLayer new];
    mask1.frame = self.cancelBtn.bounds;
    mask1.path = path1.CGPath;
    self.cancelBtn.layer.mask = mask1;
    
    [self PlayerDetailsWebservice];
    
    
    
    self.optionsForHorizontal = @[
                                  @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                                  @{@"key": @"toggleIcons", @"label": @"Toggle Icons"},
                                  @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                                  @{@"key": @"animateX", @"label": @"Animate X"},
                                  @{@"key": @"animateY", @"label": @"Animate Y"},
                                  @{@"key": @"animateXY", @"label": @"Animate XY"},
                                  @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                                  @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                                  @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
                                  @{@"key": @"toggleData", @"label": @"Toggle Data"},
                                  @{@"key": @"toggleBarBorders", @"label": @"Show Bar Borders"},
                                  ];
    
    self.optionsForVertical = @[
                                @{@"key": @"toggleValues", @"label": @"Toggle Values"},
                                @{@"key": @"toggleIcons", @"label": @"Toggle Icons"},
                                @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
                                @{@"key": @"animateX", @"label": @"Animate X"},
                                @{@"key": @"animateY", @"label": @"Animate Y"},
                                @{@"key": @"animateXY", @"label": @"Animate XY"},
                                @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
                                @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
                                @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
                                @{@"key": @"toggleData", @"label": @"Toggle Data"},
                                @{@"key": @"toggleBarBorders", @"label": @"Show Bar Borders"},
                                ];
    
    
    
}

-(void)horzaticalscrollviewHeightMethod:(double)height
{
    _horzaticalscrolheight.constant = height;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

-(void)SearchViewMethod
{
//    _tableDataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
//
//    self.searchResult = [NSMutableArray arrayWithCapacity:[_tableDataArray count]];
//    self.search_Tbl.hidden=YES;
    
    self.searchResult = [NSMutableArray arrayWithCapacity:[self.playersSearchListArray count]];
    self.search_Tbl.hidden=YES;
}
-(void)customnavigationmethod
{
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation_iPad" bundle:nil];
    [self.view addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Player Stats";
    objCustomNavigation.nav_header_img.image = [UIImage imageNamed:@"withText"];
    objCustomNavigation.nav_header_img.backgroundColor = [UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    objCustomNavigation.btn_back.hidden = NO;
    objCustomNavigation.filter_btn.hidden = YES;
    objCustomNavigation.Cancelbtn.hidden = YES;
    objCustomNavigation.nav_search_view.hidden = NO;
    objCustomNavigation.objSearchBar.delegate = self;

    [objCustomNavigation.btn_back addTarget:self action:@selector(BackBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(CGRect)setFramrToMenuViewWithXposition:(NSInteger)position{
    CGRect frame;
    frame.origin.x=position;
//    frame.origin.y=self.searchView.frame.origin.y+10;
//    frame.size.height=self.searchView.frame.size.height;
//    frame.size.width=self.searchView.frame.size.width;
//
    return frame;
}
#pragma Chart view
-(void)ChartViewMethod
{
    
    data3 =[[NSMutableArray alloc]init];
    
    self.ylist =[[NSMutableArray alloc]init];
    self.zlist =[[NSMutableArray alloc]init];
    
    self.ylist = @[@"20",@"30",@"50",@"40"];
    self.zlist = @[@"2",@"4",@"5",@"6"];
    
    data3 =  @[
               @{kHACPercentage:@20, kHACColor  : [UIColor redColor], kHACCustomText :@"RAF"},
               @{kHACPercentage:@30, kHACColor  : [UIColor redColor], kHACCustomText :@"LAF"},
               @{kHACPercentage:@10, kHACColor  : [UIColor redColor], kHACCustomText :@"RAOS"},
               @{kHACPercentage:@50, kHACColor  : [UIColor redColor], kHACCustomText :@"RALS"},
               @{kHACPercentage:@60, kHACColor  : [UIColor redColor], kHACCustomText :@"LAOS"},
               @{kHACPercentage:@40, kHACColor  : [UIColor redColor], kHACCustomText :@"LACM"}
               
               ];
    
    
    
    NSLog(@"%@", data3);
    
    _chart3.showAxis                 = YES;   // Show axis line
    _chart3.showProgressLabel        = YES;   // Show text for bar
    _chart3.vertical                 = NO;   // Orientation chart
    _chart3.reverse                  = NO;   // Orientation chart
    _chart3.showDataValue            = YES;   // Show value contains _data, or real percent value
    _chart3.showCustomText           = YES;   // Show custom text, in _data with key kHACCustomText
    _chart3.barsMargin               = 80;     // Margin between bars
    _chart3.sizeLabelProgress        = 30;    // Width of label progress text
    //  _chart3.numberDividersAxisY      = 8;
    _chart3.animationDuration        = 2;
    // _chart3.axisMaxValue             = 100;    // If no define maxValue, get maxium of _data
    _chart3.progressTextColor        = [UIColor blackColor];
    _chart3.axisYTextColor           = [UIColor blackColor];
    _chart3.progressTextFont         = [UIFont fontWithName:@"DINCondensed-Bold" size:12];
    _chart3.typeBar                  = HACBarType1;
    _chart3.dashedLineColor          = [UIColor blueColor];
    _chart3.axisXColor               = [UIColor blackColor];
    _chart3.axisYColor               = [UIColor blackColor];
    _chart3.axisFormat               = HACAxisFormatInt;
    
    _chart3.data = data3;
    
    ////// CHART SET DATA
    [_chart3 draw];
    
    
    [self BarChartMethod];
    [self.PP1Btn sendActionsForControlEvents:UIControlEventTouchUpInside];
}
-(void) BarChartMethod
{
    if(self.BarChartView != nil)
    {
        
        [self.BarChartView removeFromSuperview];
    }
    NSMutableArray * runValue=[[NSMutableArray alloc]init];
    // self.datelist =[[NSMutableArray alloc]init];
    //self.datelist =[self.detailslist valueForKey:@"wellnessdate"];
    
    
    //self.ratinglist =[[NSMutableArray alloc]init];
    //self.ratinglist =[self.detailslist valueForKey:@"wellnessrating"];
    
    runValue =self.ylist;
    
    id max = [self.ylist valueForKeyPath:@"@max.intValue"];
    
    
    _titles_1 = self.zlist;
    
    self.BarChartView = [[MCBarChartView alloc] initWithFrame:CGRectMake(20,10, self.barchartScroll.frame.size.width, self.barchartScroll.frame.size.height)];
    
    
    ///self.BarChartView.tag = 111;
    self.BarChartView.dataSource = self;
    self.BarChartView.delegate = self;
    self.BarChartView.maxValue = max;
    
    self.BarChartView.colorOfXAxis = [UIColor blackColor];
    self.BarChartView.colorOfXText = [UIColor blackColor];
    self.BarChartView.colorOfYAxis = [UIColor blackColor];
    self.BarChartView.colorOfYText = [UIColor blackColor];
    [self.barchartScroll addSubview:self.BarChartView];
    
}

#pragma Filter Button Action

//- (IBAction)onClickFilterButton:(id)sender {
//    self.filterView.hidden = NO;
//}
//
//- (IBAction)onClickMatchType:(id)sender {
//    dropDownTblView.frame = CGRectMake(self.matchTypeView.frame.origin.x+40, self.matchTypeView.frame.origin.y+self.matchTypeView.frame.size.height+190, self.matchTypeView.frame.size.width, playerArray.count >= 5 ? 150 : playerArray.count*30);
//    //  dropDownTblView=[[UITableView alloc]initWithFrame:CGRectMake(self.matchTypeBtn.frame.origin.x+16+518, self.matchTypeBtn.frame.origin.y+60+80,150,228)];
//    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//    [self.view addSubview:dropDownTblView];
//
//}
//
//- (IBAction)onClickLastNYear:(id)sender {
//    dropDownTblView.frame = CGRectMake(self.lastNYearView.frame.origin.x+40, self.lastNYearView.frame.origin.y + self.lastNYearView.frame.size.height + 190,self.lastNYearView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
//    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//    [self.view addSubview:dropDownTblView];
//}
//
//- (IBAction)onClickCondition:(id)sender {
//    dropDownTblView.frame = CGRectMake(self.conditionView.frame.origin.x+40, self.conditionView.frame.origin.y + self.conditionView.frame.size.height + 190,self.conditionView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
//    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//    [self.view addSubview:dropDownTblView];
//}
//
//- (IBAction)onClickCompetition:(id)sender {
//    dropDownTblView.frame = CGRectMake(self.competitionView.frame.origin.x+40, self.competitionView.frame.origin.y + self.competitionView.frame.size.height + 190,self.competitionView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
//    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//    [self.view addSubview:dropDownTblView];
//}
//
//- (IBAction)onClickAgainst:(id)sender {
//    dropDownTblView.frame = CGRectMake(self.againstView.frame.origin.x+155, self.againstView.frame.origin.y + self.againstView.frame.size.height + 295,self.againstView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
//    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//    [self.view addSubview:dropDownTblView];
//}
//
//- (IBAction)onClickInnings:(id)sender {
//    dropDownTblView.frame = CGRectMake(self.inningsView.frame.origin.x+155, self.inningsView.frame.origin.y + self.inningsView.frame.size.height + 295,self.inningsView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
//    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//    [self.view addSubview:dropDownTblView];
//}
//
//- (IBAction)onClickMatchResult:(id)sender {
//    dropDownTblView.frame = CGRectMake(self.matchResultView.frame.origin.x+155, self.matchResultView.frame.origin.y + self.matchResultView.frame.size.height + 295,self.matchResultView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
//    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//    [self.view addSubview:dropDownTblView];
//}
//
//- (IBAction)okButtonTapped:(id)sender {
//    self.filterView.hidden = YES;
//
//    if(dropDownTblView!=nil){
//        [dropDownTblView removeFromSuperview];
//    }
//}
//
//- (IBAction)cancelButtonTapped:(id)sender {
//    self.filterView.hidden = YES;
//    if(dropDownTblView!=nil){
//        [dropDownTblView removeFromSuperview];
//    }
//}

- (NSInteger)numberOfSectionsInBarChartView:(MCBarChartView *)barChartView {
    
    
    //if (barChartView == self.BarChartView) {
    return [self.zlist count];
    //}
    
    //return [_dataSource count];
    
    
}

- (NSInteger)barChartView:(MCBarChartView *)barChartView numberOfBarsInSection:(NSInteger)section {
    
    //    if(barChartView == self.BarChartView)
    //    {
    return [self.ylist  count];
    //}
    
    //return nil;
}

- (id)barChartView:(MCBarChartView *)barChartView valueOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    // if (barChartView == self.BarChartView) {
    
    return self.ylist [section];
    
    //}
    
    
    
    //return nil;
    
}

- (UIColor *)barChartView:(MCBarChartView *)barChartView colorOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    
    //if (index == 0) {
    return [UIColor redColor];
    //}
    //return [UIColor colorWithRed:(35/255.0f) green:(116/255.0f) blue:(203/255.0f) alpha:1.0];
    
}

- (NSString *)barChartView:(MCBarChartView *)barChartView titleOfBarInSection:(NSInteger)section {
    
    //if (barChartView ==  self.BarChartView) {
    
    return _titles_1[section];
    
    //}
    //return nil;
    
}

- (NSString *)barChartView:(MCBarChartView *)barChartView informationOfBarInSection:(NSInteger)section index:(NSInteger)index {
    
    return nil;
}

//- (NSMutableArray *)barChartView:(MCBarChartView *)barChartView informationOfWicketInSection:(NSInteger)section
//{
//    if(barChartView == self.BarChartView)
//    {
//        return com2Wicket;
//    }
//    else if(barChartView == self.barChartView_2)
//    {
//        return com3inningsWicket;
//    }
//    return nil;
//}


- (CGFloat)barWidthInBarChartView:(MCBarChartView *)barChartView {
    
    return 8;
    
}

- (CGFloat)paddingForSectionInBarChartView:(MCBarChartView *)barChartView {
    return 40;
    
}

-(void) setInningsBySelection: (NSString*) innsNo{
    
    [self setInningsButtonUnselect:self.PP1Btn];
    [self setInningsButtonUnselect:self.PP2Btn];
    [self setInningsButtonUnselect:self.PP3Btn];
    
    if([innsNo isEqualToString:@"1"]){
        
        [self setInningsButtonSelect:self.PP1Btn];
        
    }else if([innsNo isEqualToString:@"2"]){
        
        [self setInningsButtonSelect:self.PP2Btn];
    }
    else if([innsNo isEqualToString:@"3"]){
        
        [self setInningsButtonSelect:self.PP3Btn];
    }
    
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}
-(void) setInningsButtonSelect : (UIButton*) innsBtn{
    // innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#0D2B81"];
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    [innsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void) setInningsButtonUnselect : (UIButton*) innsBtn{
      //innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#F2F2F2"];
    
   //UIColor *extrasBrushBG = [UIColor colorWithRed:(63/255.0f) green:(63/255.0f) blue:(65/255.0f) alpha:1.0f] ;
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    [innsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

-(IBAction)PP1Action:(id)sender
{
    [self setInningsBySelection:@"1"];
    
    if(_PaceArray!=nil && self.PaceArray.count>0)
    {
        
        NSArray *runsArray = [[[self.PaceArray valueForKey:@"PaceRunsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * runsPercentage = runsArray[0];
        self.runsPrgss.progress = [runsPercentage floatValue]/100 ;
        
//        UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, -5, 50, 20)];
//        fromLabel.numberOfLines = 1;
//        fromLabel.baselineAdjustment = YES;
//        fromLabel.adjustsFontSizeToFitWidth = YES;
//        fromLabel.adjustsLetterSpacingToFitWidth = YES;
//        fromLabel.clipsToBounds = YES;
//        fromLabel.text = [[self.PaceArray valueForKey:@"PaceRuns"] objectAtIndex:0];
//        fromLabel.backgroundColor = [UIColor clearColor];
//        fromLabel.textColor = [UIColor whiteColor];
//        fromLabel.textAlignment = NSTextAlignmentRight;
//        [self.runsPrgss addSubview:fromLabel];
        
        
        
        
        
        NSArray *ballsArray = [[[self.PaceArray valueForKey:@"PaceBallsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * ballsPercentage = ballsArray[0];
        self.ballsPrgss.progress = [ballsPercentage floatValue]/100 ;
        
        
        NSArray *wktsArray = [[[self.PaceArray valueForKey:@"PaceWktsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * wktsPercentage = wktsArray[0];
        self.wktsPrgss.progress = [wktsPercentage floatValue]/100 ;
        
        
        NSArray *srArray = [[[self.PaceArray valueForKey:@"PaceSRWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * srPercentage = srArray[0];
        self.srPrgss.progress = [srPercentage floatValue]/100 ;
        
        
        
        NSArray *dbArray = [[[self.PaceArray valueForKey:@"PaceDbWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * dbPercentage = dbArray[0];
        self.srPrgss.progress = [dbPercentage floatValue]/100 ;
        
        
        NSArray *onesArray = [[[self.PaceArray valueForKey:@"PaceOnesWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * onesPercentage = onesArray[0];
        self.onesPrgss.progress = [onesPercentage floatValue]/100 ;
        
        
        
        NSArray *bdryArray = [[[self.PaceArray valueForKey:@"PaceBdryWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * bdryPercentage = bdryArray[0];
        self.bdryPrgss.progress = [bdryPercentage floatValue]/100 ;
        
        
        NSArray *bdryfreqArray = [[[self.PaceArray valueForKey:@"PaceBdryFreqWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * bdryfreqPercentage = bdryfreqArray[0];
        self.bdryPrgss.progress = [bdryfreqPercentage floatValue]/100 ;
        
        self.runsPacelbl.text = [[self.PaceArray valueForKey:@"PaceRuns"] objectAtIndex:0];
        self.ballsPacelbl.text = [[self.PaceArray valueForKey:@"PaceBalls"] objectAtIndex:0];
        self.srPacelbl.text = [[self.PaceArray valueForKey:@"PaceSR"] objectAtIndex:0];
        self.wktsPacelbl.text = [[self.PaceArray valueForKey:@"PaceWkts"] objectAtIndex:0];
        self.dbPacelbl.text = [[self.PaceArray valueForKey:@"PaceDb"] objectAtIndex:0];
        self.onesPacelbl.text = [[self.PaceArray valueForKey:@"PaceOnes"] objectAtIndex:0];
        self.bdryperPacelbl.text = [[self.PaceArray valueForKey:@"PaceBdry"] objectAtIndex:0];
        self.bdryFreqPacelbl.text = [[self.PaceArray valueForKey:@"PaceBdryFreq"] objectAtIndex:0];
    }
    
    if(self.SpinArray!=nil &&  self.SpinArray.count>0)
    {
        
        self.runsSpinlbl.text = [[self.SpinArray valueForKey:@"SpinRuns"] objectAtIndex:0];

        self.ballsSpinlbl.text = [[self.SpinArray valueForKey:@"SpinBalls"] objectAtIndex:0];

        self.srSpinlbl.text = [[self.SpinArray valueForKey:@"SpinSR"] objectAtIndex:0];

        self.wktsSpinlbl.text = [[self.SpinArray valueForKey:@"SpinWkts"] objectAtIndex:0];

        self.dbSpinlbl.text = [[self.SpinArray valueForKey:@"SpinDb"] objectAtIndex:0];

        self.onesSpinlbl.text = [[self.SpinArray valueForKey:@"SpinOnes"] objectAtIndex:0];

        self.bdryperSpinlbl.text = [[self.SpinArray valueForKey:@"SpinBdry"] objectAtIndex:0];

        self.bdryFreqSpinlbl.text = [[self.SpinArray valueForKey:@"SpinBdryFreq"] objectAtIndex:0];
    }
}
-(IBAction)PP2Action:(id)sender
{
    [self setInningsBySelection:@"2"];
    if(self.PaceArray2!=nil && self.PaceArray2.count>0)
    {
        
        NSArray *runsArray = [[[self.PaceArray2 valueForKey:@"PaceRunsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * runsPercentage = runsArray[0];
        self.runsPrgss.progress = [runsPercentage floatValue]/100 ;
        
        
        NSArray *ballsArray = [[[self.PaceArray2 valueForKey:@"PaceBallsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * ballsPercentage = ballsArray[0];
        self.ballsPrgss.progress = [ballsPercentage floatValue]/100 ;
        
        
        NSArray *wktsArray = [[[self.PaceArray2 valueForKey:@"PaceWktsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * wktsPercentage = wktsArray[0];
        self.wktsPrgss.progress = [wktsPercentage floatValue]/100 ;
        
        
        NSArray *srArray = [[[self.PaceArray2 valueForKey:@"PaceSRWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * srPercentage = srArray[0];
        self.srPrgss.progress = [srPercentage floatValue]/100 ;
        
        
        
        NSArray *dbArray = [[[self.PaceArray2 valueForKey:@"PaceDbWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * dbPercentage = dbArray[0];
        self.srPrgss.progress = [dbPercentage floatValue]/100 ;
        
        
        NSArray *onesArray = [[[self.PaceArray2 valueForKey:@"PaceOnesWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * onesPercentage = onesArray[0];
        self.onesPrgss.progress = [onesPercentage floatValue]/100 ;
        
        
        
        NSArray *bdryArray = [[[self.PaceArray2 valueForKey:@"PaceBdryWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * bdryPercentage = bdryArray[0];
        self.bdryPrgss.progress = [bdryPercentage floatValue]/100 ;
        
        
        NSArray *bdryfreqArray = [[[self.PaceArray2 valueForKey:@"PaceBdryFreqWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * bdryfreqPercentage = bdryfreqArray[0];
        self.bdryPrgss.progress = [bdryfreqPercentage floatValue]/100 ;
        
        
        
        self.runsPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceRuns"] objectAtIndex:0];
        self.ballsPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceBalls"] objectAtIndex:0];
        self.srPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceSR"] objectAtIndex:0];
        self.wktsPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceWkts"] objectAtIndex:0];
        self.dbPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceDb"] objectAtIndex:0];
        self.onesPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceOnes"] objectAtIndex:0];
        self.bdryperPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceBdry"] objectAtIndex:0];
        self.bdryFreqPacelbl.text = [[self.PaceArray2 valueForKey:@"PaceBdryFreq"] objectAtIndex:0];
        
    }
    
    if(self.SpinArray2!=nil && self.SpinArray2.count>0)
    {
        
        self.runsSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinRuns"] objectAtIndex:0];
        
        self.ballsSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinBalls"] objectAtIndex:0];
        
        self.srSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinSR"] objectAtIndex:0];
        
        self.wktsSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinWkts"] objectAtIndex:0];
        
        self.dbSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinDb"] objectAtIndex:0];
        
        self.onesSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinOnes"] objectAtIndex:0];
        
        self.bdryperSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinBdry"] objectAtIndex:0];
        
        self.bdryFreqSpinlbl.text = [[self.SpinArray2 valueForKey:@"SpinBdryFreq"] objectAtIndex:0];
    }
}
-(IBAction)PP3Action:(id)sender
{
    [self setInningsBySelection:@"3"];
    
    if(self.PaceArray3!=nil && self.PaceArray3.count>0)
    {
        
        NSArray *runsArray = [[[self.PaceArray3 valueForKey:@"PaceRunsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * runsPercentage = runsArray[0];
        self.runsPrgss.progress = [runsPercentage floatValue]/100 ;
        
        
        NSArray *ballsArray = [[[self.PaceArray3 valueForKey:@"PaceBallsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * ballsPercentage = ballsArray[0];
        self.ballsPrgss.progress = [ballsPercentage floatValue]/100 ;
        
        
        NSArray *wktsArray = [[[self.PaceArray3 valueForKey:@"PaceWktsWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * wktsPercentage = wktsArray[0];
        self.wktsPrgss.progress = [wktsPercentage floatValue]/100 ;
        
        
        NSArray *srArray = [[[self.PaceArray3 valueForKey:@"PaceSRWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * srPercentage = srArray[0];
        self.srPrgss.progress = [srPercentage floatValue]/100 ;
        
        
        
        NSArray *dbArray = [[[self.PaceArray3 valueForKey:@"PaceDbWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * dbPercentage = dbArray[0];
        self.srPrgss.progress = [dbPercentage floatValue]/100 ;
        
        
        NSArray *onesArray = [[[self.PaceArray3 valueForKey:@"PaceOnesWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * onesPercentage = onesArray[0];
        self.onesPrgss.progress = [onesPercentage floatValue]/100 ;
        
        
        
        NSArray *bdryArray = [[[self.PaceArray3 valueForKey:@"PaceBdryWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * bdryPercentage = bdryArray[0];
        self.bdryPrgss.progress = [bdryPercentage floatValue]/100 ;
        
        
        NSArray *bdryfreqArray = [[[self.PaceArray3 valueForKey:@"PaceBdryFreqWidth"] objectAtIndex:0] componentsSeparatedByString:@"%"];
        NSString * bdryfreqPercentage = bdryfreqArray[0];
        self.bdryPrgss.progress = [bdryfreqPercentage floatValue]/100 ;
        
        
        
        self.runsPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceRuns"] objectAtIndex:0];
        self.ballsPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceBalls"] objectAtIndex:0];
        self.srPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceSR"] objectAtIndex:0];
        self.wktsPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceWkts"] objectAtIndex:0];
        self.dbPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceDb"] objectAtIndex:0];
        self.onesPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceOnes"] objectAtIndex:0];
        self.bdryperPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceBdry"] objectAtIndex:0];
        self.bdryFreqPacelbl.text = [[self.PaceArray3 valueForKey:@"PaceBdryFreq"] objectAtIndex:0];
        
    }
    
    if(self.SpinArray3!=nil && self.SpinArray3.count>0)
    {
        
        self.runsSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinRuns"] objectAtIndex:0];
        
        self.ballsSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinBalls"] objectAtIndex:0];
        
        self.srSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinSR"] objectAtIndex:0];
        
        self.wktsSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinWkts"] objectAtIndex:0];
        
        self.dbSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinDb"] objectAtIndex:0];
        
        self.onesSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinOnes"] objectAtIndex:0];
        
        self.bdryperSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinBdry"] objectAtIndex:0];
        
        self.bdryFreqSpinlbl.text = [[self.SpinArray3 valueForKey:@"SpinBdryFreq"] objectAtIndex:0];
    }
}

#pragma Filter Button Action
- (IBAction)onClickFilterButton:(id)sender {
    self.filterView.hidden = NO;
    _lastNYearLbl.text = lastNYearsCode;
    
//    self.matchTypeLbl.text = @"";
//    self.lastNYearLbl.text = @"";
//    self.conditionLbl.text = @"";
//    self.competitionLbl.text = @"";
//    self.againstLbl.text = @"";
//    self.inningsLbl.text = @"";
//    self.matchResultLbl.text = @"";
//    self.venueTypeLbl.text = @"";
}

- (IBAction)onClickMatchType:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isMatchTypeOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isMatchTypeOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: [playerStaticArray objectAtIndex:0]];
        dropDownTblView.frame = CGRectMake(self.matchTypeView.frame.origin.x+30, self.matchTypeView.frame.origin.y+self.matchTypeView.frame.size.height+207, self.matchTypeView.frame.size.width+10, playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        //  dropDownTblView=[[UITableView alloc]initWithFrame:CGRectMake(self.matchTypeBtn.frame.origin.x+16+518, self.matchTypeBtn.frame.origin.y+60+80,150,228)];
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)onClickLastNYear:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isLastNYearsOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isLastNYearsOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: [playerStaticArray objectAtIndex:1]];
        dropDownTblView.frame = CGRectMake(self.lastNYearView.frame.origin.x+40, self.lastNYearView.frame.origin.y + self.lastNYearView.frame.size.height + 207,self.lastNYearView.frame.size.width,playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
        
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
//        [dropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)onClickCondition:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isConditionOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isConditionOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: [playerStaticArray objectAtIndex:2]];
        dropDownTblView.frame = CGRectMake(self.conditionView.frame.origin.x+40, self.conditionView.frame.origin.y + self.conditionView.frame.size.height + 207,self.conditionView.frame.size.width,playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)onClickCompetition:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isCompetitionOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isCompetitionOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        NSLog(@"CompetitionArray:%@", self.CompetitionArray);
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: self.CompetitionArray];
        dropDownTblView.frame = CGRectMake(self.competitionView.frame.origin.x+40, self.competitionView.frame.origin.y + self.competitionView.frame.size.height + 207,self.competitionView.frame.size.width,playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)onClickAgainst:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isAgainstOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isAgainstOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        NSLog(@"AgainstTeamArray:%@", self.AgainstTeamArray);
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: self.AgainstTeamArray];
        dropDownTblView.frame = CGRectMake(self.againstView.frame.origin.x+40, self.againstView.frame.origin.y + self.againstView.frame.size.height + 312,self.againstView.frame.size.width,playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)onClickInnings:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isInningsOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isInningsOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        //    playerDropDownArray = [playerStaticArray objectAtIndex:3];
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: [playerStaticArray objectAtIndex:3]];
        dropDownTblView.frame = CGRectMake(self.inningsView.frame.origin.x+40, self.inningsView.frame.origin.y + self.inningsView.frame.size.height + 312,self.inningsView.frame.size.width,playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)onClickMatchResult:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isMatchResultOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isMatchResultOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        //    playerDropDownArray = [playerStaticArray objectAtIndex:4];
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: [playerStaticArray objectAtIndex:4]];
        dropDownTblView.frame = CGRectMake(self.matchResultView.frame.origin.x+40, self.matchResultView.frame.origin.y + self.matchResultView.frame.size.height + 312,self.matchResultView.frame.size.width,playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)onClickVenueType:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isVenueTypeOpen) {
        [self resetDropDownStatisticsFilterStatus];
        isVenueTypeOpen = YES;
        
        [playerDropDownArray removeAllObjects];
        //    playerDropDownArray = [playerStaticArray objectAtIndex:5];
        playerDropDownArray = [[NSMutableArray alloc] initWithArray: [playerStaticArray objectAtIndex:5]];
        dropDownTblView.frame = CGRectMake(self.venueTypeView.frame.origin.x+40, self.venueTypeView.frame.origin.y + self.venueTypeView.frame.size.height + 312,self.venueTypeView.frame.size.width,playerDropDownArray.count >= 5 ? 150 : playerDropDownArray.count*45);
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownStatisticsFilterStatus];
    }
}

- (IBAction)applyButtonTapped:(id)sender {
    self.filterView.hidden = YES;
    
    NSMutableArray *filterArray = [[NSMutableArray alloc] init];
    if (self.matchTypeLbl.text.length != 0) {
        [filterArray addObject:self.matchTypeLbl.text];
    }
    if (self.lastNYearLbl.text.length != 0) {
        [filterArray addObject:self.lastNYearLbl.text];
    }
    if (self.conditionLbl.text.length != 0) {
        [filterArray addObject:self.conditionLbl.text];
    }
    if (self.competitionLbl.text.length != 0) {
        [filterArray addObject:self.competitionLbl.text];
    }
    if (self.againstLbl.text.length != 0) {
        [filterArray addObject:self.againstLbl.text];
    }
    if (self.inningsLbl.text.length != 0) {
        [filterArray addObject:self.inningsLbl.text];
    }
    if (self.matchResultLbl.text.length != 0) {
        [filterArray addObject:self.matchResultLbl.text];
    }
    if (self.venueTypeLbl.text.length != 0) {
        [filterArray addObject:self.venueTypeLbl.text];
    }
    
    NSString* result = [filterArray componentsJoinedByString:@", "];
    NSLog(@"matchTypeCode=%@,lastNYearsCode=%@, conditionCode=%@, competitionCode=%@, againstCode=%@, inningsCode=%@, matchResultCode=%@, venueTypeCode=%@", matchTypeCode, lastNYearsCode, conditionCode, competitionCode, againstCode, inningsCode, matchResultCode, venueTypeCode);
    
    [self FilterWebservice];
    
    
    self.filterLbl.text = result;
    if(dropDownTblView!=nil){
        [dropDownTblView removeFromSuperview];
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    self.filterView.hidden = YES;
    if(dropDownTblView!=nil){
        [dropDownTblView removeFromSuperview];
    }
    
//    self.filterLbl.text = @"";
//    self.matchTypeLbl.text = @"";
//    self.lastNYearLbl.text = @"";
//    self.conditionLbl.text = @"";
//    self.competitionLbl.text = @"";
//    self.againstLbl.text = @"";
//    self.inningsLbl.text = @"";
//    self.matchResultLbl.text = @"";
//    self.venueTypeLbl.text = @"";
}

-(void) resetDropDownStatisticsFilterStatus{
    isMatchTypeOpen = NO;
    isLastNYearsOpen = NO;
    isConditionOpen = NO;
    isCompetitionOpen = NO;
    isAgainstOpen = NO;
    isInningsOpen = NO;
    isMatchResultOpen = NO;
    isVenueTypeOpen = NO;
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.search_Tbl) {
        return self.searchResult.count;
    } else if (tableView == dropDownTblView) {
        return playerDropDownArray.count;
    }
    return 0;
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"playerStatisticsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (tableView == dropDownTblView) {
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:(8/255.0f) green:(26/255.0f) blue:(77/255.0f) alpha:1.0f];
        cell.selectedBackgroundView = bgColorView;
        cell.textLabel.textColor = [UIColor whiteColor];
        
        if (isCompetitionOpen) {
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"competitionName"];
        } else if (isAgainstOpen) {
            cell.textLabel.numberOfLines = 2;
            cell.textLabel.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"TeamName"];
        } else {
            cell.textLabel.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        }
    }
    
    if (tableView == _search_Tbl) {
        NSLog(@"cell:%@", [self.searchResult objectAtIndex:indexPath.row]);
     //   cell.textLabel.text = [self.searchResult  objectAtIndex:indexPath.row];
        cell.textLabel.text = [[self.searchResult  objectAtIndex:indexPath.row] valueForKey:@"playerName"];

        
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == dropDownTblView) {
        if (isMatchTypeOpen) {
            self.matchTypeLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"name"];
            matchTypeCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"code"];
        } else if (isLastNYearsOpen) {
            self.lastNYearLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"name"];
            lastNYearsCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"code"];
        } else if (isConditionOpen) {
            self.conditionLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"name"];
            conditionCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"code"];
        } else if (isCompetitionOpen) {
            self.competitionLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"competitionName"];
            competitionCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"competitionCode"];
        } else if (isAgainstOpen) {
            self.againstLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"TeamName"];
            againstCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"TeamCode"];
        } else if (isInningsOpen) {
            self.inningsLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"name"];
            inningsCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"code"];
        } else if (isMatchResultOpen) {
            self.matchResultLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"name"];
            matchTypeCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"code"];
        } else if (isVenueTypeOpen) {
            self.venueTypeLbl.text = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"name"];
            venueTypeCode = [[playerDropDownArray objectAtIndex:indexPath.row] valueForKey:@"code"];
        }
        
        if(dropDownTblView != nil){
            [dropDownTblView removeFromSuperview];
        }
        [self resetDropDownStatisticsFilterStatus];
    }
    
    if (tableView == _search_Tbl) {
        
        objCustomNavigation.objSearchBar.text = [[self.searchResult objectAtIndex:indexPath.row] valueForKey:@"playerName" ];
        [objCustomNavigation.objSearchBar resignFirstResponder];
        
        self.SelectedPlayerCode = [[self.searchResult objectAtIndex:indexPath.row] valueForKey:@"playerCode" ];
        
        [self PlayerDetailsWebservice];
        
    }
}


#pragma mark - Search delegate methods

- (void)filterContentForSearchText:(NSString*)searchText
{
    
    //    NSPredicate *resultPredicate = [NSPredicate
    //                                    predicateWithFormat:@"SELF CONTAINS %@",
    //                                    searchText];
    
   // NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    //_searchResult = [[self.playersSearchListArray valueForKey:@"playerName"] filteredArrayUsingPredicate:resultPredicate];

    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"playerName CONTAINS[c] %@", searchText];
    _searchResult = [self.playersSearchListArray filteredArrayUsingPredicate:resultPredicate];

    NSLog(@"searchResult:%@", _searchResult);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        if (_searchResult.count == 0) {
            self.search_Tbl.hidden = YES;
        } else {
            [self.search_Tbl reloadData];
        }
    });
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //    self.searchResult = _tableDataArray;
    self.searchResult =  self.playersSearchListArray ;// [self.playersSearchListArray valueForKey:@"playerName"];
    self.search_Tbl.hidden = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        [self.search_Tbl reloadData];
    });
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        _searchEnabled = NO;
        self.search_Tbl.hidden=YES;
        [searchBar resignFirstResponder];
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            [self.search_Tbl reloadData];
        });
    }
    else {
        _searchEnabled = YES;
        
        self.search_Tbl.hidden=NO;
        [self filterContentForSearchText:searchBar.text];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    _searchEnabled = YES;
    self.search_Tbl.hidden=NO;
    [self filterContentForSearchText:searchBar.text];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [searchBar setText:@""];
    _searchEnabled = NO;
    self.search_Tbl.hidden=YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        [self.search_Tbl reloadData];
    });
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.search_Tbl.hidden=YES;
    [searchBar resignFirstResponder];
}

-(IBAction)BackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)horizontalBarConfigure
{
    viewHorizontalBar.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = viewHorizontalBar.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawAxisLineEnabled = YES;
    xAxis.drawGridLinesEnabled = NO;
    //xAxis.granularity = 10.0;
    // xAxis.granularity = 1.0; // only intervals of 1 day
    // xAxis.labelCount = 10;
    // viewHorizontalBar.xAxis.valueFormatter = HorizontalXLblFormatter
    
    //xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:viewHorizontalBar];
    xAxis.valueFormatter = [[HorizontalXLblFormatter alloc] initForChart: self.ComfortArray];
    
    ChartYAxis *leftAxis = viewHorizontalBar.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.drawAxisLineEnabled = YES;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    //leftAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:viewHorizontalBar];
    
    ChartYAxis *rightAxis = viewHorizontalBar.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.drawAxisLineEnabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = viewHorizontalBar.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 8.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    
    viewHorizontalBar.fitBars = YES;
    
    [viewHorizontalBar animateWithYAxisDuration:2.5];
    [self updateChartData];
    
}
- (void)updateChartData
{
    //    if (self.shouldHideData)
    //    {
    //        _chartView.data = nil;
    //        return;
    //    }
    
    [self setDataCount:12.0 + 1 range:50.0];
}

- (void)setDataCount:(int)count range:(double)range
{
    double barWidth = 5.0;
    double spaceForBar = 10.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:0 y:20 icon: [UIImage imageNamed:@"icon"]]];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:0 y:40 icon: [UIImage imageNamed:@"icon"]]];
    //    for (NSDictionary *tempDic in  self.ComfortArray.objectEnumerator) {
    //        //[yVals addObject:[[BarChartDataEntry alloc] initWithX:[[tempDic valueForKey:@"level"]integerValue] y:[[tempDic valueForKey:@"level"]integerValue] icon: [UIImage imageNamed:@"icon"]]];
    //
    //        [yVals addObject:[[BarChartDataEntry alloc] initWithX:0 y:20 icon: [UIImage imageNamed:@"icon"]]];
    //    }
    //
    
    //    for(int i=0; i<self.ComfortArray.count;i++)
    //    {
    //    //[yVals addObject:[[BarChartDataEntry alloc] initWithX:[[self.ComfortArray valueForKey:@""] objectAtIndex:i] y:10 icon: [UIImage imageNamed:@"icon"]]];
    //    }
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:20 y:20 icon: [UIImage imageNamed:@"icon"]]];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:30 y:30 icon: [UIImage imageNamed:@"icon"]]];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:40 y:40 icon: [UIImage imageNamed:@"icon"]]];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:50 y:50 icon: [UIImage imageNamed:@"icon"]]];
    NSLog(@"%@", yVals);
    
    for (int i = 0; i < self.ComfortArray.count; i++)
    {
        //double mult = (range + 1);
        //double val = (double) (arc4random_uniform(mult));
//        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:[[[self.ComfortArray valueForKey:@"level"]objectAtIndex:i] integerValue] icon: [UIImage imageNamed:@"icon"]]];
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i * spaceForBar y:[[[self.ComfortArray valueForKey:@"level"]objectAtIndex:i] integerValue] icon: [UIImage imageNamed:@"icon"]]];

    }
    
    BarChartDataSet *set1 = nil;
    if (viewHorizontalBar.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)viewHorizontalBar.data.dataSets[0];
        set1.values = yVals;
        [viewHorizontalBar.data notifyDataChanged];
        [viewHorizontalBar notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
        [set1 setColor:[UIColor redColor]];
        
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        data.barWidth = barWidth;
        
        
        viewHorizontalBar.data = data;
    }
}
-(void)verticalBarConfiguration
{
    //    [self setupBarLineChartView:viewBarChart];
    
    //    _chartView.delegate = self;
    
    viewBarChart.drawBarShadowEnabled = NO;
    viewBarChart.drawValueAboveBarEnabled = YES;
    
    viewBarChart.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = viewBarChart.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 7;
    xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:viewBarChart];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @"";
    leftAxisFormatter.positiveSuffix = @"";
    
    ChartYAxis *leftAxis = viewBarChart.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = viewBarChart.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 8;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = viewBarChart.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 9.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    
    //    XYMarkerView *marker = [[XYMarkerView alloc]
    //                            initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
    //                            font: [UIFont systemFontOfSize:12.0]
    //                            textColor: UIColor.whiteColor
    //                            insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
    //                            xAxisValueFormatter: viewBarChart.xAxis.valueFormatter];
    //    marker.chartView = viewBarChart;
    //    marker.minimumSize = CGSizeMake(80.f, 40.f);
    //    viewBarChart.marker = marker;
    
    [self setDataCount1:12.0 + 1 range:50.0];
    
}


- (void)setDataCount1:(int)count range:(double)range
{
    double start = 1.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    
    for(int i=0;i<self.PositionArray.count;i++)
    {
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:[[[self.PositionArray valueForKey:@"positionNo"]objectAtIndex:i] integerValue] y:[[[self.PositionArray valueForKey:@"matches"]objectAtIndex:i] integerValue] icon: [UIImage imageNamed:@"icon"]]];
    }
    
    
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:20 y:20 icon: [UIImage imageNamed:@"icon"]]];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:30 y:30 icon: [UIImage imageNamed:@"icon"]]];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:40 y:40 icon: [UIImage imageNamed:@"icon"]]];
    //    [yVals addObject:[[BarChartDataEntry alloc] initWithX:50 y:50 icon: [UIImage imageNamed:@"icon"]]];
    
    
    //        for (int i = start; i < start + count + 1; i++)
    //        {
    //            double mult = (range + 1);
    //            double val = (double) (arc4random_uniform(mult));
    //            if (arc4random_uniform(100) < 25) {
    //                [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
    //            } else {
    //                [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    //            }
    //        }
    
    BarChartDataSet *set1 = nil;
    if (viewBarChart.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)viewBarChart.data.dataSets[0];
        set1.values = yVals;
        [viewBarChart.data notifyDataChanged];
        [viewBarChart notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@""];
        [set1 setColor:[UIColor redColor]];
        //        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.5f;
        
        viewBarChart.data = data;
    }
}



// mahesh

-(void)PlayerDetailsWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",PlayerDetails_key]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        //NSString *playerCode = @"PYC0000168";
        NSString *matchtype = @"";
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(self.SelectedPlayerCode)   [dic    setObject:self.SelectedPlayerCode     forKey:@"playerCode"];
        if(matchtype)   [dic    setObject:matchtype     forKey:@"matchType"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                
                self.PlayerDetailsArray = [[NSMutableArray alloc]init];
                self.PlayerCompetitionArray = [[NSMutableArray alloc]init];
                self.PaceArray = [[NSMutableArray alloc]init];
                self.SpinArray = [[NSMutableArray alloc]init];
                self.PaceArray2 = [[NSMutableArray alloc]init];
                self.SpinArray2 = [[NSMutableArray alloc]init];
                self.PaceArray3 = [[NSMutableArray alloc]init];
                self.SpinArray3 = [[NSMutableArray alloc]init];
                
                self.ComfortArray = [[NSMutableArray alloc]init];
                self.PositionArray = [[NSMutableArray alloc]init];
                self.CompetitionArray = [[NSMutableArray alloc]init];
                self.AgainstTeamArray = [[NSMutableArray alloc]init];
                self.recentFormArray = [[NSMutableArray alloc]init];
                self.playerBowlingArray = [[NSMutableArray alloc]init];
                self.playersSearchListArray = [[NSMutableArray alloc]init];
                self.playerBasicDetailsArray = [[NSMutableArray alloc]init];
                self.playerBowlingDetaillistArray =[[NSMutableArray alloc]init];
                

                
                self.PlayerDetailsArray = [responseObject valueForKey:@"PlayerDetailsList"];
                NSLog(@"%@", self.PlayerDetailsArray);
                
                self.PlayerCompetitionArray = [responseObject valueForKey:@"PlayerDetailsListCompetitions"];
                
                self.PaceArray = [responseObject valueForKey:@"statsPlayerPaceList"];
                self.SpinArray = [responseObject valueForKey:@"statsPlayerSpinList"];
                self.PaceArray2 = [responseObject valueForKey:@"statsPlayerPaceList2"];
                self.SpinArray2 = [responseObject valueForKey:@"statsPlayerSpinList2"];
                self.PaceArray3 = [responseObject valueForKey:@"statsPlayerPaceList3"];
                self.SpinArray3 = [responseObject valueForKey:@"statsPlayerSpinList3"];
                
                self.ComfortArray = [responseObject valueForKey:@"statsPlayerComfort"];
                
                self.PositionArray = [responseObject valueForKey:@"statsPlayerPosition"];
                
                self.CompetitionArray = [responseObject valueForKey:@"statsPlayerCompetition"];
                
                self.AgainstTeamArray = [responseObject valueForKey:@"statsPlayerAgainstTeam"];
                
                self.recentFormArray = [responseObject valueForKey:@"statsPlayerRecent"];
                
                self.playerBowlingArray = [responseObject valueForKey:@"PlayerDetailsListBowling"];
                
                self.playersSearchListArray = [responseObject valueForKey:@"PlayerList"];
                
                self.playerBasicDetailsArray = [responseObject valueForKey:@"PlayerDetail"];
                self.playerBowlingDetaillistArray =[responseObject valueForKey:@"PlayerDetailsListBowlingCompetitions"];
                
                // [self PaceVsSpinMethod];
                
                if(![[[self.playerBasicDetailsArray valueForKey:@"playerName"] objectAtIndex:0] isEqual:[NSNull null]])
                {
                    self.playernamelbl.text = [[self.playerBasicDetailsArray valueForKey:@"playerName"] objectAtIndex:0];
                }
                //self.playerCountrylbl.text = [[self.playerBasicDetailsArray valueForKey:@""] objectAtIndex:0];
                if(![[[self.playerBasicDetailsArray valueForKey:@"playerTypeDesc"] objectAtIndex:0] isEqual:[NSNull null]])
                {
                    self.playerTypelbl.text = [[self.playerBasicDetailsArray valueForKey:@"playerTypeDesc"] objectAtIndex:0];
                }
                
                if(![[[self.playerBasicDetailsArray valueForKey:@"playerBatStyleDesc"] objectAtIndex:0] isEqual:[NSNull null]])
                {
                    self.playerStylelbl.text = [[self.playerBasicDetailsArray valueForKey:@"playerBatStyleDesc"] objectAtIndex:0];
                }
                
                if(![[[self.playerBasicDetailsArray valueForKey:@"playerPhoto"] objectAtIndex:0] isEqual:[NSNull null]])
                {
                    
                    NSString *img = [NSString stringWithFormat:@"%@%@",BASE_Image_URL,[[self.playerBasicDetailsArray valueForKey:@"playerPhoto"] objectAtIndex:0]];
                    
                    NSURL *imageURL = [NSURL URLWithString:img];
                    
                    //NSURL *url=[NSURL URLWithString:@"http://images.indianexpress.com/2018/01/rahul-main-image.jpg"];
                    [self.playerimage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"DefaultImg"]];
                }
                
                self.recentFormBall1.hidden = YES;
                self.recentFormBall2.hidden = YES;
                self.recentFormBall3.hidden = YES;
                self.recentFormBall4.hidden = YES;
                self.recentFormBall5.hidden = YES;
                
                //Recent Form
                for(int i=0 ; i<self.recentFormArray.count;i++){
                    if(i==0){
                        self.recentFormBall5.hidden = NO;
                        self.recentFormBall5.text = [[self.recentFormArray valueForKey:@"Runs"] objectAtIndex:0];
                    }else if(i==1){
                        self.recentFormBall4.hidden = NO;
                        self.recentFormBall4.text = [[self.recentFormArray valueForKey:@"Runs"] objectAtIndex:1];
                    }else if(i==2){
                        self.recentFormBall3.hidden = NO;
                        self.recentFormBall3.text = [[self.recentFormArray valueForKey:@"Runs"] objectAtIndex:2];
                    }else if(i==3){
                        self.recentFormBall2.hidden = NO;
                        self.recentFormBall2.text = [[self.recentFormArray valueForKey:@"Runs"] objectAtIndex:3];
                    }else if(i==4){
                        self.recentFormBall1.hidden = NO;
                        self.recentFormBall1.text = [[self.recentFormArray valueForKey:@"Runs"] objectAtIndex:4];
                    }
                }
                
                //[self progressValues];
                [self horizontalBarConfigure];
                [self verticalBarConfiguration];
                
                [self.battingBtn sendActionsForControlEvents:UIControlEventTouchUpInside];

                [self.PP1Btn sendActionsForControlEvents:UIControlEventTouchUpInside];
                
            }
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}

-(void)FilterWebservice
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",Filter_key]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        //NSString *playerCode = @"PYC0000168";
        NSString *matchtype = @"";
        NSLog(@"matchTypeCode=%@,lastNYearsCode=%@, conditionCode=%@, competitionCode=%@, againstCode=%@, inningsCode=%@, matchResultCode=%@, venueTypeCode=%@", matchTypeCode, lastNYearsCode, conditionCode, competitionCode, againstCode, inningsCode, matchResultCode, venueTypeCode);
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(self.SelectedPlayerCode)   [dic    setObject:self.SelectedPlayerCode     forKey:@"playerCode"];
        if(matchTypeCode)   [dic    setObject:matchTypeCode     forKey:@"matchType"];
        if(lastNYearsCode)   [dic    setObject:lastNYearsCode     forKey:@"lastNYears"];
        if(conditionCode)   [dic    setObject:conditionCode     forKey:@"condition"];
        if(competitionCode)   [dic    setObject:competitionCode     forKey:@"competition"];
        if(againstCode)   [dic    setObject:againstCode     forKey:@"teamCode"];
        if(inningsCode)   [dic    setObject:inningsCode     forKey:@"innings"];
        if(matchResultCode)   [dic    setObject:matchResultCode     forKey:@"matchResult"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"response ; %@",responseObject);
                self.PlayerDetailsArray = [[NSMutableArray alloc]init];
                self.PlayerCompetitionArray = [[NSMutableArray alloc]init];
                self.playerBowlingArray = [[NSMutableArray alloc]init];
                self.playerBowlingDetaillistArray =[[NSMutableArray alloc]init];
                
                self.PlayerDetailsArray = [responseObject valueForKey:@"PlayerDetailsList"];
                self.PlayerCompetitionArray = [responseObject valueForKey:@"PlayerDetailsListCompetitions"];
                
                self.playerBowlingArray = [responseObject valueForKey:@"PlayerDetailsListBowling"];
                
                self.playerBowlingDetaillistArray =[responseObject valueForKey:@"PlayerDetailsListBowlingCompetitions"];
                [self.battingBtn sendActionsForControlEvents:UIControlEventTouchUpInside];

                
            }
            
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}



-(void)buttonclicked:(UIButton*)selectedBtn
{
    NSArray *arr= @[self.PP1Btn,self.PP2Btn,self.PP3Btn];
    
    for (UIButton *curBtn in arr) {
        
        if(selectedBtn == curBtn)
        {
            selectedBtn.tag = 1;
        }
        else
        {
            curBtn.tag = 0;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)BattingAction:(id)sender
{
    [self setInningsBySelection1:@"1"];
    self.BattingViewHeader.hidden = NO;
    self.BowlingViewHeader.hidden = YES;

    _objExpendView.isBatting =YES;
    _objExpendView.playerDetailArray = self.PlayerDetailsArray;
    _objExpendView.expendplayerDetailArray = self.PlayerCompetitionArray;
    NSMutableArray * arrayForBool=[[NSMutableArray alloc]init];
    for (int i=0; i< [self.PlayerCompetitionArray count]; i++) {
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
    }
    _objExpendView.arrayForBool = arrayForBool;
    _objExpendView.expendTblHeight.constant = _objExpendView.expendTbl.contentSize.height+self.PlayerCompetitionArray.count*45;
    _objExpendView.expandviewHeight.constant = _objExpendView.expendTblHeight.constant-5;
    _horzaticalscrolheight.constant = self.PlayerDetailsArray.count * 40+50;
    self.horzaticalScrolWidth.constant= 1690;
    self.horizatalScrollview.scrollEnabled =YES;
    [self.horizatalScrollview setContentOffset:CGPointZero animated:YES];

    [_objExpendView.expendTbl reloadData];
    
}
-(IBAction)BowlingAction:(id)sender
{
    [self setInningsBySelection1:@"2"];
    self.BattingViewHeader.hidden = YES;
    self.BowlingViewHeader.hidden = NO;

    _objExpendView.isBatting = NO;
    _objExpendView.playerDetailArray = self.playerBowlingArray;
    _objExpendView.expendplayerDetailArray = self.playerBowlingDetaillistArray;
    NSMutableArray * arrayForBool=[[NSMutableArray alloc]init];
    for (int i=0; i< [self.playerBowlingDetaillistArray count]; i++) {
        [arrayForBool addObject:[NSNumber numberWithBool:NO]];
    }
    _objExpendView.arrayForBool = arrayForBool;
    _objExpendView.expendTblHeight.constant = _objExpendView.expendTbl.contentSize.height+self.playerBowlingDetaillistArray.count*45;
    _objExpendView.expandviewHeight.constant = _objExpendView.expendTblHeight.constant-5;
    _horzaticalscrolheight.constant = self.playerBowlingArray.count * 40+50;
    self.horzaticalScrolWidth.constant=self.view.frame.size.width;
    self.horizatalScrollview.scrollEnabled =NO;
    [self.horizatalScrollview setContentOffset:CGPointZero animated:YES];

    
    [_objExpendView.expendTbl reloadData];
}
-(void) setInningsBySelection1: (NSString*) innsNo{
    
    [self setInningsButtonUnselect1:self.battingBtn];
    [self setInningsButtonUnselect1:self.bowlingBtn];
    
    if([innsNo isEqualToString:@"1"]){
        
        [self setInningsButtonSelect1:self.battingBtn];
        
    }else if([innsNo isEqualToString:@"2"]){
        
        [self setInningsButtonSelect1:self.bowlingBtn];
    }
    
}

-(UIColor*)colorWithHexString1:(NSString*)hex
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}

-(void) setInningsButtonSelect1 : (UIButton*) innsBtn{
    // innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#0D2B81"];
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
}

-(void) setInningsButtonUnselect1 : (UIButton*) innsBtn{
    //  innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [UIColor colorWithRed:(63/255.0f) green:(63/255.0f) blue:(65/255.0f) alpha:1.0f] ;
    
    //[self colorWithHexString : @"#000000"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
}





@end
