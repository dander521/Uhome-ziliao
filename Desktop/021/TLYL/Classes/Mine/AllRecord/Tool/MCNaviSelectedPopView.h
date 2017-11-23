//
//  MCNaviSelectedPopView.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MCNaviSelectedPopType){
    MCNaviSelectedPopType_ZhuiHao=0,           //追号记录
    MCNaviSelectedPopType_ZhangBian,            //帐变记录
    MCNaviSelectedPopType_PersonReport,          //个人报表
    MCNaviSelectedPopType_QiPaiXiaJiReport,       //棋牌报表_下级统计
    MCNaviSelectedPopType_BonusRecord,            //分红记录
    MCNaviSelectedPopType_dayWageRecord,          //日工资记录
    MCNaviSelectedPopType_dayWageContract,         //日工资契约首页
    MCNaviSelectedPopType_BonusContract           //分红首页
};

typedef  void (^MCNaviSelectedPopViewBlock)(NSInteger type);
@interface MCNaviSelectedPopView : UIView

@property (nonatomic,strong)UITextField * tf1;
@property (nonatomic,strong)UILabel *xiajiType;
@property (nonatomic,strong)UILabel *label1;
@property (nonatomic,strong)UILabel *label2;
@property (nonatomic,strong)UILabel *label3;
@property (nonatomic,strong)UILabel *label4;

@property (nonatomic,copy)MCNaviSelectedPopViewBlock block;
-(instancetype)InitWithType:(MCNaviSelectedPopType)Type;
- (void)showPopView;
- (void)dismiss;

@end






















