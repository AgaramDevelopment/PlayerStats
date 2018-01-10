//
//  sampleTableViewCell.h
//  sampleTable
//
//  Created by user on 05/01/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface PlayerListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet CustomButton *btnPlayer;
@property (weak, nonatomic) IBOutlet CustomButton *btnOrigin;
@property (weak, nonatomic) IBOutlet CustomButton *btnStyle;
@property (weak, nonatomic) IBOutlet CustomButton *btnOrder;
@property (weak, nonatomic) IBOutlet CustomButton *btnMat;
@property (weak, nonatomic) IBOutlet CustomButton *btnInns;
@property (weak, nonatomic) IBOutlet CustomButton *btnNo;
@property (weak, nonatomic) IBOutlet CustomButton *btnRuns;
@property (weak, nonatomic) IBOutlet CustomButton *btnBF;
@property (weak, nonatomic) IBOutlet CustomButton *btnHS;
@property (weak, nonatomic) IBOutlet CustomButton *btnAve;
@property (weak, nonatomic) IBOutlet CustomButton *btnSR;
@property (weak, nonatomic) IBOutlet CustomButton *btnDB;
@property (weak, nonatomic) IBOutlet CustomButton *btnBdry;
@property (weak, nonatomic) IBOutlet CustomButton *btn100;
@property (weak, nonatomic) IBOutlet CustomButton *btn50;
@property (weak, nonatomic) IBOutlet CustomButton *btn0;
@property (weak, nonatomic) IBOutlet CustomButton *btn4s;
@property (weak, nonatomic) IBOutlet CustomButton *btn6s;
@property (weak, nonatomic) IBOutlet CustomButton *btn30s;
@property (weak, nonatomic) IBOutlet CustomButton *btnBowlRuns;
@property (weak, nonatomic) IBOutlet CustomButton *btnBowlBalls;
@property (weak, nonatomic) IBOutlet CustomButton *btnBowlAve;
@property (weak, nonatomic) IBOutlet CustomButton *btnBowlSR;
@property (weak, nonatomic) IBOutlet CustomButton *btnWkts;
@property (weak, nonatomic) IBOutlet CustomButton *btn3wAbove;
@property (weak, nonatomic) IBOutlet CustomButton *btnEcon;
@property (weak, nonatomic) IBOutlet CustomButton *btnCatch;
@property (weak, nonatomic) IBOutlet CustomButton *btnStump;


@property (weak, nonatomic) IBOutlet UILabel *lblPlayerName;
@property (weak, nonatomic) IBOutlet UILabel *lblOrigin;
@property (weak, nonatomic) IBOutlet UILabel *lblStyle;
@property (weak, nonatomic) IBOutlet UILabel *lblOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblMat;
@property (weak, nonatomic) IBOutlet UILabel *lblInns;
@property (weak, nonatomic) IBOutlet UILabel *lblNo;
@property (weak, nonatomic) IBOutlet UILabel *lblRuns;
@property (weak, nonatomic) IBOutlet UILabel *lblBF;
@property (weak, nonatomic) IBOutlet UILabel *lblHS;
@property (weak, nonatomic) IBOutlet UILabel *lblAve;
@property (weak, nonatomic) IBOutlet UILabel *lblSR;
@property (weak, nonatomic) IBOutlet UILabel *lblDB;
@property (weak, nonatomic) IBOutlet UILabel *lblBdry;
@property (weak, nonatomic) IBOutlet UILabel *lbl100;
@property (weak, nonatomic) IBOutlet UILabel *lbl50;
@property (weak, nonatomic) IBOutlet UILabel *lbl0;
@property (weak, nonatomic) IBOutlet UILabel *lbl4s;
@property (weak, nonatomic) IBOutlet UILabel *lbl6s;
@property (weak, nonatomic) IBOutlet UILabel *lbl30s;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlRuns;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlBalls;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlAve;
@property (weak, nonatomic) IBOutlet UILabel *lblBowlSR;
@property (weak, nonatomic) IBOutlet UILabel *lblWkts;
@property (weak, nonatomic) IBOutlet UILabel *lbl3wAbove;
@property (weak, nonatomic) IBOutlet UILabel *lblEcon;
@property (weak, nonatomic) IBOutlet UILabel *lblCatch;
@property (weak, nonatomic) IBOutlet UILabel *lblStump;

@property (strong, nonatomic) IBOutletCollection(CustomButton) NSArray *btnHeader;

@end

