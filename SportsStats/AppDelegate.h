//
//  AppDelegate.h
//  SportsStats
//
//  Created by apple on 05/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSMutableArray *ArrayCompetition;
@property (strong, nonatomic) NSMutableArray *ArrayTeam;
@property (strong, nonatomic) NSMutableArray *ArrayIPL_teamplayers;
@property (strong, nonatomic) NSMutableArray *MainArray;
@property (strong, nonatomic) NSMutableArray *LocalNotificationUserInfoArray;
@property (strong, nonatomic) UIStoryboard *storyBoard;


@end

