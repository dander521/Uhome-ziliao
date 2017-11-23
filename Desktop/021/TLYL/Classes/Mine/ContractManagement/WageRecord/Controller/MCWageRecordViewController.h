//
//  MCWageRecordViewController.h
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCWageRecordViewController : UIViewController

@property (nonatomic,strong)NSString * IsSelf;//（0：自身日工资，1：直属下级日工资）
@property (nonatomic,strong)NSString * UserID;//搜索用户名时不传，其他情况传    String    当前登录用户ID
@property (nonatomic,strong)NSString * User_Name;//搜索用户名时传，不搜则不传    String    搜索用户名称
@property (nonatomic,strong)NSString * BeginTime;//是    String    开始时间 （格式：年月日 时分秒，如 2017/10/13 00:00:00）
@property (nonatomic,strong)NSString * EndTime;//是    String    结束时间 （格式：年月日 时分秒，如 2017/10/13 23:59:59）
@property (nonatomic,strong)NSString * CurrentPageIndex;//是    Int    当前页下标（第一页为1，后续页码依次加1）
@property (nonatomic,strong)NSString * CurrentPageSize;//是    Int    当前页条目数

@end
