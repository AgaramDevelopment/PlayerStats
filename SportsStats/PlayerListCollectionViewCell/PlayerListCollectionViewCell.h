//
//  PlayerListCollectionViewCell.h
//  SportsStats
//
//  Created by user on 10/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomButton.h"

@interface PlayerListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet CustomButton *btnName;
@property (weak, nonatomic) IBOutlet UIImageView *imgCap;

@property (strong, nonatomic) IBOutlet UILabel *lblRightShadow;
@end
