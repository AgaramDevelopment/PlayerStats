//
//  SeachView.m
//  SportsStats
//
//  Created by Apple on 09/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import "SeachView.h"

@implementation SeachView

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
    self.search_Tbl.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:1];
    self.search_Tbl.layer.cornerRadius = 5;
    self.search_Tbl.layer.shadowOpacity = 0.8;
    self.search_Tbl.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.search_Tbl.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.search_Tbl.layer.borderWidth = 1.0;
    self.search_Tbl.layer.masksToBounds= YES;
    self.search_Tbl.hidden = YES;
    [self allviewSetborder];
    [self initialization];
}
-(void)allviewSetborder
{
    self.search_Bar.layer.borderWidth = 0.5;
    self.search_Bar.layer.borderColor = [UIColor lightTextColor].CGColor;
    self.search_Bar.layer.masksToBounds = YES;
}
-(void)initialization
{
    _tableDataArray = [[NSMutableArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    
    self.searchResult = [NSMutableArray arrayWithCapacity:[_tableDataArray count]];
    self.search_Tbl.hidden=YES;
    
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}
#pragma  mark Table DataSource Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
return 1;
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
#pragma mark - Creating View for TableView Section

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if(_DetailTblEnable)
//    {
//        UIView *sectionView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280,40)];
//        sectionView.tag=section;
//        UILabel *viewLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.playerDetail.frame.size.width-10, 40)];
//        viewLabel.backgroundColor=[UIColor clearColor];
//        viewLabel.textColor=[UIColor blackColor];
//        viewLabel.font=[UIFont systemFontOfSize:15];
//        viewLabel.text=[NSString stringWithFormat:@"%@",[_detailArray objectAtIndex:section]];
//        [sectionView addSubview:viewLabel];
//        /********** Add a custom Separator with Section view *******************/
//        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.playerDetail.frame.size.width-15, 1)];
//        separatorLineView.backgroundColor = [UIColor blackColor];
//        [sectionView addSubview:separatorLineView];
//
//        /********** Add UITapGestureRecognizer to SectionView   **************/
//
//        UITapGestureRecognizer  *headerTapped   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionHeaderTapped:)];
//        [sectionView addGestureRecognizer:headerTapped];
//
//        return  sectionView;
//
//    }
//    return nil ;
//}
#pragma mark - Table header gesture tapped

//- (void)sectionHeaderTapped:(UITapGestureRecognizer *)gestureRecognizer{
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:gestureRecognizer.view.tag];
//    if (indexPath.row == 0) {
//        BOOL collapsed  = [[_arrayForBool objectAtIndex:indexPath.section] boolValue];
//        for (int i=0; i<[_detailArray count]; i++) {
//            if (indexPath.section==i) {
//                [_arrayForBool replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:!collapsed]];
//            }
//        }
//        [self.playerDetail reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    }
//
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(_DetailTblEnable)
//    {
//        if ([[_arrayForBool objectAtIndex:section] boolValue]) {
//            return _detailArray.count;
//        }
//        else
//            return 0;
//    }
//    else
//    {
        if(_searchEnabled)
        {
            return  self.searchResult.count;
        }
        else
        {
            return [_tableDataArray count];
        }
    //}
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(_DetailTblEnable)
//    {
//        if ([[_arrayForBool objectAtIndex:indexPath.section] boolValue]) {
//            return 40;
//        }
//        return 0;
//    }
//    else
//    {
        return 44;
    //}
}

#pragma mark Table Delegate Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(_DetailTblEnable)
//    {
//        static NSString *simpleTableIdentifier = @"DetailCell";
//
//        DetailCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//        if (cell==nil) {
//            cell=[[DetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
//        }
//
//
//        BOOL manyCells  = [[arrayForBool objectAtIndex:indexPath.section] boolValue];
//
//        /********** If the section supposed to be closed *******************/
//        if(!manyCells)
//        {
//            cell.backgroundColor=[UIColor clearColor];
//
//            cell.textLabel.text=@"";
//        }
//        /********** If the section supposed to be Opened *******************/
//        else
//        {
//            cell.match_lbl.text=[NSString stringWithFormat:@"%@ %d",[detailArray objectAtIndex:indexPath.section],indexPath.row+1];
//            cell.textLabel.font=[UIFont systemFontOfSize:15.0f];
//            cell.backgroundColor=[UIColor whiteColor];
//            cell.imageView.image=[UIImage imageNamed:@"point.png"];
//            cell.selectionStyle=UITableViewCellSelectionStyleNone ;
//        }
//        cell.textLabel.textColor=[UIColor blackColor];
//
//        /********** Add a custom Separator with cell *******************/
//        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(15, 40, self.playerDetail.frame.size.width-15, 1)];
//        separatorLineView.backgroundColor = [UIColor blackColor];
//        [cell.contentView addSubview:separatorLineView];
//
//        return cell;
//    }
//    else
//    {
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
    //}
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(_DetailTblEnable)
//    {
//        [_arrayForBool replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
//
//        [self.playerDetail reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//    else
//    {
    
        self.search_Bar.text = [_searchResult objectAtIndex:indexPath.row];
        self.search_Tbl.hidden = YES;
    
    //}
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
@end
