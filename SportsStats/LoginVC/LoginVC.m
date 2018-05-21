//
//  LoginVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 22/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "LoginVC.h"
#import "PlayerSelectorVC.h"
@interface LoginVC ()
{
    NSMutableArray *teamArray;
    BOOL isTeam;
}

@property (weak,nonatomic)  IBOutlet UIView *commonview;
@property (strong, nonatomic) IBOutlet UIView *teamView;
@property (strong, nonatomic) IBOutlet UITextField *teamTF;

@property (weak,nonatomic)  IBOutlet UIView *usernameview;
@property (weak,nonatomic)  IBOutlet UIView *passwordview;

@property (weak,nonatomic)  IBOutlet UITextField *userTxt;
@property (weak,nonatomic) IBOutlet UITextField * passwordTxt;
@property (strong, nonatomic) IBOutlet UITableView *teamTableView;


@property (nonatomic,strong) IBOutlet NSLayoutConstraint * commonViewHeight;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * commonViewWidth;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * usernameyposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * paswordyposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * signBtnyposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * liftsidewidth;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * rightsidewidth;

@property (nonatomic, assign) BOOL isVisible;

@end



@implementation LoginVC

@synthesize teamview,lblVersion;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.teamTableView.hidden = YES;
    _isVisible = false;
    self.securityImage.image = [UIImage imageNamed:@"eye_hide_icon"];
    self.passwordTxt.secureTextEntry= !_isVisible;
    
//    [self teamCodeGetService];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [[COMMON logoutbtn] setHidden:YES];
    lblVersion.text = [NSString stringWithFormat:@"Version %@",[AppCommon getAppVersion]];

    
    _teamTF.text = @"";
    _userTxt.text = @"";
    _passwordTxt.text = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)didClickSubmitBtnAction:(id)sender
{

    [self validation];
}

-(void)validation
{
    if([self.userTxt.text isEqualToString:@""] || self.userTxt.text==nil)
    {
        [AppCommon showAlertWithMessage:@"Please Enter UserName"];
    }
    else if ([self.passwordTxt.text isEqualToString:@""] || self.passwordTxt.text==nil)
    {
        [AppCommon showAlertWithMessage:@"Please Enter Password"];
    }
    else
    {
        [self LoginWebservice:self.userTxt.text:self.passwordTxt.text];
    }
}

-(void)LoginWebservice :(NSString *) username :(NSString *) password
{
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    NSString *URLString =  URL_FOR_RESOURCE(LoginKey);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
/*
 currently teamcode should be fixed until changes done in webservice side.
 */
    [dic    setObject:@"TEA0000087" forKey:@"teamcode"];
    if(username)   [dic    setObject:username     forKey:@"username"];
    if(password)   [dic    setObject:password     forKey:@"password"];
        [dic    setObject:[AppCommon getAppVersion]     forKey:@"version"];
        [dic    setObject:@"ios"     forKey:@"platform"];

    NSLog(@"API URL : %@",URLString);

    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        if([[responseObject valueForKey:@"Status"] isEqualToString:@"PSUCCESS"] && [responseObject valueForKey:@"Status"] != NULL)
        {

            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            PlayerSelectorVC* VC = (PlayerSelectorVC *)[appDel.storyBoard instantiateViewControllerWithIdentifier:@"PlayerSelectorVC"];
            [self.navigationController pushViewController:VC animated:YES];

            
        }
        else{
            
            [AppCommon showAlertWithMessage:@"Invalid Login"];
        }
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
}


- (void)teamCodeGetService {
    /*
     API URL    :   http://192.168.0.151:8044/AGAPTService.svc/FETCH_LOGIN_TEAMS/
     METHOD     :   GET
     PARAMETER  :   nil
     */
    
    if(![COMMON isInternetReachable]) // APT Teamcode
        return;
    
    [AppCommon showLoading];
    
    NSString *API_URL = URL_FOR_RESOURCE(@"FETCH_LOGIN_TEAMS");

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    
    [manager GET:API_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS RESPONSE:%@",responseObject);
        teamArray = [[NSMutableArray alloc] init];
        teamArray = responseObject;
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAILURE RESPONSE %@",error.description);
        [AppCommon hideLoading];
        [COMMON webServiceFailureError:error];
    }];
}


- (IBAction)switchAction:(id)sender {
    
    _isVisible = !_isVisible;
    
    self.securityImage.image = [UIImage imageNamed:(!_isVisible ? @"eye_hide_icon" : @"eye_show_icon") ];
    self.passwordTxt.secureTextEntry= !_isVisible;
}

- (IBAction)teamButtonTapped:(id)sender {
    
  
    if (!teamArray.count) {
        [self teamCodeGetService];
        return;
    }
    
//    DropDownTableViewController* dropVC = [[DropDownTableViewController alloc] init];
//    dropVC.protocol = self;
//    dropVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    dropVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [dropVC.view setBackgroundColor:[UIColor clearColor]];
//
//        dropVC.array = teamArray;
//        dropVC.key = @"Teamname";
//
//    CGFloat xValue = CGRectGetMinX(teamview.superview.frame) + CGRectGetMinX(teamview.frame);
//    CGFloat yValue = CGRectGetMinY(teamview.superview.frame) + CGRectGetMaxY(teamview.frame)+5;
//
//    [dropVC.tblDropDown setFrame:CGRectMake(xValue, yValue, CGRectGetWidth(teamview.frame), (IS_IPAD ? 200 : 150))];
//
//    [appDel.frontNavigationController presentViewController:dropVC animated:YES completion:^{
//        NSLog(@"DropDown loaded");
//    }];

}

//-(void)selectedValue:(NSMutableArray *)array andKey:(NSString*)key andIndex:(NSIndexPath *)Index
//{
//
//        _teamTF.text = [[array objectAtIndex:Index.row] valueForKey:key];
//        [[NSUserDefaults standardUserDefaults] setValue:_teamTF.text forKey:@"loginedUserTeam"];
//        NSString* Teamcode = [[array objectAtIndex:Index.row] valueForKey:@"Teamcode"];
//
//        [[NSUserDefaults standardUserDefaults] setValue:_teamTF.text forKey:@"SelectedTeamName"];
//        [[NSUserDefaults standardUserDefaults] setValue:Teamcode forKey:@"SelectedTeamCode"];
//        [[NSUserDefaults standardUserDefaults] setValue:Teamcode forKey:@"loginedTeamCode"];
//        [[NSUserDefaults standardUserDefaults] setValue:_teamTF.text forKey:@"loginedTeamName"];
//
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view resignFirstResponder];
    [_passwordTxt resignFirstResponder];
    [_userTxt resignFirstResponder];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.returnKeyType == UIReturnKeyNext && _userTxt.isFirstResponder)
    {
        [_userTxt resignFirstResponder];
        [_passwordTxt becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}
@end

