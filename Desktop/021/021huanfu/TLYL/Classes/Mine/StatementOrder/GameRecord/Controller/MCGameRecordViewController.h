//
//  MCGameRecordViewController.h
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGameRecordModel.h"

@interface MCGameRecordViewController : UIViewController
@property (nonatomic,strong) MCGameRecordModel *dataSource;
@property (nonatomic,strong) NSString *subUserName;
@property (nonatomic,strong) NSString *subUserID;
@property (nonatomic,assign) BOOL mmViewContoller;
@end
