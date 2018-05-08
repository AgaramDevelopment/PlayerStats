//
//  ExpendedView.h
//  SportsStats
//
//  Created by Apple on 09/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpendDelegate <NSObject>
@required
-(void)horzaticalscrollviewHeightMethod:(double)height;

@end

@interface ExpendedView : UIView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)  id <ExpendDelegate> delegate;

@property(nonatomic,strong) NSMutableArray * playerDetailArray;
@property (nonatomic,strong) NSMutableArray * expendplayerDetailArray;
@property(nonatomic,strong) NSMutableArray  *arrayForBool;
@property(assign) BOOL DetailTblEnable;
@property (assign) BOOL isBatting;

@property (nonatomic,strong) IBOutlet UITableView * expendTbl;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * expendTblHeight;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * expandviewHeight;

@end
