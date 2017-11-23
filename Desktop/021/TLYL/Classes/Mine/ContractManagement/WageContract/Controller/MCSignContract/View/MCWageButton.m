//
//  MCWageButton.m
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWageButton.h"
#import "MCContractMgtTool.h"

#define MCWageButtonNormalColor RGB(46,46,46)
#define MCWageButtonSelectColor RGB(249,84,83)

@interface MCWageButton ()

@property (nonatomic,strong)UILabel * lab1;
@property (nonatomic,strong)UILabel * lab2;
@property (nonatomic,strong)UILabel * lab3;

@end


@implementation MCWageButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor=RGB(246,243,248);
    self.layer.cornerRadius=5;
    self.clipsToBounds=YES;
    //    日工资标准：0.5%         销量：0            活跃人数：0
    UILabel * lab1 = [[UILabel alloc]init];
    [self addSubview:lab1];
    lab1.text=@"加载中...";
    lab1.textColor=MCWageButtonNormalColor;
    lab1.font=[UIFont systemFontOfSize:12];
    lab1.textAlignment = NSTextAlignmentLeft;
    _lab1=lab1;
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(12);
        make.width.mas_equalTo(G_SCREENWIDTH/3.0);
    }];
    
    UILabel * lab2 = [[UILabel alloc]init];
    [self addSubview:lab2];
    lab2.text=@"加载中...";
    lab2.textColor=MCWageButtonNormalColor;
    lab2.font=[UIFont systemFontOfSize:12];
    _lab2=lab2;
    lab2.textAlignment = NSTextAlignmentCenter;
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.centerX.equalTo(self.mas_centerX).offset(20);
        make.width.mas_equalTo(100);
    }];
    
    UILabel * lab3 = [[UILabel alloc]init];
    [self addSubview:lab3];
    lab3.text=@"加载中...";
    lab3.textColor=MCWageButtonNormalColor;
    lab3.font=[UIFont systemFontOfSize:12];
    lab3.textAlignment = NSTextAlignmentCenter;
    _lab3=lab3;
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-12);
        make.width.mas_equalTo(50);
    }];
}

-(void)setDataSource:(MCMyDayWagesThreeRdDayRuleDataModel *)dataSource{
    _dataSource = dataSource;
    _lab1.text=[NSString stringWithFormat:@"每天%@的日工资",[MCContractMgtTool getPercentNumber:dataSource.DayWagesProportion]];
    _lab2.text=[NSString stringWithFormat:@"%@",dataSource.DaySales];
    _lab3.text=[NSString stringWithFormat:@"%@",dataSource.ActiveNumber];
    
}

-(void)setIsSelected:(BOOL)isSelected{
    if (isSelected) {
        _lab1.textColor=MCWageButtonSelectColor;
        _lab2.textColor=MCWageButtonSelectColor;
        _lab3.textColor=MCWageButtonSelectColor;
    }else{
        _lab1.textColor=MCWageButtonNormalColor;
        _lab2.textColor=MCWageButtonNormalColor;
        _lab3.textColor=MCWageButtonNormalColor;
    }
}

@end
