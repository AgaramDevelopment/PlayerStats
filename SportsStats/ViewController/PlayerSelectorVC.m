//
//  PlayerSelectorVC.m
//  SportsStats
//
//  Created by apple on 06/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

@class CustomNavigation;

#import "PlayerSelectorVC.h"
#import "CustomNavigation.h"
#import "PlayerListTableViewCell.h"
#import "WebService.h"
#import "Config.h"
#import "AppCommon.h"
#import "PlayerStatsVC.h"
#import "PlayerListCollectionViewCell.h"



@interface PlayerSelectorVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray* headingKeyArray;
    NSMutableArray* playerOrginArray,* playerTypeArray,* playerBattingStyleArray,* playerBowlingStyleArray,*battingOrderArray;
    NSMutableArray* tagArray;
    NSArray* headingButtonNames;

    long playerOrginFilterPos;
    long playerTypeFilterPos;
    long battingStyleFilterPos;
    long bowlingStyleFilterPos;
    
    BOOL isPlayerOrginOpen;
    BOOL isPlayerTypeOpen;
    BOOL isBattingStyleOpen;
    BOOL isBowlingStyleOpen;
    BOOL isBattingOrderOpen;


    NSString* selectedHeading;
    UITableView *filterDropDownTblView;
    NSMutableArray* MainListArray;
    NSMutableArray* DropDownArray;
    NSMutableArray* PlayerListArray;

}

@end

@implementation PlayerSelectorVC
@synthesize tblPlayerList,collectionPlayerList;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    isPlayerOrginOpen = NO;
     isPlayerTypeOpen = NO;
     isBattingStyleOpen = NO;
     isBowlingStyleOpen = NO;
    isBattingOrderOpen = NO;
    tagArray = [NSMutableArray new];
    
    playerOrginFilterPos = 0;
    playerTypeFilterPos = 0;
    battingStyleFilterPos = 0;
    bowlingStyleFilterPos = 0;
    
    
    headingKeyArray = @[@"PlayerName",@"BatStyle",@"Matches",@"Inns",@"NOs",@"Runs",@"Balls",@"HS",@"BatAve",@"BatSR",@"dotspercent",@"boundaries",@"hunderds",@"fifties",@"dots",@"Fours",@"Sixs",@"thirties",@"BowlRuns",@"BowlBalls",@"BowlAve",@"BowlSR",@"wickets",@"threes",@"Econ",@"catches",@"stumpings"];

    
    headingButtonNames = @[@"Player",@"Style",@"Mat",@"Inns",@"NO",@"Runs",@"BF",@"HS",@"Ave %",@"SR %",@"DB %",@"Bdry %",@"100s",@"50s",@"0s",@"4s",@"6s",@"30s",@"Bowl\nRuns",@"Bowl\nBalls",@"Bowl\nAve %",@"Bowl\nSR %",@"Wkts",@"3w Above",@"Econ %",@"Catch",@"Stump"];

    
    [collectionPlayerList registerNib:[UINib nibWithNibName:@"PlayerListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCellIdentifier"];


    for (id tag in headingKeyArray.objectEnumerator) {
        [tagArray addObject:@0];
    }

    [self fetchPlayerSelectionWS];
    
    [self customnavigationmethod];
//    tagArray addObjectsFromArray:@[@0,@0,]
    battingOrderArray = [[NSMutableArray alloc] initWithArray:
                        @[
                          @{
                              @"playerTypeDesc":@"Top",
                              @"playerTypeCode":@"Top"
                              }, @{
                              @"playerTypeDesc":@"Middle",
                              @"playerTypeCode":@"Middle"
                              },@{
                              @"playerTypeDesc":@"Tail Ender",
                              @"playerTypeCode":@"Tail Ender"
                              },@{
                              @"playerTypeDesc":@"ALL",
                              @"playerTypeCode":@""
                              }]];

    
    
    playerOrginArray = [[NSMutableArray alloc] initWithArray:
                     @[
                       @{
                           @"playerTypeDesc":@"Indian Capped",
                           @"playerTypeCode":@"CAPPED"
                           }, @{
                           @"playerTypeDesc":@"Indian Uncapped",
                           @"playerTypeCode":@"UNCAPPED"
                           }, @{
                           @"playerTypeDesc":@"Foreigner",
                           @"playerTypeCode":@"FOREIGNER"
                           },@{
                           @"playerTypeDesc":@"ALL",
                           @"playerTypeCode":@""
                           }]];
    
    
    filterDropDownTblView=[[UITableView alloc]init];
    filterDropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    filterDropDownTblView.dataSource = self;
    filterDropDownTblView.delegate = self;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
        objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation_iPad" bundle:nil];
    
    
    [self.view addSubview:objCustomNavigation.view];
    
    objCustomNavigation.tittle_lbl.text=@"Player Selection";
    objCustomNavigation.nav_header_img.image = [UIImage imageNamed:@"withText"];
    
    //objCustomNavigation.nav_header_img.image = [UIImage imageNamed:@"withoutText"];
   // objCustomNavigation.nav_header_img.backgroundColor = [UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    
    
    
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.filter_btn.hidden = YES;
    objCustomNavigation.Cancelbtn.hidden = YES;
    objCustomNavigation.summarybtn.hidden=YES;
    objCustomNavigation.nav_search_view.hidden = YES;
    
    //[objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    if (tableView == tblPlayerList) {
//        return 2;
//    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if(tableView == tblPlayerList && section == 1){
    if(tableView == tblPlayerList){

        return PlayerListArray.count;
    }    else if(tableView == filterDropDownTblView){
        
        return  DropDownArray.count;
        
    }

    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    if(tableView == tblPlayerList && indexPath.section == 1){
    if(tableView == tblPlayerList){

    
        PlayerListTableViewCell *cell = [tblPlayerList dequeueReusableCellWithIdentifier:@"FirstCell"];
        NSArray* arr = [[NSBundle mainBundle] loadNibNamed:@"PlayerListTableViewCell" owner:self options:nil];
        cell = arr[1];
        
        if (indexPath.row % 2 != 0) {
            cell.viewBG.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
            
        }else
        {
            cell.viewBG.backgroundColor = [UIColor whiteColor];
        }
        
        
        cell.lblPlayerName.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"PlayerName"];
        cell.lblOrigin.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"CappedOrNot"];
        cell.lblStyle.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BatStyle"];
        cell.lblOrder.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BatOrder"];
        cell.lblMat.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Matches"];
        cell.lblInns.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Inns"];
        cell.lblNo.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"NOs"];
        cell.lblRuns.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Runs"];
        cell.lblBF.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Balls"];
        cell.lblHS.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"HS"];
        cell.lblAve.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BatAve"];
        cell.lblSR.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BatSR"];
        cell.lblDB.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"dots"];
        cell.lblBdry.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"boundaries"];
        cell.lbl100.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"hunderds"];
        cell.lbl50.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"fifties"];
        //        cell.lbl0.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"0"];
        cell.lbl4s.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Fours"];
        cell.lbl6s.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Sixs"];
        
        cell.lbl30s.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"thirties"];
        cell.lblBowlRuns.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BowlRuns"];
        cell.lblBowlBalls.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BowlBalls"];
        cell.lblBowlAve.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BowlAve"];
        cell.lblBowlSR.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"BowlSR"];
        cell.lblWkts.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"wickets"];
//        cell.lbl3wAbove.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Sixs"];
        cell.lblEcon.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"Econ"];
        cell.lblCatch.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"catches"];
        cell.lblStump.text = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"stumpings"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{ //Other Cell
        
        UITableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (otherCell == nil) {
            otherCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        otherCell.backgroundColor = [UIColor clearColor];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:(8/255.0f) green:(26/255.0f) blue:(77/255.0f) alpha:1.0f];
        otherCell.selectedBackgroundView = bgColorView;
        otherCell.textLabel.textColor = [UIColor whiteColor];
        
        if(tableView == filterDropDownTblView){
            
            
            
            otherCell.textLabel.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
        }
        

        
        return otherCell;
        
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
//    if(tableView == tblPlayerList && section == 0){
//        return tableView.rowHeight;
//    }else{
//        return 0;
//    }
    
    if(tableView == tblPlayerList){
        return tableView.rowHeight;
    }else{
        return 0;
    }


}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
    {
        
//        if(tableView == tblPlayerList && section == 0){
        if(tableView == tblPlayerList){

        
            PlayerListTableViewCell *cell = [tblPlayerList dequeueReusableCellWithIdentifier:@"Header"];
            NSArray* arr = [[NSBundle mainBundle] loadNibNamed:@"PlayerListTableViewCell" owner:self options:nil];
            
            if(cell == nil)
            {
                cell = arr[0];
            }
            
            for (CustomButton* tempBut in cell.btnHeader.objectEnumerator) {
                NSInteger buttonIndex = [cell.btnHeader indexOfObject:tempBut];
                tempBut.tag = [[tagArray objectAtIndex:buttonIndex] integerValue];
                [tempBut addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
                tempBut.secondTag = buttonIndex;
                
                if (tempBut.secondTag == 19) {
                    tempBut.titleLabel.numberOfLines = 2;
                    [tempBut setTitle:[NSString stringWithFormat:@"Bowl\nRuns"] forState:UIControlStateNormal];
                }else if (tempBut.secondTag == 20) {
                    tempBut.titleLabel.numberOfLines = 2;
                    [tempBut setTitle:[NSString stringWithFormat:@"Bowl\nBalls"] forState:UIControlStateNormal];
                }else if (tempBut.secondTag == 21) {
                    tempBut.titleLabel.numberOfLines = 2;
                    [tempBut setTitle:[NSString stringWithFormat:@"Bowl\nAvg %@",@"%"] forState:UIControlStateNormal];
                }else if (tempBut.secondTag == 22) {
                    tempBut.titleLabel.numberOfLines = 2;
                    [tempBut setTitle:[NSString stringWithFormat:@"Bowl\nSR %@",@"%"] forState:UIControlStateNormal];
                }

                
                if ([selectedHeading isEqualToString: tempBut.titleLabel.text]) {
                    [tempBut setTitleColor: [ UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f] forState:UIControlStateNormal];
                //    [[tempBut titleLabel]setFont:[UIFont fontWithName:@"Montserrat-Regular" size:20.0]];
                }
                else{
                    [tempBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                  //  [[tempBut titleLabel]setFont:[UIFont fontWithName:@"Montserrat-Regular" size:15.0]];
                }
                
//                NSLog(@"Button Name = %@",tempBut.titleLabel.text);
//                NSLog(@"Button tag = %ld",(long)tempBut.tag);
//                NSLog(@"Button second tag = %ld",(long)tempBut.secondTag);
            }
            
            return cell;
            
        }
        
        return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == tblPlayerList){
        PlayerStatsVC * nextVC = [[PlayerStatsVC alloc]init];
        nextVC = (PlayerStatsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayerStats"];
        nextVC.SelectedPlayerCode = [[PlayerListArray objectAtIndex:indexPath.row] valueForKey:@"PlayerCode"];
        [self.navigationController pushViewController:nextVC animated:YES];

        
    }else if(tableView == filterDropDownTblView){
        
        if(isPlayerOrginOpen){
            _playerOrderLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            playerOrginFilterPos = indexPath.row;
            self.playerOrderLbl.tag = indexPath.row;
        }else if(isPlayerTypeOpen){
            _playerTypeLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            playerTypeFilterPos = indexPath.row;
            self.playerTypeLbl.tag = indexPath.row;
        }else if(isBattingStyleOpen){
            _battingStyleLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            battingStyleFilterPos = indexPath.row;
            self.battingStyleLbl.tag = indexPath.row;
        }else if(isBowlingStyleOpen){
            _bowlingStyleLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            bowlingStyleFilterPos = indexPath.row;
            self.bowlingStyleLbl.tag = indexPath.row;
        }else if(isBattingOrderOpen){
            _lblBattingOrder.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            self.lblBattingOrder.tag = indexPath.row;
        }
        
        if(filterDropDownTblView!=nil){
            [filterDropDownTblView removeFromSuperview];
        }
        [self resetDropDownOpenStatus];
        
        [self filterPlayer];
        
        
        
    }

}


-(void)btnActionForSorting:(CustomButton *)sender
{
    NSString* selectedKey = [headingKeyArray objectAtIndex:[sender secondTag]];
    selectedHeading = [[sender titleLabel] text];
    
    
    BOOL isAscending = NO;
    if (sender.tag) { // 1
        sender.tag = 0;
        isAscending = YES;
        [tagArray replaceObjectAtIndex:[headingKeyArray indexOfObject:selectedKey] withObject:@0];
        
    }
    else
    {
        sender.tag = 1;
        [tagArray replaceObjectAtIndex:[headingKeyArray indexOfObject:selectedKey] withObject:@1];
    }
    
    if ([[PlayerListArray firstObject] valueForKey:selectedKey] != nil) {
        
        NSArray* arr = [PlayerListArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:selectedKey ascending:isAscending selector:@selector(localizedStandardCompare:)]]];
        
        PlayerListArray = [NSMutableArray new];
        [PlayerListArray addObjectsFromArray:arr];
    }
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        [self.tblPlayerList reloadData];
        [self.collectionPlayerList reloadData];
    });
}






-(void) resetDropDownOpenStatus{
    isPlayerOrginOpen = NO;
    isPlayerTypeOpen = NO;
    isBattingStyleOpen = NO;
    isBowlingStyleOpen = NO;
    isBattingOrderOpen = NO;
}

//- (IBAction)onClickSearchBtn:(id)sender {
//
//    if(filterDropDownTblView!=nil){
//        [filterDropDownTblView removeFromSuperview];
//    }
//    [self resetDropDownOpenStatus];
//
//    [self filterPlayer];
//}


- (IBAction)onClickPlayerOriginDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isPlayerOrginOpen){
        
        DropDownArray = [[NSMutableArray alloc] initWithArray: playerOrginArray];
        
        [self resetDropDownOpenStatus];
        isPlayerOrginOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);

        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:playerOrginFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }else{
        [self resetDropDownOpenStatus];
        
    }

}




- (IBAction)onClickPlayerTypeDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isPlayerTypeOpen){
        [self dropDownValueForPlayerType];
        [self resetDropDownOpenStatus];
        isPlayerTypeOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
        
        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:playerTypeFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else{
        [self resetDropDownOpenStatus];
        
    }
    
}

- (IBAction)onClickBattingStyleDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isBattingStyleOpen){
        
        [self dropDownValueForBattingStyle];
        [self resetDropDownOpenStatus];
        isBattingStyleOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
        
        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:battingStyleFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else{
        [self resetDropDownOpenStatus];
    }
    
}

- (IBAction)onClickBowlingStyleDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isBowlingStyleOpen){
        
        [self resetDropDownOpenStatus];
        isBowlingStyleOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);

        [self dropDownValueForBowlingStyle];
        
        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bowlingStyleFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else{
        [self resetDropDownOpenStatus];
        
    }
    
}
- (IBAction)onClickBattingOrderStyleDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isBowlingStyleOpen){

        isBattingOrderOpen = YES;
        DropDownArray = battingOrderArray;
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
        [self.view addSubview:filterDropDownTblView];
        
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_lblBattingOrder.tag inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];

        
    }else{
        [self resetDropDownOpenStatus];
        
    }

}
-(void)dropDownValueForBattingStyle
{
    DropDownArray = [[NSMutableArray alloc] init];
    NSMutableArray * tempArray = [MainListArray valueForKey:@"BattingStyle"];
    
    for (int i=0; i < tempArray.count; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setObject:[[tempArray objectAtIndex:i] objectForKey:@"playerTypeDesc"] forKey:@"playerTypeDesc"];
        [tempDict setObject:[[tempArray objectAtIndex:i] objectForKey:@"playerTypeCode"] forKey:@"playerTypeCode"];
        
        [DropDownArray addObject:tempDict];
    }
    
    [DropDownArray addObject:@{
                               @"playerTypeDesc":@"ALL",
                               @"playerTypeCode":@""
                               }];
    
    playerBattingStyleArray = [[NSMutableArray alloc] initWithArray:DropDownArray];;

}

-(void)dropDownValueForBowlingStyle
{
    DropDownArray = [[NSMutableArray alloc] init];
    NSMutableArray * tempArray = [MainListArray valueForKey:@"BowlingStyle"];
    
    for (int i=0; i < tempArray.count; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setObject:[[tempArray objectAtIndex:i] objectForKey:@"playerTypeDesc"] forKey:@"playerTypeDesc"];
        [tempDict setObject:[[tempArray objectAtIndex:i] objectForKey:@"playerTypeCode"] forKey:@"playerTypeCode"];
        
        [DropDownArray addObject:tempDict];
    }
    
    [DropDownArray addObject:@{
                               @"playerTypeDesc":@"ALL",
                               @"playerTypeCode":@""
                               }];
    
    playerBowlingStyleArray = [[NSMutableArray alloc] initWithArray:DropDownArray];;

}
-(void)dropDownValueForPlayerType
{
    DropDownArray = [[NSMutableArray alloc] init];
    NSMutableArray * tempArray = [MainListArray valueForKey:@"PlayerType"];
    
    for (int i=0; i < tempArray.count; i++) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        [tempDict setObject:[[tempArray objectAtIndex:i] objectForKey:@"playerTypeDesc"] forKey:@"playerTypeDesc"];
        [tempDict setObject:[[tempArray objectAtIndex:i] objectForKey:@"playerTypeCode"] forKey:@"playerTypeCode"];
        
        [DropDownArray addObject:tempDict];
    }
    
    
    [DropDownArray addObject:@{
                               @"playerTypeDesc":@"ALL",
                               @"playerTypeCode":@""
                               }];
    
    
    playerTypeArray = [[NSMutableArray alloc] initWithArray:DropDownArray];

}

-(void) filterPlayer{
    
    NSPredicate* predicate1,*predicate2,*predicate3,*predicate4,*predicate5;
    if([_playerOrderLbl.text isEqualToString:@"ALL"])
    {
        predicate1 = [NSPredicate predicateWithFormat:@"CappedOrNot != %@ OR CappedOrNot == %@",@"",@""];
    }else{
        predicate1 = [NSPredicate predicateWithFormat:@"CappedOrNot == %@",[[playerOrginArray objectAtIndex:_playerOrderLbl.tag]valueForKey:@"playerTypeCode"]];
    }

    if ([_playerTypeLbl.text isEqualToString:@"ALL"]) {
        predicate2 = [NSPredicate predicateWithFormat:@"playerTypecode != %@ OR playerTypecode == %@",@"",@""];
    }else
    {
        predicate2 = [NSPredicate predicateWithFormat:@"playerTypecode == %@",[[playerTypeArray objectAtIndex:self.playerTypeLbl.tag]valueForKey:@"playerTypeCode"]];
    }


    if ([_battingStyleLbl.text isEqualToString:@"ALL"]) {
        predicate3 = [NSPredicate predicateWithFormat:@"batstylecode != %@ OR batstylecode == %@",@"",@""];
    }else
    {
        predicate3 = [NSPredicate predicateWithFormat:@"batstylecode == %@",[[playerBattingStyleArray objectAtIndex:self.battingStyleLbl.tag]valueForKey:@"playerTypeCode"]];
    }

    if ([_bowlingStyleLbl.text isEqualToString:@"ALL"]) {
        predicate4 = [NSPredicate predicateWithFormat:@"bowlstylecode != %@ OR bowlstylecode == %@",@"",@""];
    }else
    {
        predicate4 = [NSPredicate predicateWithFormat:@"bowlstylecode == %@",[[playerBowlingStyleArray objectAtIndex:self.bowlingStyleLbl.tag]valueForKey:@"playerTypeCode"]];
    }
    
    
    if ([_lblBattingOrder.text isEqualToString:@"ALL"]) {
        predicate5 = [NSPredicate predicateWithFormat:@"BatOrder != %@ OR BatOrder == %@",@"",@""];
        
    }else
    {
        predicate5 = [NSPredicate predicateWithFormat:@"BatOrder == %@",[[battingOrderArray objectAtIndex:self.lblBattingOrder.tag]valueForKey:@"playerTypeCode"]];
    }

//    NSCompoundPredicate *finalpredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate1,predicate2,predicate3,predicate4,predicate5]];
    
    NSCompoundPredicate *finalpredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[predicate1,predicate2,predicate3,predicate4,predicate5]];

    

    if(finalpredicate != nil){
        
        NSArray *tempRootPlayer = [MainListArray valueForKey:@"PlayerDetailsList"];
        
        NSArray *fiteredArray = [tempRootPlayer filteredArrayUsingPredicate:finalpredicate];
//        NSArray *fiteredArray = [tempRootPlayer filteredArrayUsingPredicate:pred];

        PlayerListArray = [[NSMutableArray alloc] init];

        if(fiteredArray.count != 0){
            [PlayerListArray addObjectsFromArray:fiteredArray];
            [collectionPlayerList setHidden:NO];
//            [self.lblNoData setHidden:YES];
            

        }else{
            [collectionPlayerList setHidden:YES];
//            [AppCommon showAlertWithMessage:@"No record found"];
//            [self.lblNoData setHidden:NO];
            return;
        }

        NSLog(@"FILTERED VALUE %@",PlayerListArray);
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [collectionPlayerList reloadData];
    });
    
}

-(void)fetchPlayerSelectionWS
{
    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FETCH_AUCTION_OVERALL_PLAYER_STATS]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//                if(competition)   [dic    setObject:competition     forKey:@"Competitioncode"];
//                if(teamcode)   [dic    setObject:teamcode     forKey:@"Teamcode"];
//                if(self.matchCode)   [dic    setObject:self.matchCode     forKey:@"MatchCode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                //Root Array
                MainListArray = responseObject;
                
                
                //Set Filter position
                NSMutableArray *tempArray = [MainListArray valueForKey:@"BowlingStyle"];
                bowlingStyleFilterPos = tempArray.count;
                battingStyleFilterPos = 0;
                playerTypeFilterPos = 0;
                playerOrginFilterPos = 0;
                
                _bowlingStyleLbl.text = @"ALL";
                
                tempArray = [MainListArray valueForKey:@"BattingStyle"];
                _battingStyleLbl.text  = [[tempArray objectAtIndex:0] valueForKey:@"playerTypeDesc"];
                
                tempArray = [MainListArray valueForKey:@"PlayerType"];
                _playerTypeLbl.text  = [[tempArray objectAtIndex:0] valueForKey:@"playerTypeDesc"];
                
                _playerOrderLbl.text  = [[playerOrginArray objectAtIndex:3] valueForKey:@"playerTypeDesc"];
                self.lblBattingOrder.text = @"ALL";
                self.playerOrderLbl.tag = 3;
                self.playerTypeLbl.tag = 0;
                self.battingStyleLbl.tag = 0;
                self.bowlingStyleLbl.tag = 3;
                self.lblBattingOrder.tag = 3;
                [self dropDownValueForBowlingStyle];
                [self dropDownValueForBattingStyle];
                [self dropDownValueForPlayerType];
                
                //Player Array
                PlayerListArray = [responseObject valueForKey:@"PlayerDetailsList"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[self.tblPlayerList reloadData];
                    [self filterPlayer];
                });
                
            }
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"failed");
            [COMMON webServiceFailureError];
            [COMMON RemoveLoadingIcon];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
}

#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (PlayerListArray.count > 0) {
        return PlayerListArray.count+1;
        
    }
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return headingButtonNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlayerListCollectionViewCell* cell = [collectionPlayerList dequeueReusableCellWithReuseIdentifier:@"ContentCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        if(indexPath.row >=0 && indexPath.row <= 17) // coulmn 1
        {
            cell.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:127.0/255.0 blue:182.0/255.0 alpha:1.0];
        }else if (indexPath.row >= 17 && indexPath.row <= 24)
        {
            cell.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:109.0/255.0 blue:181.0/255.0 alpha:1.0];
            
        }
        else{
            cell.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:167.0/255.0 blue:219.0/255.0 alpha:1.0];
            
        }
        
        [cell.lblRightShadow setHidden:YES];
        cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

        
        for (id value in headingButtonNames) {
            
            if ([headingButtonNames indexOfObject:value] == indexPath.row) {
                [cell.btnName setTitle:value forState:UIControlStateNormal];
                [cell.btnName addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
                cell.btnName.tag = [[tagArray objectAtIndex:indexPath.row] integerValue];
                cell.btnName.secondTag = indexPath.row;
                cell.btnName.titleLabel.numberOfLines = 2;
                if (indexPath.row == 16) {
                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                    
                }else if (indexPath.row == 17) {
                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                    
                }else if (indexPath.row == 18) {
                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                    
                }else if (indexPath.row == 19) {
                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                    
                }
                if ([selectedHeading isEqualToString: cell.btnName.titleLabel.text]) {
                    [cell.btnName setTitleColor: [ UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f] forState:UIControlStateNormal];
                }
                else{
                    [cell.btnName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                
                
                break;
            }
        }
        cell.btnName.userInteractionEnabled = YES;
        
    }
    else
    {
            [cell.lblRightShadow setHidden:(indexPath.row == 0 ? NO : YES)];
        if (!cell.lblRightShadow.isHidden) {
            cell.lblRightShadow.clipsToBounds = NO;
            [self setShadow:cell.lblRightShadow.layer];
        }
            
        if (indexPath.section % 2 != 0) {
            cell.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
            
        }else
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        [cell.btnName setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        cell.btnName.userInteractionEnabled = NO;
        

        for (id temp in headingKeyArray) {
            if ([headingKeyArray indexOfObject:temp] == indexPath.row) {
                NSString* str = [AppCommon checkNull:[[PlayerListArray objectAtIndex:indexPath.section-1]valueForKey:temp]];
                if([temp isEqualToString:@"PlayerName"])
                {
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    NSLog(@"Player Name %@ ",str);
                }
                else
                {
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                }
                [cell.btnName setTitle:str forState:UIControlStateNormal];
                break;
            }
        }
        
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    PlayerStatsVC * nextVC = [[PlayerStatsVC alloc]init];
    nextVC = (PlayerStatsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayerStats"];
    nextVC.SelectedPlayerCode = [[PlayerListArray objectAtIndex:indexPath.section-1] valueForKey:@"PlayerCode"];
    [self.navigationController pushViewController:nextVC animated:YES];

}
-(void)setShadow:(CALayer *)layer
{
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOffset = CGSizeMake(10,3);
    layer.shadowOpacity = 1.0;

}
@end
