//
//  CustomNavigation.m
//  AlphaProTracker
//
//  Created by Mac on 22/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "CustomNavigation.h"
#import "Config.h"
#import "SuperSelector-Swift.h"

@interface CustomNavigation ()

@end

@implementation CustomNavigation


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.view.frame)-10)];
    self.objSearchBar.layer.borderWidth = 1;
  //  self.objSearchBar.layer.borderColor = [[UIColor blackColor] CGColor];
    self.objSearchBar.layer.borderColor =  [ [UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f] CGColor];
    //self.objSearchBar.backgroundImage = [UIImage new];
    //self.common_view.backgroundColor =DEFAULT_COLOR_BLUE;
    //self.btn_back.hidden =YES;
   // self.filter_btn.hidden =YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
