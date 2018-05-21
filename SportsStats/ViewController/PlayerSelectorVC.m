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
    CustomNavigation * objCustomNavigation;
    NSInteger* selectedIndex;
}

@end

@implementation PlayerSelectorVC
@synthesize collectionPlayerList;

@synthesize tapView;
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
    /*
     
     "PlayerCode": "PYC0000054",
     "PlayerName": "ASHWIN R",
     "PlayerPhoto": null,
     "Origin": "",
     "CappedOrNot": "UNCAPPED",
     "PlayerType": null,
     "BatStyle": "Right Hand Bat",
     "BatOrder": "Lower",
     "Matches": "2",
     "Inns": "2",
     "NOs": "0",
     "Runs": "64",
     "Balls": "38",
     "HS": "49",
     "BatAve": "32.00",
     "BatSR": "168.42",
     "dots": "10",
     "dotspercent": "15.63",
     "dotsfreq": null,
     "ones": null,
     "boundaries": "62.50",
     "boundariespercent": null,
     "boundaryfrequency": null,
     "Fours": "4",
     "Sixs": "4",
     "thirties": "1",
     "fifties": "0",
     "thirtiespart": null,
     "fiftiespart": null,
     "hunderds": "0",
     "BowlRuns": "40",
     "BowlBalls": "6",
     "BowlInns": "2",
     "BowlDB": "15",
     "BowlDBPercent": "41",
     "Bowlboundariespercent": "55",
     "wickets": "2",
     "BowlSR": "18.00",
     "BowlAve": "20.00",
     "Threes": null,
     "Wides": null,
     "Noballs": null,
     "Econ": "6.67",
     "threes": "0",
     "catches": "0",
     "stumpings": "0",
     "playerTypecode": "MSC008",
     "batstylecode": "MSC013",
     "bowlstylecode": "RAOS",
     "competitionCode": null,
     "competitionName": null,
     "className": "row02"
     
     */
    
    headingKeyArray = @[@"PlayerName",@"BatStyle",@"Inns",@"Runs",@"Balls",@"dots",@"BatSR",@"HS",@"BatAve",@"Fours",@"Sixs",@"boundaries",@"dotspercent",@"thirties",@"fifties",@"BowlInns",@"BowlRuns",@"BowlBalls",@"wickets",@"Econ",@"BowlAve",@"BowlSR",@"BowlDB",@"BowlDBPercent",@"Bowlboundariespercent",@"threes",@"catches",@"stumpings"]; //28


    headingButtonNames = @[@"Player",@" Bat\nStyle",@"Inns",@"Runs",@"BF",@"DB",@"SR",@"HS",@"Avg",@"4s",@"6s",@"Bdry %",@"DB  %",@"30s",@"50s",@"Bowl\nInns",@"Bowl\nRuns",@"Bowl\nOvers",@"Wkts",@"Eco",@"Bowl\nAvg",@"Bowl\nSR",@"Bow\nDB",@"Bowl\nDB %",@"Bowl\nBdry %",@"3Wkts",@"Catch",@"Stump"];

    
    [collectionPlayerList registerNib:[UINib nibWithNibName:@"PlayerListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCellIdentifier"];


    for (id tag in headingKeyArray.objectEnumerator) {
        [tagArray addObject:@0];
    }

    [self fetchPlayerSelectionWS];
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation_iPad" bundle:nil];
    objCustomNavigation.img1Leading.constant = 500;
    objCustomNavigation.img2Trailing.constant = 500;

    [self customnavigationmethod];

    battingOrderArray = [[NSMutableArray alloc] initWithArray:
                         @[@{
                               @"playerTypeDesc":@"All",
                               @"playerTypeCode":@""
                               },@{@"playerTypeDesc":@"Top",
                              @"playerTypeCode":@"Top"
                              }, @{
                              @"playerTypeDesc":@"Middle",
                              @"playerTypeCode":@"Middle"
                              },@{
                              @"playerTypeDesc":@"Tail Ender",
                              @"playerTypeCode":@"Tail Ender"
                              },@{
                              @"playerTypeDesc":@"Lower Order",
                              @"playerTypeCode":@"lower"
                              }]];

    
    
//    playerOrginArray = [[NSMutableArray alloc] initWithArray:
//                        @[@{@"playerTypeDesc":@"Indian Capped",
//                           @"playerTypeCode":@"CAPPED"
//                           }, @{
//                           @"playerTypeDesc":@"Indian Uncapped",
//                           @"playerTypeCode":@"UNCAPPED"
//                           }, @{
//                           @"playerTypeDesc":@"Foreigner",
//                           @"playerTypeCode":@"FOREIGNER"
//                           },@{
//                           @"playerTypeDesc":@"ALL",
//                           @"playerTypeCode":@""
//                           }]];
    
    playerOrginArray = [[NSMutableArray alloc] initWithArray:
                        @[@{@"playerTypeDesc":@"All",
                              @"playerTypeCode":@""
                              }]];
    
    playerBowlingStyleArray = [[NSMutableArray alloc] initWithArray:
                               @[@{@"playerTypeDesc":@"All",
                                  @"playerTypeCode":@""
                                  },
                                @{@"playerTypeDesc":@"RA Fast Medium",
                                  @"playerTypeCode":@"RAFM"
                                  },
                                @{@"playerTypeDesc":@"RA OFF Spin",
                                  @"playerTypeCode":@"RAOS"
                                  },
                                @{@"playerTypeDesc":@"RA Leg Spin",
                                  @"playerTypeCode":@"RALS"
                                  },
                                @{@"playerTypeDesc":@"LA Fast Medium",
                                  @"playerTypeCode":@"LAFM"
                                  },
                                @{@"playerTypeDesc":@"LA Orthodox",
                                  @"playerTypeCode":@"LAO"
                                  },
                                @{@"playerTypeDesc":@"LA Chinman",
                                  @"playerTypeCode":@"LAC"
                                  }]];
                                
    
    
    filterDropDownTblView=[[UITableView alloc]init];
    filterDropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    filterDropDownTblView.dataSource = self;
    filterDropDownTblView.delegate = self;
    
    [[COMMON logoutbtn] setHidden:NO];
    [COMMON drawLogoutButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    objCustomNavigation.img1Leading.constant = 50;
    objCustomNavigation.img2Trailing.constant = 50;
    
    [UIView animateWithDuration:0.4 animations:^{
        [objCustomNavigation.view layoutIfNeeded];
    }];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    objCustomNavigation.img1Leading.constant = 500;
    objCustomNavigation.img2Trailing.constant = 500;

}

-(void)customnavigationmethod
{
    [self.view addSubview:objCustomNavigation.view];
    
    objCustomNavigation.img1Leading.constant = 500;
    objCustomNavigation.img2Trailing.constant = 500;

    objCustomNavigation.tittle_lbl.text=@"TNPL-3 Player Auction 2018";
    objCustomNavigation.nav_header_img.image = [UIImage imageNamed:@"withText"];
    
    [objCustomNavigation.img1 setHidden:NO];
    [objCustomNavigation.img2 setHidden:NO];

    
    [objCustomNavigation.img1 setImage:[UIImage imageNamed:@"TNPL"]];
    [objCustomNavigation.img2 setImage:[UIImage imageNamed:@"Tuti_patriots"]];
    
//    objCustomNavigation.img1.layer.cornerRadius = objCustomNavigation.img1.frame.size.height/2;
//    objCustomNavigation.img1.layer.masksToBounds = YES;
//
//    objCustomNavigation.img2.layer.cornerRadius = objCustomNavigation.img1.frame.size.height/2;
//    objCustomNavigation.img2.layer.masksToBounds = YES;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:objCustomNavigation.img1.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:objCustomNavigation.img1.frame.size];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];

    maskLayer1.frame = objCustomNavigation.img1.bounds;
    maskLayer1.path  = maskPath.CGPath;
    
    maskLayer2.frame = objCustomNavigation.img1.bounds;
    maskLayer2.path  = maskPath.CGPath;

    objCustomNavigation.img1.layer.mask = maskLayer1;
    objCustomNavigation.img2.layer.mask = maskLayer2;

    
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.filter_btn.hidden = YES;
    objCustomNavigation.Cancelbtn.hidden = YES;
    objCustomNavigation.summarybtn.hidden=YES;
    objCustomNavigation.nav_search_view.hidden = YES;
    

    dispatch_async(dispatch_get_main_queue(), ^{
        
        objCustomNavigation.img1Leading.constant = 50;
        objCustomNavigation.img2Trailing.constant = 50;

        [UIView animateWithDuration:0.4 animations:^{
            [objCustomNavigation.view layoutIfNeeded];
        }];

    });

    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == filterDropDownTblView){
        
        [tapView setHidden:(DropDownArray.count ? NO : YES)];
        return  DropDownArray.count;
        
    }

    return 0;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        UITableViewCell *otherCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (otherCell == nil) {
            otherCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        otherCell.backgroundColor = [UIColor clearColor];
    
    
    
//    if(isPlayerOrginOpen){
//        _playerOrderLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
//        playerOrginFilterPos = indexPath.row;
//        self.playerOrderLbl.tag = indexPath.row;
//    }else if(isPlayerTypeOpen){
//        _playerTypeLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
//        playerTypeFilterPos = indexPath.row;
//        self.playerTypeLbl.tag = indexPath.row;
//    }else if(isBattingStyleOpen){
//        _battingStyleLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
//        battingStyleFilterPos = indexPath.row;
//        self.battingStyleLbl.tag = indexPath.row;
//    }else if(isBowlingStyleOpen){
//        _bowlingStyleLbl.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
//        bowlingStyleFilterPos = indexPath.row;
//        self.bowlingStyleLbl.tag = indexPath.row;
//    }else if(isBattingOrderOpen){
//        _lblBattingOrder.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
//        self.lblBattingOrder.tag = indexPath.row;
//    }

//        UIView *bgColorView = [[UIView alloc] init];
//        bgColorView.backgroundColor = [UIColor colorWithRed:(8/255.0f) green:(26/255.0f) blue:(77/255.0f) alpha:1.0f];
//        otherCell.selectedBackgroundView = bgColorView;
        otherCell.textLabel.textColor = [UIColor whiteColor];
        
        if(tableView == filterDropDownTblView){
            otherCell.textLabel.text = [[DropDownArray objectAtIndex:indexPath.row] valueForKey:@"playerTypeDesc"];
        }
        

        
        return otherCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if(tableView == filterDropDownTblView){
        
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
        
        [self closeView:nil];
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


- (IBAction)onClickPlayerOriginDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        }];

        [filterDropDownTblView removeFromSuperview];
        
    }
    
    if(!isPlayerOrginOpen){
        
        DropDownArray = [[NSMutableArray alloc] initWithArray: playerOrginArray];
        
        [self resetDropDownOpenStatus];
        isPlayerOrginOpen = YES;
        

        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);

        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        

        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4 animations:^{
                
                filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
            }];
        });

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:playerOrginFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }else{
        [self resetDropDownOpenStatus];
        
    }

}




- (IBAction)onClickPlayerTypeDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        }];

        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isPlayerTypeOpen){
        [self dropDownValueForPlayerType];
        [self resetDropDownOpenStatus];
        isPlayerTypeOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        
        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:playerTypeFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
        }];

    }else{
        [self resetDropDownOpenStatus];
        
    }
    
}

- (IBAction)onClickBattingStyleDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        }];

        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isBattingStyleOpen){
        
        [self dropDownValueForBattingStyle];
        [self resetDropDownOpenStatus];
        isBattingStyleOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        
        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:battingStyleFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
        }];

    }else{
        [self resetDropDownOpenStatus];
    }
    
}

- (IBAction)onClickBowlingStyleDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        }];

        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isBowlingStyleOpen){
        [self dropDownValueForBowlingStyle];
        [self resetDropDownOpenStatus];
        isBowlingStyleOpen = YES;
        
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);

//        [self dropDownValueForBowlingStyle];
        DropDownArray = playerBowlingStyleArray;
        
        [self.view addSubview:filterDropDownTblView];
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:bowlingStyleFilterPos inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
        }];

    }else{
        [self resetDropDownOpenStatus];
        
    }
    

    
}
- (IBAction)onClickBattingOrderStyleDD:(id)sender {
    
    if(filterDropDownTblView!=nil){
        
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        }];

        [filterDropDownTblView removeFromSuperview];
    }
    
    if(!isBowlingStyleOpen){

        isBattingOrderOpen = YES;
        DropDownArray = battingOrderArray;
        filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,0);
        [self.view addSubview:filterDropDownTblView];
        
        [filterDropDownTblView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_lblBattingOrder.tag inSection:0];
        [filterDropDownTblView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        [UIView animateWithDuration:0.4 animations:^{
            filterDropDownTblView.frame = CGRectMake([sender superview].frame.origin.x, collectionPlayerList.frame.origin.y -10 ,[sender frame].size.width,DropDownArray.count*45);
        }];

        
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
    
    
    [DropDownArray insertObject:@{@"playerTypeDesc":@"All",@"playerTypeCode":@""} atIndex:0];
    
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
    
    [DropDownArray insertObject:@{@"playerTypeDesc":@"All",@"playerTypeCode":@""} atIndex:0];

    
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
    
    
    [DropDownArray insertObject:@{@"playerTypeDesc":@"All",@"playerTypeCode":@""} atIndex:0];

    
    playerTypeArray = [[NSMutableArray alloc] initWithArray:DropDownArray];

}

-(void) filterPlayer{
    
    NSPredicate* predicate1,*predicate2,*predicate3,*predicate4,*predicate5;
    if([self.playerOrderLbl.text isEqualToString:@"All"])
    {
        predicate1 = [NSPredicate predicateWithFormat:@"CappedOrNot != %@ OR CappedOrNot == %@",@"",@""];
    }else{
        predicate1 = [NSPredicate predicateWithFormat:@"CappedOrNot == %@",[[playerOrginArray objectAtIndex:self.playerOrderLbl.tag]valueForKey:@"playerTypeCode"]];
    }

    if ([self.playerTypeLbl.text isEqualToString:@"All"]) {
        predicate2 = [NSPredicate predicateWithFormat:@"playerTypecode != %@ OR playerTypecode == %@",@"",@""];
    }else
    {
        predicate2 = [NSPredicate predicateWithFormat:@"playerTypecode == %@",[[playerTypeArray objectAtIndex:self.playerTypeLbl.tag]valueForKey:@"playerTypeCode"]];
    }


    if ([self.battingStyleLbl.text isEqualToString:@"All"]) {
        predicate3 = [NSPredicate predicateWithFormat:@"batstylecode != %@ OR batstylecode == %@",@"",@""];
    }else
    {
        predicate3 = [NSPredicate predicateWithFormat:@"batstylecode == %@",[[playerBattingStyleArray objectAtIndex:self.battingStyleLbl.tag]valueForKey:@"playerTypeCode"]];
    }

    if ([self.bowlingStyleLbl.text isEqualToString:@"All"]) {
        predicate4 = [NSPredicate predicateWithFormat:@"bowlstylecode != %@ OR bowlstylecode == %@",@"",@""];
    }else
    {
        predicate4 = [NSPredicate predicateWithFormat:@"bowlstylecode == %@",[[playerBowlingStyleArray objectAtIndex:self.bowlingStyleLbl.tag]valueForKey:@"playerTypeCode"]];
    }
    
    
    if ([self.lblBattingOrder.text isEqualToString:@"All"]) {
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
//        [collectionPlayerList.collectionViewLayout invalidateLayout];
    });
    
}

-(void)fetchPlayerSelectionWS
{
//    [COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        [AppCommon showLoading];
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FETCH_AUCTION_OVERALL_PLAYER_STATS]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        [manager POST:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
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
                
                // Player origin
                self.playerOrderLbl.text = @"All";
                self.playerOrderLbl.tag = 0;
                
                // player type
                self.playerTypeLbl.text = @"All";
                self.playerTypeLbl.tag = 0;
                
                // Batting style
                self.battingStyleLbl.text = @"All";
                self.battingStyleLbl.tag = 0;
                
                // Bowling style
                self.bowlingStyleLbl.text = @"All";
                self.bowlingStyleLbl.tag = 0;
                
                //Order
                self.lblBattingOrder.text = @"All";
                self.lblBattingOrder.tag = 0;
                
                
//                tempArray = [MainListArray valueForKey:@"BattingStyle"];
//                self.battingStyleLbl.text  = [[tempArray objectAtIndex:0] valueForKey:@"playerTypeDesc"];
//
//                tempArray = [MainListArray valueForKey:@"PlayerType"];
//                self.playerTypeLbl.text  = [[tempArray objectAtIndex:0] valueForKey:@"playerTypeDesc"];
//
//                self.playerOrderLbl.text  = [[playerOrginArray objectAtIndex:0] valueForKey:@"playerTypeDesc"];
//                self.lblBattingOrder.text = @"ALL";
//                self.playerOrderLbl.tag = 0;
//                self.playerTypeLbl.tag = 0;
//                self.battingStyleLbl.tag = 0;
//                self.bowlingStyleLbl.tag = 0;
//                self.lblBattingOrder.tag = 0;
                
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
            [AppCommon hideLoading];
             
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"failed");
            [COMMON webServiceFailureError:error];
            [AppCommon hideLoading];
             
            
        }];
    }
}

#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    [collectionView.collectionViewLayout invalidateLayout];

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
        
//        green = [UIColor colorWithRed:0.0 green:144.0/255.0 blue:81.0/255.0 alpha:1.0];
//        orange  = [UIColor colorWithRed:255.0/255.0 green:147.0/255.0 blue:0.0 alpha:1.0];
//        red  = [UIColor colorWithRed:255.0/255.0 green:38.0/255.0 blue:0.0 alpha:1.0];

        if(indexPath.row == 0)
        {
            cell.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:38.0/255.0 blue:0 alpha:1.0];

        }
        else if(indexPath.row >=1 && indexPath.row <= 14) // coulmn 1
        {
//            cell.backgroundColor = [UIColor colorWithRed:21.0/255.0 green:127.0/255.0 blue:182.0/255.0 alpha:1.0];
            cell.backgroundColor = [UIColor colorWithRed:0 green:84.0/255.0 blue:147.0/255.0 alpha:1.0];

        }
        else if (indexPath.row >= 14 && indexPath.row <= 25) {
            
//            cell.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:109.0/255.0 blue:181.0/255.0 alpha:1.0];
            cell.backgroundColor = [UIColor colorWithRed:0.0 green:144.0/255.0 blue:81.0/255.0 alpha:1.0];

        }
        else {
//            cell.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:167.0/255.0 blue:219.0/255.0 alpha:1.0];
            cell.backgroundColor = [UIColor colorWithRed:122.0/255.0 green:129.0/255.0 blue:255.0/255.0 alpha:1.0];

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
                
//                if (indexPath.row == 16) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }else if (indexPath.row == 17) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }else if (indexPath.row == 18) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }
//                else if (indexPath.row == 19) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }
                
                if ([selectedHeading isEqualToString: cell.btnName.titleLabel.text]) {
//                    [cell.btnName setTitleColor: [ UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f] forState:UIControlStateNormal];
                    [cell.btnName setTitleColor: [ UIColor colorWithRed:(1.0/255.0f) green:(25.0/255.0f) blue:(147.0/255.0f) alpha:1.0f] forState:UIControlStateNormal];

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

-(IBAction)closeView:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        filterDropDownTblView.frame = CGRectMake(filterDropDownTblView.frame.origin.x, filterDropDownTblView.frame.origin.y -10 ,filterDropDownTblView.frame.size.width,0);
    }];

    [tapView setHidden:YES];
    if(filterDropDownTblView!=nil){
        [filterDropDownTblView removeFromSuperview];
    }
    [self resetDropDownOpenStatus];


}

@end
