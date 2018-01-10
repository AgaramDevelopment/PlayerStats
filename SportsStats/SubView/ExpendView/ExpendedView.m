//
//  ExpendedView.m
//  SportsStats
//
//  Created by Apple on 09/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import "ExpendedView.h"
#import "DetailCell.h"
@implementation ExpendedView

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
    _detailArray = [[NSMutableArray alloc]initWithObjects:@"Ram",@"Ram", nil];
    _DetailTblEnable= YES;
    _arrayForBool=[[NSMutableArray alloc]init];
    for (int i=0; i<[_detailArray count]; i++) {
        [_arrayForBool addObject:[NSNumber numberWithBool:NO]];
    }
    self.expendTblHeight.constant = self.expendTbl.contentSize.height+_detailArray.count*60;
    self.expandviewHeight.constant = self.expendTblHeight.constant-10;

}
-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (void)resizeTableViewFrameHeight
{
    UITableView *tableView = self.expendTbl;
    CGRect frame = tableView.frame;
    frame.size.width = [tableView sizeThatFits:CGSizeMake(frame.size.width, HUGE_VALF)].width;
    tableView.frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
#pragma  mark Table DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_DetailTblEnable)
    {
        return [_detailArray count];
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
        for(int i=0; i< 19; i++)
        {
        UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(i*85, 0, 83, 40)];
        viewLabel.backgroundColor=[UIColor clearColor];
        viewLabel.textColor=[UIColor blackColor];
        //viewLabel.font=[UIFont systemFontOfSize:16];
        viewLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        viewLabel.textAlignment= UITextAlignmentCenter;
        viewLabel.text=[NSString stringWithFormat:@"%@",[_detailArray objectAtIndex:section]];
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
        BOOL collapsed  = [[_arrayForBool objectAtIndex:indexPath.section] boolValue];
        for (int i=0; i<[_detailArray count]; i++) {
            if (indexPath.section==i) {
                [_arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
            }
        }
        if(collapsed!= YES)
        {
            self.expendTblHeight.constant = self.expendTbl.contentSize.height+_arrayForBool.count*60;
            self.expandviewHeight.constant = self.expendTblHeight.constant;
        }
        else{
            self.expendTblHeight.constant = self.expendTbl.contentSize.height-65;
            self.expandviewHeight.constant = self.expendTblHeight.constant;
        }
        [self.expendTbl reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_DetailTblEnable)
    {
        if ([[_arrayForBool objectAtIndex:section] boolValue]) {
            return _detailArray.count;
        }
        else
            return 0;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_DetailTblEnable)
    {
        if ([[_arrayForBool objectAtIndex:indexPath.section] boolValue]) {
            return 40;
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
            cell.match_lbl.text=[NSString stringWithFormat:@"%@ %d",[_detailArray objectAtIndex:indexPath.section],indexPath.row+1];
            NSLog(@"text:%@",cell.match_lbl.text);
            cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
           // cell.backgroundColor=[UIColor lightGrayColor];
            //cell.imageView.image=[UIImage imageNamed:@"point.png"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone ;
        }
        //cell.textLabel.textColor=[UIColor blackColor];
        
        /********** Add a custom Separator with cell *******************/
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.expendTbl.frame.size.width-15, 1)];
        separatorLineView.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:separatorLineView];
        
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
        
        [self.expendTbl reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.expendTblHeight.constant = self.expendTbl.contentSize.height+60;

}

@end
