//
//  LoginVC.h
//  AlphaProTracker
//
//  Created by Lexicon on 22/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCommon.h"
#import "Config.h"
#import "WebService.h"

@interface LoginVC : UIViewController
@property (nonatomic,strong)IBOutlet UISwitch *swt;

@property (nonatomic,strong)IBOutlet UIImageView *securityImage;
@property (weak, nonatomic) IBOutlet UIView *teamview;
@property (weak, nonatomic) IBOutlet UILabel *lblVersion;
@end
