//
//  MCTeamChargeViewController.h
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseDataViewController.h"
static NSMutableArray *_gTCTopArray;
@interface MCTeamChargeViewController : MCBaseDataViewController
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,assign) BOOL firstSubViewController;
@property (nonatomic,strong) NSString *userID;

@property (nonatomic,assign) int GetUserType;
@end
