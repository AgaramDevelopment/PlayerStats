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
@interface PlayerStatsVC ()<MCBarChartViewDelegate,MCBarChartViewDataSource,UISearchBarDelegate>
{
    NSArray *data3;
    NSArray *values;
    NSMutableArray *myarray;
    
    NSString * yValue;
    NSString * zValue;
    //SeachView * objSearchview;
    ExpendedView * objExpendTbl;
    NSMutableArray *playerArray;

     UITableView *dropDownTblView;
}
@property (nonatomic,strong)  NSArray *ylist;
@property (nonatomic,strong)  NSArray *zlist;
@property (strong, nonatomic) NSArray * titles_1;

@property (weak, nonatomic) IBOutlet HACBarChart *chart3;
@property (strong, nonatomic) MCBarChartView * BarChartView;

@property(nonatomic,strong) NSMutableArray *tableDataArray;
@property(assign) BOOL searchEnabled;
@property (nonatomic,strong) IBOutlet UITableView * search_Tbl;
@property (nonatomic,strong) IBOutlet UISearchBar * search_Bar;
@property (nonatomic, strong) NSArray *searchResult;
@end

@implementation PlayerStatsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    self.filterView.hidden = YES;
//    playerArray = [[NSMutableArray alloc] initWithObjects:@"Player1", @"Player2", @"Player3", @"Player4", @"Player5", @"Player6", @"Player7", @"Player8", @"Player9", @"Player10", @"Player11", nil];
//    dropDownTblView = [[UITableView alloc]init];
//    dropDownTblView.dataSource = self;
//    dropDownTblView.delegate = self;
    [self ChartViewMethod];
    //_searchView.frame=[self setFramrToMenuViewWithXposition:100];
    [self SearchViewMethod];
    objExpendTbl =[[ExpendedView alloc]init];
}
-(void)SearchViewMethod
{
    _tableDataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    
    self.searchResult = [NSMutableArray arrayWithCapacity:[_tableDataArray count]];
    self.search_Tbl.hidden=YES;
    
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
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
    frame.origin.y=self.searchView.frame.origin.y+10;
    frame.size.height=self.searchView.frame.size.height;
    frame.size.width=self.searchView.frame.size.width;
    
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

- (IBAction)onClickFilterButton:(id)sender {
    self.filterView.hidden = NO;
}

- (IBAction)onClickMatchType:(id)sender {
    dropDownTblView.frame = CGRectMake(self.matchTypeView.frame.origin.x+40, self.matchTypeView.frame.origin.y+self.matchTypeView.frame.size.height+190, self.matchTypeView.frame.size.width, playerArray.count >= 5 ? 150 : playerArray.count*30);
    //  dropDownTblView=[[UITableView alloc]initWithFrame:CGRectMake(self.matchTypeBtn.frame.origin.x+16+518, self.matchTypeBtn.frame.origin.y+60+80,150,228)];
    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [self.view addSubview:dropDownTblView];
    
}

- (IBAction)onClickLastNYear:(id)sender {
    dropDownTblView.frame = CGRectMake(self.lastNYearView.frame.origin.x+40, self.lastNYearView.frame.origin.y + self.lastNYearView.frame.size.height + 190,self.lastNYearView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [self.view addSubview:dropDownTblView];
}

- (IBAction)onClickCondition:(id)sender {
    dropDownTblView.frame = CGRectMake(self.conditionView.frame.origin.x+40, self.conditionView.frame.origin.y + self.conditionView.frame.size.height + 190,self.conditionView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [self.view addSubview:dropDownTblView];
}

- (IBAction)onClickCompetition:(id)sender {
    dropDownTblView.frame = CGRectMake(self.competitionView.frame.origin.x+40, self.competitionView.frame.origin.y + self.competitionView.frame.size.height + 190,self.competitionView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [self.view addSubview:dropDownTblView];
}

- (IBAction)onClickAgainst:(id)sender {
    dropDownTblView.frame = CGRectMake(self.againstView.frame.origin.x+155, self.againstView.frame.origin.y + self.againstView.frame.size.height + 295,self.againstView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [self.view addSubview:dropDownTblView];
}

- (IBAction)onClickInnings:(id)sender {
    dropDownTblView.frame = CGRectMake(self.inningsView.frame.origin.x+155, self.inningsView.frame.origin.y + self.inningsView.frame.size.height + 295,self.inningsView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [self.view addSubview:dropDownTblView];
}

- (IBAction)onClickMatchResult:(id)sender {
    dropDownTblView.frame = CGRectMake(self.matchResultView.frame.origin.x+155, self.matchResultView.frame.origin.y + self.matchResultView.frame.size.height + 295,self.matchResultView.frame.size.width,playerArray.count >= 5 ? 150 : playerArray.count*30);
    dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [self.view addSubview:dropDownTblView];
}

- (IBAction)okButtonTapped:(id)sender {
    self.filterView.hidden = YES;
    
    if(dropDownTblView!=nil){
        [dropDownTblView removeFromSuperview];
    }
}

- (IBAction)cancelButtonTapped:(id)sender {
    self.filterView.hidden = YES;
    if(dropDownTblView!=nil){
        [dropDownTblView removeFromSuperview];
    }
}

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
    //  innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#F2F2F2"];
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    [innsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

-(IBAction)PP1Action:(id)sender
{
    [self setInningsBySelection:@"1"];
}
-(IBAction)PP2Action:(id)sender
{
    [self setInningsBySelection:@"2"];
}
-(IBAction)PP3Action:(id)sender
{
    [self setInningsBySelection:@"3"];
}

#pragma mark - UITableViewDataSource
//// number of section(s), now I assume there is only 1 section
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//// number of row in the section, I assume there is only 1 row
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return playerArray.count;
//}
//// the cell will be returned to the tableView
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"playerStatisticsCell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    
//    cell.backgroundColor = [UIColor clearColor];
//    
//    UIView *bgColorView = [[UIView alloc] init];
//    bgColorView.backgroundColor = [UIColor colorWithRed:(8/255.0f) green:(26/255.0f) blue:(77/255.0f) alpha:1.0f];
//    cell.selectedBackgroundView = bgColorView;
//    cell.textLabel.textColor = [UIColor whiteColor];
//    
//    cell.textLabel.text = playerArray[indexPath.row];
//    return cell;
//}
//
//#pragma mark - UITableViewDelegate
//// when user tap the row, what action you want to perform
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"selected %d row", indexPath.row);
//    if(dropDownTblView!=nil){
//        [dropDownTblView removeFromSuperview];
//    }
//}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(_searchEnabled)
    {
        return  self.searchResult.count;
    }
    else
    {
        return [_tableDataArray count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
}
#pragma mark Table Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (_searchEnabled) {
        cell.textLabel.text = [self.searchResult objectAtIndex:indexPath.row];
        
    }
    else{
        cell.textLabel.text = [_tableDataArray objectAtIndex:indexPath.row];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.search_Bar.text = [_searchResult objectAtIndex:indexPath.row];
    self.search_Tbl.hidden = YES;
    
}


#pragma mark - Search delegate methods

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF CONTAINS %@",
                                    searchText];
    
    _searchResult = [_tableDataArray filteredArrayUsingPredicate:resultPredicate];
    [self.search_Tbl reloadData];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.searchResult = _tableDataArray;
    self.search_Tbl.hidden = NO;
    [self.search_Tbl reloadData];
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text.length == 0) {
        _searchEnabled = NO;
        self.search_Tbl.hidden=YES;
        [self.search_Tbl reloadData];
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
    [self.search_Tbl reloadData];
    
}
-(IBAction)BackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
