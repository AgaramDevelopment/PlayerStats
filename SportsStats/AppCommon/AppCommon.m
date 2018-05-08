	//
//  AppCommon.m
//  AlphaProTracker
//
//  Created by Mac on 21/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AppCommon.h"
#import "Reachability.h"
#import "WebService.h"
#import "Config.h"
#import "AppDelegate.h"

@implementation AppCommon
AppCommon *sharedCommon = nil;

+ (AppCommon *)common {
    
//    NSString *reqName;
    
    if (!sharedCommon) {
        
        sharedCommon = [[self alloc] init];
    }
    return sharedCommon;
}

- (id)init {
    
    return self;
}

-(void)loadingIcon:(UIView *)view
{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width)/2, (view.frame.size.height)/2, 37, 37)];
//    loadingView = [[UIView alloc] initWithFrame:CGRectMake((appDel.window.frame.size.width)/2, (appDel.window.frame.size.height)/2, 37, 37)];

    [loadingView.layer setCornerRadius:5.0];
    
    [loadingView setBackgroundColor:[UIColor blackColor]];
    
    //Enable maskstobound so that corner radius would work.
    
    [loadingView.layer setMasksToBounds:YES];
    
    //Set the corner radius
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    [activityView setFrame:CGRectMake(0,0, 37, 37)];
    
    [activityView setHidesWhenStopped:YES];
    
    [activityView startAnimating];
    
    [loadingView addSubview:activityView];
    [view addSubview:loadingView];
    [view setUserInteractionEnabled:NO];
//    [appDel.window setUserInteractionEnabled:NO];
//    [appDel.window addSubview:loadingView];
    
}

-(void)RemoveLoadingIcon
{
//    [appDel.window setUserInteractionEnabled:YES];
    [loadingView removeFromSuperview];
    
}
#pragma mark Reachable

-(BOOL) isInternetReachable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        NSLog(@"Data Connected");
        return YES;
    }
    else {
        [self reachabilityNotReachableAlert];
        return NO;
    }
}

-(void)reachabilityNotReachableAlert{
    
    [self RemoveLoadingIcon];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:@"It appears that you have lost network connectivity. Please check your network settings!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//
//    [alert show];
    [AppCommon showAlertWithMessage:@"It appears that you have lost network connectivity. Please check your network settings!"];

}

-(void)webServiceFailureError
{
    [self RemoveLoadingIcon];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"] message:@"Server Error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//
//    [alert show];
    [AppCommon showAlertWithMessage:@"Server Error"];

}
#pragma mark - Get Height of Control

- (CGSize)getControlHeight:(NSString *)string withFontName:(NSString *)fontName ofSize:(NSInteger)size withSize:(CGSize)LabelWidth {
    CGSize maxSize = LabelWidth;
    CGSize dataHeight;
    
    UIFont *font = [UIFont fontWithName:fontName size:size];
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.paragraphSpacing = 50 * font.lineHeight;
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if ([version floatValue]>=7.0) {
        CGRect textRect = [string boundingRectWithSize:maxSize
                                               options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:font}
                                               context:nil];
        
        
        dataHeight = CGSizeMake(textRect.size.width , textRect.size.height+20);
        
    }
    
    return CGSizeMake(dataHeight.width, dataHeight.height);
}

+(void)showAlertWithMessage:(NSString *)message
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:APP_NAME message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

+(NSString *)checkNull:(NSString *)value
{
    NSString* result = @"";
    if (value == (id)[NSNull null] || value.length == 0 )
    {
        return  result;
    }
    return value;
}


@end
