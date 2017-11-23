//
//  MCChaseNumberViewController.h
//  TLYL
//
//  Created by miaocai on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseLotteryHallViewController.h"
#import "MCPaySelectedLotteryModel.h"

@interface MCChaseNumberViewController : UIViewController
/**dataSourceModel 数据源*/
@property (nonatomic,strong)  MCPaySLBaseModel *dataSourceModel;

@property (nonatomic,assign)int RemainTime;

@property (nonatomic,strong)NSString * IssueNumber;

@property (nonatomic,strong) NSArray *boModelArray;

@property (nonatomic,strong) MCBasePWFModel *baseWFmodel;

@property (nonatomic,strong) void (^yuEHadChangedBlock)(NSString *yue);


@end
