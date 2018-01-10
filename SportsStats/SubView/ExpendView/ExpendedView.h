//
//  ExpendedView.h
//  SportsStats
//
//  Created by Apple on 09/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpendedView : UIView
@property(nonatomic,strong) NSMutableArray * detailArray;
@property(nonatomic,strong) NSMutableArray  *arrayForBool;
@property(assign) BOOL DetailTblEnable;

@property (nonatomic,strong) IBOutlet UITableView * expendTbl;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * expendTblHeight;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * expandviewHeight;
@end
