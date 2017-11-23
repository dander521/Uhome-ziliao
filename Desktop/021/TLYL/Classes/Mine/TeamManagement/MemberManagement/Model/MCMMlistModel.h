//
//  MCMMlistModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMMlistModel : NSObject

@property (nonatomic,strong)NSString *CurrentPageSize;
@property (nonatomic,strong)NSString *CurrentPageIndex;
@property (nonatomic,strong)NSString *EndDate;
@property (nonatomic,strong)NSString *BeginDate;
@property (nonatomic,strong)NSString *LikeUserName;
@property (nonatomic,strong)NSString *subUserID;
@property (nonatomic,assign)int TreeType;
@property (nonatomic,assign) BOOL isSubController;
@property (nonatomic,assign)int UserID;
@property (nonatomic,assign)int Category;
@property (nonatomic,strong)NSString *UserName;
@property (nonatomic,strong)NSNumber *LotteryMoney;
@property (nonatomic,assign)int Rebate;
@property (nonatomic,strong)NSString *CreateTime;
@property (nonatomic,assign)int ParentID;
@property (nonatomic,strong)NSString *ParentName;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;

@end
