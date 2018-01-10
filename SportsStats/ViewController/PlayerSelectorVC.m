//
//  PlayerSelectorVC.m
//  SportsStats
//
//  Created by apple on 06/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import "PlayerSelectorVC.h"
#import "CustomNavigation.h"
#import "PlayerListTableViewCell.h"
#import "WebService.h"
#import "Config.h"
#import "AppCommon.h"



@interface PlayerSelectorVC ()
<UITableViewDelegate,UITableViewDataSource>
{
    NSArray* headingKeyArray;
    NSArray* playerOrginArray;
    NSMutableArray* tagArray;

    long playerOrginFilterPos;
    long playerTypeFilterPos;
    long battingStyleFilterPos;
    long bowlingStyleFilterPos;
    
    BOOL isPlayerOrginOpen;
    BOOL isPlayerTypeOpen;
    BOOL isBattingStyleOpen;
    BOOL isBowlingStyleOpen;

    
    UITableView *filterDropDownTblView;
    NSMutableArray* MainListArray;
    NSMutableArray* DropDownArray;
    NSMutableArray* PlayerListArray;

}

@end

@implementation PlayerSelectorVC
@synthesize tblPlayerList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isPlayerOrginOpen = NO;
     isPlayerTypeOpen = NO;
     isBattingStyleOpen = NO;
     isBowlingStyleOpen = NO;
    tagArray = [NSMutableArray new];
    
    playerOrginFilterPos = 0;
    playerTypeFilterPos = 0;
    battingStyleFilterPos = 0;
    bowlingStyleFilterPos = 0;
    
    headingKeyArray = @[@"PlayerName",@"Origin",@"BatStyle",@"BatOrder",@"Matches",@"Inns",@"NOs",@"Runs",@"Balls",@"HS",@"BatAve",@"BatSR",@"dots",@"boundaries",@"hunderds",@"fifties",@"0",@"Fours",@"Sixs",@"thirties",@"BowlRuns",@"BowlBalls",@"BowlAve",@"BowlSR",@"",@"wickets",@"3wAbove",@"Econ",@"catches",@"stumpings"];

    for (id tag in headingKeyArray.objectEnumerator) {
        [tagArray addObject:@0];
    }

    [self fetchPlayerSelectionWS];
    
    [self customnavigationmethod];
//    tagArray addObjectsFromArray:@[@0,@0,]
    
    
    
    playerOrginArray = [[NSMutableArray alloc] initWithArray:
                     @[
                       @{
                           @"playerTypeDesc":@"Indian Capped",
                           @"playerTypeCode":@"CAPPED"
                           }, @{
                           @"playerTypeDesc":@"Indian Uncapped",
                           @"playerTypeCode":@"UPCAPPED"
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
                
                NSLog(@"Button Name = %@",tempBut.titleLabel.text);
                NSLog(@"Button tag = %ld",(long)tempBut.tag);
                NSLog(@"Button second tag = %ld",(long)tempBut.secondTag);
            }
            
            
            
            
//            cell.btnPlayer.secondTag = 0;
//            cell.btnOrigin.secondTag = 1;
//
//            cell.btnStyle.secondTag = 2;
//            cell.btnOrder.secondTag = 3;
//            cell.btnMat.secondTag = 4;
//            cell.btnInns.secondTag = 5;
//            cell.btnNo.secondTag = 6;
//            cell.btnRuns.secondTag = 7;
//            cell.btnBF.secondTag = 8;
//            cell.btnHS.secondTag = 9;
//            cell.btnAve.secondTag = 10;
//            cell.btnSR.secondTag = 11;
//            cell.btnDB.secondTag = 12;
//            cell.btnBdry.secondTag = 13;
//            cell.btn100.secondTag = 14;
//            cell.btn50.secondTag = 15;
//            cell.btn0.secondTag = 16;
//            cell.btn4s.secondTag = 17;
//            cell.btn6s.secondTag = 18;
//
//            cell.btn30s.secondTag = 19;
//            cell.btnBowlRuns.secondTag = 20;
//            cell.btnBowlBalls.secondTag = 21;
//            cell.btnBowlAve.secondTag = 22;
//            cell.btnBowlSR.secondTag = 23;
//            cell.btnWkts.secondTag = 24;
//            cell.btn3wAbove.secondTag = 25;
//            cell.btnEcon.secondTag = 26;
//            cell.btnCatch.secondTag = 27;
//            cell.btnStump.secondTag = 28;
//
//            [cell.btnPlayer addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnOrigin addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnStyle addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnOrder addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnMat addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnInns addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnNo addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnRuns addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnBF addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnHS addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnAve addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnSR addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnDB addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnBdry addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btn100 addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btn50 addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
////            [cell.btn0 addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btn4s addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btn6s addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
            
            
//            [cell.btn30s addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnBowlRuns addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnBowlBalls addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnBowlAve addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnBowlSR addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnWkts addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            //        [cell.btn3wAbove addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnEcon addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnCatch addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
//            [cell.btnStump addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];

            
            return cell;
            
        }
        
        return NULL;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == tblPlayerList){
        
    }else if(tableView == filterDropDownTblView){
        
        if(isPlayerOrginOpen){
            _playerOrderLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            playerOrginFilterPos = indexPath.row;
        }else if(isPlayerTypeOpen){
            _playerTypeLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            playerTypeFilterPos = indexPath.row;
        }else if(isBattingStyleOpen){
            _battingStyleLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            battingStyleFilterPos = indexPath.row;
        }else if(isBowlingStyleOpen){
            _bowlingStyleLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
            bowlingStyleFilterPos = indexPath.row;
        }
        
        if(filterDropDownTblView!=nil){
            [filterDropDownTblView removeFromSuperview];
        }
        [self resetDropDownOpenStatus];
    }

}


-(void)btnActionForSorting:(CustomButton *)sender
{
    NSString* selectedKey = [headingKeyArray objectAtIndex:[sender secondTag]];
    
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
    
    NSArray* arr = [PlayerListArray sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:selectedKey ascending:isAscending selector:@selector(localizedStandardCompare:)]]];

    PlayerListArray = [NSMutableArray new];
    [PlayerListArray addObjectsFromArray:arr];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tblPlayerList reloadData];
    });
}






-(void) resetDropDownOpenStatus{
    isPlayerOrginOpen = NO;
    isPlayerTypeOpen = NO;
    isBattingStyleOpen = NO;
    isBowlingStyleOpen = NO;
}

- (IBAction)onClickSearchBtn:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    [self resetDropDownOpenStatus];

    [self filterPlayer];
}


- (IBAction)onClickPlayerOriginDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isPlayerOrginOpen){
        
        
        DropDownArray = [[NSMutableArray alloc] initWithArray: playerOrginArray];
        
        
        
        [self resetDropDownOpenStatus];
        isPlayerOrginOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake(_dropDownView.frame.origin.x+16, _dropDownView.frame.origin.y+60+80,200,DropDownArray.count*45);
        
//        filterDropDownTblView=[[UITableView alloc]initWithFrame:CGRectMake(_dropDownView.frame.origin.x+16, _dropDownView.frame.origin.y+60+80,200,DropDownArray.count*45)];
//        filterDropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//        filterDropDownTblView.dataSource = self;
//        filterDropDownTblView.delegate = self;
        
//         filterDropDownTblView.clipsToBounds = NO;
//        filterDropDownTblView.layer.masksToBounds = NO;
//
//         filterDropDownTblView.layer.shadowColor = [[UIColor blackColor] CGColor];
//        filterDropDownTblView.layer.shadowOffset = CGSizeMake(3,3);
//         filterDropDownTblView.layer.shadowOpacity = 0.1;

        
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
        
        
        
        [self resetDropDownOpenStatus];
        isPlayerTypeOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake(_dropDownView.frame.origin.x+8+238, _dropDownView.frame.origin.y+60+80,250,DropDownArray.count*45);
        
//        filterDropDownTblView=[[UITableView alloc]initWithFrame:CGRectMake(_dropDownView.frame.origin.x+16+238, _dropDownView.frame.origin.y+60+80,250,DropDownArray.count*45)];
//        filterDropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//        filterDropDownTblView.dataSource = self;
//        filterDropDownTblView.delegate = self;
        
        
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

        [self resetDropDownOpenStatus];
        isBattingStyleOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake(_dropDownView.frame.origin.x+8+518, _dropDownView.frame.origin.y+60+80,150,DropDownArray.count*45);
        
//        filterDropDownTblView=[[UITableView alloc]initWithFrame:CGRectMake(_dropDownView.frame.origin.x+16+518, _dropDownView.frame.origin.y+60+80,150,DropDownArray.count*45)];
//        filterDropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//        filterDropDownTblView.dataSource = self;
//        filterDropDownTblView.delegate = self;
        
        
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
        [self resetDropDownOpenStatus];
        isBowlingStyleOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake(_dropDownView.frame.origin.x+8+698, _dropDownView.frame.origin.y+60+80,200,DropDownArray.count*45);
        
//        filterDropDownTblView=[[UITableView alloc]initWithFrame:CGRectMake(_dropDownView.frame.origin.x+8+698, _dropDownView.frame.origin.y+60+80,200,DropDownArray.count*45)];
//        filterDropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
//        filterDropDownTblView.dataSource = self;
//        filterDropDownTblView.delegate = self;
        
        
        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bowlingStyleFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }else{
        [self resetDropDownOpenStatus];
        
    }
    
}

-(void) filterPlayer{
    
    NSString *genPattern = @"";

    
    NSString *val1 = @"";
    NSString *val2 = @"";
    NSString *val3 = @"";
    NSString *val4 = @"";
    
    int count = 0;
    
    //Set Filter position
    NSMutableArray *tempArray = [MainListArray valueForKey:@"BowlingStyle"];

    
    if(bowlingStyleFilterPos < tempArray.count  && tempArray.count>0){
        NSString *code = [[tempArray objectAtIndex:bowlingStyleFilterPos] valueForKey:@"playerTypeCode"];
        genPattern = @"bowlstylecode == %@";
        val1 = code;
        count = count +1;
    }
    
    tempArray = [MainListArray valueForKey:@"BattingStyle"];
    if(battingStyleFilterPos < tempArray.count  && tempArray.count>0){
        NSString *code = [[tempArray objectAtIndex:battingStyleFilterPos] valueForKey:@"playerTypeCode"];

        if([genPattern isEqualToString: @""]){
            genPattern =  @"batstylecode == %@";

        }else{
//             [genPattern stringByAppendingString:  [NSString stringWithFormat:@" and batstylecode == %@",code]];
            genPattern = [NSString stringWithFormat:@"%@ AND batstylecode == %%@",genPattern];

        }
        if([val1 isEqualToString:@""]){
            val1 = code;
        }else{
            val2 = code;
        }
        count = count +1;
        
      //  battingStyleVal = code;

    }
    
    tempArray = [MainListArray valueForKey:@"PlayerType"];
    if(playerTypeFilterPos < tempArray.count  && tempArray.count>0){
        NSString *code = [[tempArray objectAtIndex:playerTypeFilterPos] valueForKey:@"playerTypeCode"];
        if([genPattern isEqualToString: @""]){
            genPattern =  @"playerTypecode == %@";


        }else{
            genPattern = [NSString stringWithFormat:@"%@ AND playerTypecode == %%@",genPattern];
//             [genPattern stringByAppendingString: [NSString stringWithFormat:@" and playerTypeCode == %@",code]];

        }
        
        if([val1 isEqualToString:@""]){
            val1 = code;
        }else if([val2 isEqualToString:@""]){
            val2 = code;
        }else{
            val3 = code;
        }
        count = count +1;
        //playerType = code;

    }
    
    if(playerOrginFilterPos != (playerOrginArray.count-1) && playerOrginArray.count>0){
        NSString *code = [[playerOrginArray objectAtIndex:playerOrginFilterPos] valueForKey:@"playerTypeCode"];
        if([genPattern isEqualToString: @""]){
            //genPattern = [NSString stringWithFormat:@"CappedOrNot == %@",code];
            genPattern =  @"CappedOrNot == %@";

        }else{
//            [genPattern stringByAppendingString: [NSString stringWithFormat:@" and CappedOrNot == %@",code]];

            genPattern = [NSString stringWithFormat:@"%@ AND CappedOrNot == %%@",genPattern];

        }
        
        if([val1 isEqualToString:@""]){
            val1 = code;
        }else if([val2 isEqualToString:@""]){
            val2 = code;
        }else if([val3 isEqualToString:@""]){
            val3 = code;
        }else{
            val4 = code;
        }
        count = count +1;
        
        //playerOrgin = code;

    }
    
    
    
    
    if(count == 0){
        PlayerListArray = [MainListArray valueForKey:@"PlayerDetailsList"];
    }else{
        NSPredicate *predicate ;

        if(count == 4){
          predicate  = [NSPredicate predicateWithFormat:genPattern,val1,val2,val3,val4];
        }else if(count == 3){
          predicate  = [NSPredicate predicateWithFormat:genPattern,val1,val2,val3];
        }else if(count == 2){
            predicate  = [NSPredicate predicateWithFormat:genPattern,val1,val2];
        }else if(count == 1){
            predicate  = [NSPredicate predicateWithFormat:genPattern,val1];
        }
        
       // NSPredicate *predicate = [NSPredicate predicateWithFormat:genPattern,bowlingStyleVal,battingStyleVal,playerType,playerOrgin];
        //    NSArray *results = [directoryContents filteredArrayUsingPredicate:predicate];
        
        if(predicate != nil){
        
        NSArray *tempRootPlayer = [MainListArray valueForKey:@"PlayerDetailsList"];
        NSArray *fiteredArray = [tempRootPlayer filteredArrayUsingPredicate:predicate];
        
        PlayerListArray = [[NSMutableArray alloc] init];
        if(fiteredArray.count != 0){
            [PlayerListArray addObjectsFromArray:fiteredArray];

        }
        
        NSLog(@"FILTERED VALUE %@",PlayerListArray);
        }
    }
  
    [tblPlayerList reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [tblPlayerList setContentOffset:CGPointZero animated:NO];
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
        //        if(competition)   [dic    setObject:competition     forKey:@"Competitioncode"];
        //        if(teamcode)   [dic    setObject:teamcode     forKey:@"Teamcode"];
        //        if(self.matchCode)   [dic    setObject:self.matchCode     forKey:@"MatchCode"];
        
        
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
                
                _playerOrderLbl.text  = [[playerOrginArray objectAtIndex:0] valueForKey:@"playerTypeDesc"];
                
                
                
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

@end
