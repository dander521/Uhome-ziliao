//
//  MCRechargeHeaderView.m
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeHeaderView.h"
#import "MCUserMoneyModel.h"
#import "UIView+MCParentController.h"
@interface MCRechargeHeaderView ()

/*
 * 账户余额
 */
@property (nonatomic,strong)UILabel * yuElab;

@property (nonatomic,strong)MCUserMoneyModel * userMoneyModel;

@end

@implementation MCRechargeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=RGB(249, 249, 249);
   
    UIImageView * logoimgV=[[UIImageView alloc]init];
    [self addSubview:logoimgV];
    logoimgV.frame=CGRectMake(10, 12, 16, 16);
    logoimgV.image=[UIImage imageNamed:@"PaySelected_touzhu-yue-icon"];
    
    UILabel * lab=[[UILabel alloc]init];
    [self setLab:lab withColor:RGB(0, 0, 0) andFont:15 andText:@"余额" andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(logoimgV.mas_right).offset(5);
    }];
    
    UILabel * yuElab=[[UILabel alloc]init];
    [self setLab:yuElab withColor:RGB(250, 85, 88) andFont:15 andText:@"加载中..." andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:yuElab];
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    yuElab.text = GetRealSNum(userMoneyModel.LotteryMoney);
    _yuElab=yuElab;
    [yuElab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(lab.mas_right).offset(10);
    }];
    
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor=RGB(231,231,231);
    [self addSubview:line];
    
    
    
    UIImageView * yuEimgV=[[UIImageView alloc]init];
    [self addSubview:yuEimgV];
    yuEimgV.frame=CGRectMake(G_SCREENWIDTH-95, 12, 16, 16);
    yuEimgV.image=[UIImage imageNamed:@"shuaxinyue"];
    
    UILabel * sxyuElab=[[UILabel alloc]init];
    [self setLab:sxyuElab withColor:RGB(0, 0, 0) andFont:15 andText:@"刷新余额" andTextAlignment:NSTextAlignmentRight];
    [self addSubview:sxyuElab];
    sxyuElab.frame=CGRectMake(G_SCREENWIDTH-100, 0, 90, 40);
    sxyuElab.userInteractionEnabled=YES;

    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(shuaXinYuE)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [sxyuElab addGestureRecognizer:singleRecognizer];

    
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(yuEimgV.mas_left).offset(-10);
        make.width.mas_offset(0.5);
    }];
}


-(void)shuaXinYuE{
    __weak __typeof__ (self) wself = self;
    //刷新余额
    [BKIndicationView showInView:[UIView MCcurrentViewController].view];
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [userMoneyModel refreashDataAndShow];
    self.userMoneyModel=userMoneyModel;
    userMoneyModel.callBackSuccessBlock = ^(id manager) {
        [BKIndicationView dismiss];
        wself.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
        wself.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
        wself.yuElab.text = [MCMathUnits GetMoneyShowNum:manager[@"LotteryMoney"]];

    };
    
    userMoneyModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [BKIndicationView dismiss];
    };
    
}


-(void)setLab:(UILabel *)lab withColor:(UIColor *)color andFont:(CGFloat)font andText:(NSString *)text andTextAlignment:(NSTextAlignment)textAlignment{
    lab.text=text;
    lab.textColor=color;
    lab.font=[UIFont systemFontOfSize:font];
    lab.textAlignment=textAlignment;
}



+(CGFloat)computeHeight:(id)info{
    return 40;
}

-(void)setDataSource:(id)dataSource{
    
    _dataSource=dataSource;
    _yuElab.text = [MCMathUnits GetMoneyShowNum:dataSource];

    

}

//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    label.attributedText = str;
}


@end




























