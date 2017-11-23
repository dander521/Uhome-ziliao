//
//  MCWithdrawDetailViewController.h
//  TLYL
//
//  Created by MC on 2017/9/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTopUpRecordModel.h"

@interface MCWithdrawDetailViewController : UIViewController

@property (nonatomic,strong) MCTopUpRecordModel *dataSorce;
@property (nonatomic,strong) NSArray *arrData;


@end
