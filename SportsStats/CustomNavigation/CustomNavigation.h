//
//  CustomNavigation.h
//  AlphaProTracker
//
//  Created by Mac on 22/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomNavigation : UIViewController


@property (nonatomic,strong) IBOutlet UILabel * tittle_lbl;
@property (nonatomic,strong) IBOutlet UIButton * btn_back;
@property (nonatomic,strong) IBOutlet UIImageView * nav_header_img;
@property (nonatomic,strong) IBOutlet UIButton * filter_btn;
@property (nonatomic,strong) IBOutlet UIButton * Cancelbtn;


@property (nonatomic,strong) IBOutlet UIButton * summarybtn;
@property (nonatomic,strong) IBOutlet UIView * nav_search_view;
@property (nonatomic,strong) IBOutlet UISearchBar * objSearchBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchWidth;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img1Leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *img2Trailing;
@property (weak, nonatomic) IBOutlet UIButton *btnCompName;
@property (weak, nonatomic) IBOutlet UIButton *btnSquad;




@end
