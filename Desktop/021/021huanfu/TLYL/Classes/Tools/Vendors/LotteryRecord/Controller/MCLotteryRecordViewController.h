//
//  MCLotteryRecordViewController.h
//  TLYL
//
//  Created by MC on 2017/7/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCLotteryRecordView.h"
#import "MCMineHeader.h"

@interface MCLotteryRecordViewController : UIViewController
//singleton_h(MCLotteryRecordViewController)
@property(nonatomic,strong) MCLotteryRecordView * view_Record;

@property (nonatomic,assign) NSString * LotteryCode;


@end
