//
//  SeachView.h
//  SportsStats
//
//  Created by Apple on 09/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SeachView : UIView

@property(nonatomic,strong) NSMutableArray *tableDataArray;
@property(assign) BOOL searchEnabled;
@property (nonatomic,strong) IBOutlet UITableView * search_Tbl;
@property (nonatomic,strong) IBOutlet UISearchBar * search_Bar;
@property (nonatomic, strong) NSArray *searchResult;
@end
