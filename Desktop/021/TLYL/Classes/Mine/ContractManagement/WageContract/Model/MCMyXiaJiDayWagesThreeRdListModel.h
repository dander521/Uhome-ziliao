//
//  MCMyXiaJiDayWagesThreeRdListModel.h
//  TLYL
//
//  Created by MC on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMyXiaJiDayWagesThreeRdListModel : NSObject

//查看下级的日工资列表 （日工资3）
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end


@interface MCMyXiaJiDayWagesThreeRdListDataModel : NSObject

@property(nonatomic,strong) NSString * DataCount;
@property(nonatomic,strong) NSString * PageCount;
@property(nonatomic,strong) NSString * State;
@property(nonatomic,strong) NSArray * DayWagesThreeListModels;


@end

@interface MCMyXiaJiDayWagesThreeListModelsDataModel : NSObject

@property(nonatomic,strong) NSString * DayWageStandard;
@property(nonatomic,strong) NSString * UserName;
@property(nonatomic,strong) NSString * UserID;
@property(nonatomic,strong) NSString * Rebate;
@property(nonatomic,strong) NSString * State;

@property(nonatomic,strong) NSString * Category;
@property(nonatomic,strong) NSString * CreateTime;
@property(nonatomic,strong) NSString * DayWagesProportion;
@property(nonatomic,strong) NSString * ID ;
@property(nonatomic,strong) NSString * Level;
@property(nonatomic,strong) NSString * ParentID;
@property(nonatomic,strong) NSString * RootID;
@property(nonatomic,strong) NSString * RuleID;
@property(nonatomic,strong) NSString * Sign;
@property(nonatomic,strong) NSString * SuperiorUserID;

@end







































