//
//  ExpendedView.m
//  SportsStats
//
//  Created by Apple on 09/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import "ExpendedView.h"
#import "DetailCell.h"
#import "PlayerStatsVC.h"
#import "BowlerCell.h"
@implementation ExpendedView
@synthesize delegate;
@synthesize playerDetailArray;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    //NSMutableArray * objArray = [[NSMutableArray alloc]initWithObjects:@"Ram", nil];
    _DetailTblEnable= YES;
//    _arrayForBool=[[NSMutableArray alloc]init];
//    for (int i=0; i< [objArray count]; i++) {
//        [_arrayForBool addObject:[NSNumber numberWithBool:NO]];
//    }
//    self.expendTblHeight.constant = 100;  //self.expendTbl.contentSize.height+playerDetailArray.count*60;
//    self.expandviewHeight.constant = 100;  //self.expendTblHeight.constant-10;

}
-(NSString *)headerTittlevalueMethod:(int)indexvalue
{
    NSMutableArray * objHeaderAarray;
    if(self.isBatting)
    {
        objHeaderAarray = [[NSMutableArray alloc]initWithObjects:@"competitionName",@"Matches",@"Inns",@"Runs",@"Balls",@"BatSR",@"NOs",@"HS",@"BatAve",@"dotspercent",@"dotsfreq",@"ones",@"Fours",@"Sixs",@"boundariespercent",@"boundaryfrequency",@"thirties",@"fifties",@"thirtiespart",@"fiftiespart", nil];
    }
    else
    {
        objHeaderAarray = [[NSMutableArray alloc]initWithObjects:@"competitionName",@"Matches",@"Inns",@"Runs",@"Balls",@"wickets",@"BowlSR",@"BowlAve",@"Econ",@"Threes",@"Noballs",@"Wides", nil];
    }
    NSString * objStr = [objHeaderAarray objectAtIndex:indexvalue];
    
    return objStr;
}
-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
//- (void)resizeTableViewFrameHeight
//{
//    UITableView *tableView = self.expendTbl;
//    CGRect frame = tableView.frame;
//    frame.size.width = [tableView sizeThatFits:CGSizeMake(frame.size.width, HUGE_VALF)].width;
//    tableView.frame = frame;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
#pragma  mark Table DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_DetailTblEnable)
    {
        return [self.playerDetailArray count];
    }
    else
    {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(_DetailTblEnable)
    {
        return 40;
    }
    return 0;
}
#pragma mark - Creating View for TableView Section

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(_DetailTblEnable)
    {
        UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280,40)];
        sectionView.tag=section;
        int titlecount;
        if(self.isBatting == YES)
        {
            titlecount = 20;
        }
        else
        {
            titlecount = 12;
        }
        for(int i=0; i< titlecount; i++)
        {
            UILabel *viewLabel;
            if(i==0)
            {
                viewLabel= (self.isBatting==NO)? [[UILabel alloc]initWithFrame:CGRectMake(5, 0,150, 40)]:[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 150, 40)];
            }
            else
            {
                viewLabel=(self.isBatting==NO)? [[UILabel alloc]initWithFrame:CGRectMake(i*77+130, 0, 75, 40)]:[[UILabel alloc]initWithFrame:CGRectMake(i*85+130, 0, 83, 40)];
            }
        //UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*85, 0, 83, 40)];
        viewLabel.backgroundColor=[UIColor whiteColor];
        viewLabel.textColor=[UIColor blackColor];
        //viewLabel.font=[UIFont systemFontOfSize:16];
        viewLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        viewLabel.textAlignment= NSTextAlignmentCenter;
            NSString * objStr = [self headerTittlevalueMethod:i];
         if([objStr isEqualToString:@"competitionName"])
         {
             viewLabel.text =@"All";
         }
            else
            {
        viewLabel.text=[NSString stringWithFormat:@"%@",[[self.playerDetailArray valueForKey:objStr] objectAtIndex:section]];
            }
        [sectionView addSubview:viewLabel];
        }
        /********** Add a custom Separator with Section view *******************/
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.expendTbl.frame.size.width-15, 1)];
        separatorLineView.backgroundColor = [UIColor blackColor];
        [sectionView addSubview:separatorLineView];
        
        /********** Add UITapGestureRecognizer to SectionView   **************/
        
        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
        [sectionView addGestureRecognizer:headerTapped];
        
        return  sectionView;
        
    }
    return nil ;
}
#pragma mark - Table header gesture tapped

- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
    if (indexPath.row == 0) {
        if(_arrayForBool.count>0)
        {
        BOOL collapsed  = [[_arrayForBool objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<[self.expendplayerDetailArray count]; i++) {
            if (indexPath.section==i) {
                [_arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        if(collapsed!= YES)
        {
            self.expendTblHeight.constant = (_arrayForBool.count == 1)? _arrayForBool.count*100:_arrayForBool.count*50;
            self.expandviewHeight.constant = self.expendTblHeight.constant;
             [self.delegate horzaticalscrollviewHeightMethod:self.expandviewHeight.constant+45];
        }
        else{
            self.expendTblHeight.constant = self.expendTbl.contentSize.height-45;
            self.expandviewHeight.constant = _arrayForBool.count*50;  //self.expendTblHeight.constant;
             [self.delegate horzaticalscrollviewHeightMethod:self.playerDetailArray.count*50+50];
        }
        [self.expendTbl reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_DetailTblEnable)
    {
        if(_arrayForBool.count>0)
        {
        if ([[_arrayForBool objectAtIndex:section] boolValue]) {
            return self.expendplayerDetailArray.count;
        }
        
        else
             return self.playerDetailArray.count;
    }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_DetailTblEnable)
    {
        if(_arrayForBool.count>0)
        {
        if ([[_arrayForBool objectAtIndex:indexPath.section] boolValue]) {
            return 40;
        }
        }
        return 0;
    }
    else
    {
        return 44;
    }
}

#pragma mark Table Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *simpleTableIdentifier = @"DetailCell";
        static NSString *BowlerTableIdentifier = @"BowlerCell";
     if(self.isBatting == YES)
     {
        DetailCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell==nil) {
            cell=[[DetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        }
        
        
        BOOL manyCells  = [[_arrayForBool objectAtIndex:indexPath.section] boolValue];
        
        /********** If the section supposed to be closed *******************/
        if(!manyCells)
        {
            cell.backgroundColor=[UIColor clearColor];
            
            cell.textLabel.text=@"";
        }
        /********** If the section supposed to be Opened *******************/
        else
        {
            
            cell.competition_lbl.text = [[self.expendplayerDetailArray valueForKey:@"competitionName"] objectAtIndex:indexPath.row];
            cell.match_lbl.text=[[self.expendplayerDetailArray valueForKey:@"Matches"] objectAtIndex:indexPath.row];
            cell.inns_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Inns"] objectAtIndex:indexPath.row];
            cell.runs_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Runs"] objectAtIndex:indexPath.row];
            cell.balls_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Balls"] objectAtIndex:indexPath.row];
            cell.sr_lbl.text = [[self.expendplayerDetailArray valueForKey:@"BatSR"] objectAtIndex:indexPath.row];
            cell.no_lbl.text = [[self.expendplayerDetailArray valueForKey:@"NOs"] objectAtIndex:indexPath.row];
            cell.hs_lbl.text = [[self.expendplayerDetailArray valueForKey:@"HS"] objectAtIndex:indexPath.row];
            
            cell.avg_lbl.text = [[self.expendplayerDetailArray valueForKey:@"BatAve"] objectAtIndex:indexPath.row];
            
            cell.db_lbl.text = [[self.expendplayerDetailArray valueForKey:@"dotspercent"] objectAtIndex:indexPath.row];
            
            cell.dbFrq_lbl.text = [[self.expendplayerDetailArray valueForKey:@"dotsfreq"] objectAtIndex:indexPath.row];
            cell.oncePer_lbl.text = [[self.expendplayerDetailArray valueForKey:@"ones"] objectAtIndex:indexPath.row];
            cell.fourPer_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Fours"] objectAtIndex:indexPath.row];
            cell.sixPer_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Sixs"] objectAtIndex:indexPath.row];
            cell.bdry_lbl.text = [[self.expendplayerDetailArray valueForKey:@"boundariespercent"] objectAtIndex:indexPath.row];
            cell.bdryFeq_lbl.text = [[self.expendplayerDetailArray valueForKey:@"boundaryfrequency"] objectAtIndex:indexPath.row];
            cell.thirtyplus_lbl.text = [[self.expendplayerDetailArray valueForKey:@"thirties"] objectAtIndex:indexPath.row];
            cell.fityplus_lbl.text = [[self.expendplayerDetailArray valueForKey:@"fifties"] objectAtIndex:indexPath.row];
            cell.thirtypluspartnership_lbl.text = [[self.expendplayerDetailArray valueForKey:@"thirtiespart"] objectAtIndex:indexPath.row];
            cell.fiftpluspartnership_lbl.text = [[self.expendplayerDetailArray valueForKey:@"fiftiespart"] objectAtIndex:indexPath.row];
            
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone ;
        }
        //cell.textLabel.textColor=[UIColor blackColor];
        
        /********** Add a custom Separator with cell *******************/
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.expendTbl.frame.size.width-15, 1)];
        separatorLineView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:separatorLineView];
        
        return cell;
     }
    else
    {
        BowlerCell *cell=[tableView dequeueReusableCellWithIdentifier:BowlerTableIdentifier];
        if (cell==nil) {
            cell=[[BowlerCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        }
        
        
        BOOL manyCells  = [[_arrayForBool objectAtIndex:indexPath.section] boolValue];
        
        /********** If the section supposed to be closed *******************/
        if(!manyCells)
        {
            cell.backgroundColor=[UIColor clearColor];
            
            cell.textLabel.text=@"";
        }
        /********** If the section supposed to be Opened *******************/
        else
        {
            cell.competition_lbl.text =[[self.expendplayerDetailArray valueForKey:@"competitionName"] objectAtIndex:indexPath.row];
            cell.match_lbl.text=[[self.expendplayerDetailArray valueForKey:@"Matches"] objectAtIndex:indexPath.row];
            cell.inns_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Inns"] objectAtIndex:indexPath.row];
            cell.runs_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Runs"] objectAtIndex:indexPath.row];
            cell.balls_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Balls"] objectAtIndex:indexPath.row];
            cell.wkt_lbl.text = [[self.expendplayerDetailArray valueForKey:@"wickets"] objectAtIndex:indexPath.row];
            cell.sr_lbl.text = [[self.expendplayerDetailArray valueForKey:@"BowlSR"] objectAtIndex:indexPath.row];
            cell.avg_lbl.text = [[self.expendplayerDetailArray valueForKey:@"BowlAve"] objectAtIndex:indexPath.row];
            
            cell.eco_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Econ"] objectAtIndex:indexPath.row];
            
            cell.threeWkt_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Threes"] objectAtIndex:indexPath.row];
            
            cell.noBall_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Noballs"] objectAtIndex:indexPath.row];
            cell.wides_lbl.text = [[self.expendplayerDetailArray valueForKey:@"Wides"] objectAtIndex:indexPath.row];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone ;
        }
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.expendTbl.frame.size.width-15, 1)];
        separatorLineView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:separatorLineView];
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
        
        [self.expendTbl reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.expendTblHeight.constant = self.expendTbl.contentSize.height+60;

}

@end
