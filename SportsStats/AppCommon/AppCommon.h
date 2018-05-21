//
//  AppCommon.h
//  AlphaProTracker
//
//  Created by Mac on 21/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "WebService.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface AppCommon : NSObject
{
    UIView *loadingView;
    BOOL isPlayer;
    
    
}
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) UIButton* logoutbtn;
+ (AppCommon *)common;
-(BOOL) isInternetReachable;
-(void)webServiceFailureError:(NSError *)error;
-(void)reachabilityNotReachableAlert;
- (CGSize)getControlHeight:(NSString *)string withFontName:(NSString *)fontName ofSize:(NSInteger)size withSize:(CGSize)LabelWidth;

+(NSString *)GetUsercode;
+(NSString *)GetUserName;
+(NSString *) GetClientCode;
+(NSString *) GetuserReference;
+(NSString *)GetUserRoleName;
+(NSString *)GetUserRoleCode;
+(NSString *)GetPassword;


+(NSString *)getFileType:(NSString *)filePath;
+(void)showAlertWithMessage:(NSString *)message;
+(void)showLoading;
+(void)hideLoading;

+(UIColor*)colorWithHexString:(NSString*)hex;

-(void)actionLogOut;
+ (NSString *)syncId;

-(void)getIPLCompetetion;
-(void)getIPLteams;


+(NSString *)getCurrentCompetitionCode;
+(NSString *)getCurrentCompetitionName;
+(NSString *)getCurrentTeamCode;
+(NSString *)getCurrentTeamName;
+(BOOL)isCoach;
+(void)getTeamAndPlayerCode;
+(NSString *)checkNull:(NSString *)_value;
-(NSArray *)getCorrespondingTeamName:(NSString *)competetionName;
+(BOOL)isKXIP;

+(NSString *)getAppVersion;
+(void)newVersionUpdateAlert;
-(void)drawLogoutButton;
-(void)logoutAction:(UIEvent *)event;
-(void)drag:(UIControl*)control andEvent:(UIEvent *)event;
@end

extern AppCommon *sharedCommon;
#define COMMON (sharedCommon? sharedCommon:[AppCommon common])
