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
    //self.search_Tbl.hidden = YES;
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
@end
