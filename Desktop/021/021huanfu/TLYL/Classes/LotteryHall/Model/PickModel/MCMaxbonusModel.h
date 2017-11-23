//
//  MCMaxbonusModel.h
//  TLYL
//
//  Created by miaocai on 2017/7/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//  单挑单期 最高奖金

#import <Foundation/Foundation.h>

@interface MCMaxbonusModel : NSObject
//"Sign":2,  //单期
//"SingleStageCode":"1001",
//"MaxAmt":300000

//"Sign":1,  //单挑
//"PlayCode":"5802",
//"SoloAmt":20000,
//"SoloNote":1000
@property (nonatomic,strong) NSString *MaxAmt;
@property (nonatomic,strong) NSString *Sign;

@property (nonatomic,strong) NSString *SingleStageCode;

@property (nonatomic,strong) NSString *PlayCode;

@property (nonatomic,strong) NSString *SoloAmt;

@property (nonatomic,strong) NSString *SoloNote;

@property (nonatomic,strong) NSString *PlayGroupName;

@property (nonatomic,assign) Type_MCBet mmcType;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

@property (nonatomic,assign) int lotteryNumber;

- (void)refreashDataAndShow;

+ (instancetype)shareInstance;

@end
