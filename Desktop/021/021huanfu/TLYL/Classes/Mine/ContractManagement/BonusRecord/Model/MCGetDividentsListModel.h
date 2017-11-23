//
//  MCGetDividentsListModel.h
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMineHeader.h"

//获取分红记录列表
@interface MCGetDividentsListModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

//IsSelf    是    Int    查询类型（0：自身分红，1：直属下级分红）
//UserID    搜索用户名时不传，其他情况传    String    当前登录用户ID
//UserName    搜索用户名时传，不搜则不传    String    搜索用户名称
//BeginTime    是    String    开始时间 （格式：年月日 时分秒，如 2017/10/12 00:00:00）
//EndTime    是    String    结束时间 （格式：年月日 时分秒，如 2017/10/12 23:59:59）
//CurrentPageIndex    是    Int    当前页下标（第一页为1，后续页码依次加1）
//CurrentPageSize    是    Int    当前页条目数
@interface MCGetDividentsListDataModel :NSObject

@property (nonatomic,strong)NSString *PageCount;//总页数
@property (nonatomic,strong)NSString *DataCount;//总条数
@property (nonatomic,strong)NSString *TotalDividentMoney;//分红总金额
@property (nonatomic,strong)NSArray * DividentsDetailAllList;//数据列表

@end


@interface MCGetDividentsListDeatailDataModel :NSObject

@property (nonatomic,strong)NSString *UserName;//用户名
@property (nonatomic,strong)NSString *TotalBatMoney;// 投注总额
@property (nonatomic,strong)NSString *TotalProfitLossMoney;// 盈利总额
@property (nonatomic,strong)NSString *ActivePersonNum;//活跃人数
@property (nonatomic,strong)NSString *DividendRatio;//分红比例（前端显示需要乘以100）
@property (nonatomic,strong)NSString *DividentMoney;//分红金额
@property (nonatomic,strong)NSString *CreateTime;// 时间


@end



@interface MCBonusRecordProperty : NSObject

singleton_h(MCBonusRecordProperty)


@property(nonatomic, strong) NSString * IsSelf;//查询类型（0：自身分红，1：直属下级分红）
@property(nonatomic, strong) NSString * UserID;//搜索用户名时不传，其他情况传    String    当前登录用户ID
@property(nonatomic, strong) NSString * UserName;//搜索用户名时传，不搜则不传    String    搜索用户名称
@property(nonatomic, strong) NSString * BeginTime;
@property(nonatomic, strong) NSString * EndTime;
@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize;


@end









