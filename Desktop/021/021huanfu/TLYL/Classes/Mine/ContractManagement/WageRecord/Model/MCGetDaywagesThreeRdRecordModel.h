//
//  MCGetDaywagesThreeRdRecordModel.h
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"


//获取 日工资3 记录列表
@interface MCGetDaywagesThreeRdRecordModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;
//IsSelf    是    Int    查询类型（0：自身日工资，1：直属下级日工资）
//UserID    搜索用户名时不传，其他情况传    String    当前登录用户ID
//User_Name    搜索用户名时传，不搜则不传    String    搜索用户名称
//BeginTime    是    String    开始时间 （格式：年月日 时分秒，如 2017/10/13 00:00:00）
//EndTime    是    String    结束时间 （格式：年月日 时分秒，如 2017/10/13 23:59:59）
//CurrentPageIndex    是    Int    当前页下标（第一页为1，后续页码依次加1）
//CurrentPageSize    是    Int    当前页条目数
@end

@interface MCGetDaywagesThreeRdRecordDataModel : NSObject

@property(nonatomic,strong)NSString * PageCount;
@property(nonatomic,strong)NSString * DataCount;
@property(nonatomic,strong)NSString * DayWagesAmount;//日工资金额
@property(nonatomic,strong)NSArray * GetWayWagesList;
                    
@end


@interface MCGetDaywagesThreeRdRecordDetailDataModel : NSObject

@property(nonatomic,strong)NSString * User_ID;//用户ID
@property(nonatomic,strong)NSString * User_Name;//用户名
@property(nonatomic,strong)NSString * DetailSource;//发放类型 备注1
@property(nonatomic,strong)NSString * ActivePersonNum;//活跃人数
@property(nonatomic,strong)NSString * SalesVolume;//销量
@property(nonatomic,strong)NSString * DayWagesRatio;//日工资标准（界面乘以100，按%显示）
@property(nonatomic,strong)NSString * DayWagesAmount;//日工资合计金额
@property(nonatomic,strong)NSString * CreateTime;//流水时间
@property(nonatomic,strong)NSString * Remark;//备注

@property(nonatomic,strong)NSString * Sum_DayWagesAmount;//投注总额

+(NSString *)GetFaFangType:(NSString *)DetailSource;

@end


//发放类型（DetailSource）说明：
//-1:全部，
//301:系统发放，
//263:来自上级的日工资，
//264:发给下级的日工资，
//265:人工添加日工资，
//266:人工扣除日工资.


                    
@interface MCDayagesRecordProperty : NSObject

singleton_h(MCDayagesRecordProperty)

@property(nonatomic, strong) NSString * IsSelf;// 查询类型（0：自身日工资，1：直属下级日工资）
@property(nonatomic, strong) NSString * UserID;// 搜索用户名时不传，其他情况传    String    当前登录用户ID
@property(nonatomic, strong) NSString * User_Name ;//搜索用户名时传，不搜则不传    String    搜索用户名称
@property(nonatomic, strong) NSString * BeginTime ;
@property(nonatomic, strong) NSString * EndTime ;
@property(nonatomic, strong) NSString * CurrentPageIndex ;
@property(nonatomic, strong) NSString * CurrentPageSize ;


@end
                    
                    
                    
                    
                    
                    
                    
                    
