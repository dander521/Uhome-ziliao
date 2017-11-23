//
//  MCMyBonusContractTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMyBonusContractTableViewCell.h"
#import "MCDataTool.h"
#import "MCContractMgtTool.h"


@interface MCMyBonusContractTableViewCell()
//用户名：lulu                                           返点：1960
//比   例:  1.2%日工资                                状态：已签约
@property(nonatomic,strong) UIButton * DayWagesProportion;
@property(nonatomic,strong) UIButton * UserName;
@property(nonatomic,strong) UIButton * Rebate;
@property(nonatomic,strong) UIButton * State;

@end

@implementation MCMyBonusContractTableViewCell
#pragma mark View creation & layout

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //        [self initViews:YES];
        [self createUI];
    }
    return self;
}

-(void)setBtn:(UIButton *)btn WithColor:(UIColor*)color andFont:(NSInteger)font andAlignment:(UIControlContentHorizontalAlignment)alignment andTitle:(NSString *)title{
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = alignment;
    [self  addSubview:btn];
}
-(void)createUI{
    
    self.backgroundColor=[UIColor whiteColor];
    
    //    用户名：lulu                  返点：1960
    //    比   例:  1.2%日工资           状态：已签约
    _UserName =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_UserName WithColor:RGB(46, 46, 46) andFont:12 andAlignment:UIControlContentHorizontalAlignmentLeft andTitle:@"用户名：加载中..."];
    [_UserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset(18);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(15);
    }];
    
    
//    _DayWagesProportion =[[UIButton alloc]initWithFrame:CGRectZero];
//    [self setBtn:_DayWagesProportion WithColor:RGB(46, 46, 46) andFont:12 andAlignment:UIControlContentHorizontalAlignmentLeft andTitle:@"比   例： 加载中..."];
//    [_DayWagesProportion mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottom).offset(-15);
//        make.left.equalTo(self.mas_left).offset(18);
//        make.width.mas_equalTo(250);
//        make.height.mas_equalTo(15);
//    }];
    
    _Rebate =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_Rebate WithColor:RGB(46, 46, 46) andFont:12 andAlignment:UIControlContentHorizontalAlignmentLeft andTitle:@"返点：加载中..."];
    [_Rebate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.left.equalTo(self.mas_left).offset((G_SCREENWIDTH-26)-100);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    
    _State =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_State WithColor:RGB(46, 46, 46) andFont:12 andAlignment:UIControlContentHorizontalAlignmentLeft andTitle:@"状态：加载中..."];
//    [_State mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottom).offset(-15);
//        make.left.equalTo(self.mas_left).offset((G_SCREENWIDTH-26)-100);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(15);
//    }];
    [_State mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.left.equalTo(self.mas_left).offset(18);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(15);
    }];
    
    
    
}


-(void)setDataSource:(MCMyXiaJiBonusContractListDeatailDataModel *)dataSource{
    _dataSource=dataSource;
        //    用户名：lulu                  返点：1960
        //    比   例:  1.2%日工资           状态：已签约

//    [_DayWagesProportion setTitle:[NSString stringWithFormat:@"比   例：%@",[MCContractMgtTool getPercentNumber:dataSource.DayWagesProportion]] forState:UIControlStateNormal];

    [_UserName setTitle:[NSString stringWithFormat:@"用户名：%@",dataSource.UserName] forState:UIControlStateNormal];
    
    [_Rebate setTitle:[NSString stringWithFormat:@"返点：%@",[self GetShowBetRebate:dataSource.Rebate]] forState:UIControlStateNormal];
    
     //0：当前用户有新契约；1：当前用户没有新契约
    if ([[NSString stringWithFormat:@"%@",dataSource.State]isEqualToString:@"-1"]) {
        NSString * State = @"未签约";
        NSString * str = [NSString stringWithFormat:@"状态：%@",State];
        NSRange range = [str rangeOfString:State];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSForegroundColorAttributeName value:RGB(228,66,65) range:NSMakeRange(range.location, range.length)];
        [_State setAttributedTitle:attri forState:UIControlStateNormal];
    }else if([[NSString stringWithFormat:@"%@",dataSource.State]isEqualToString:@"0"]){
       
        NSString * State = @"待确认";
        NSString * str = [NSString stringWithFormat:@"状态：%@",State];
        NSRange range = [str rangeOfString:State];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSForegroundColorAttributeName value:RGB(228,66,65) range:NSMakeRange(range.location, range.length)];
        [_State setAttributedTitle:attri forState:UIControlStateNormal];
        
    }else if([[NSString stringWithFormat:@"%@",dataSource.State]isEqualToString:@"1"]){
        
        NSString * State = @"已签约";
        NSString * str = [NSString stringWithFormat:@"状态：%@",State];
        NSRange range = [str rangeOfString:State];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:NSMakeRange(range.location, range.length)];
        [_State setAttributedTitle:attri forState:UIControlStateNormal];
        
    }else if([[NSString stringWithFormat:@"%@",dataSource.State]isEqualToString:@"2"]){
        
        
        NSString * State = @"已拒绝";
        NSString * str = [NSString stringWithFormat:@"状态：%@",State];
        NSRange range = [str rangeOfString:State];
        NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
        [attri addAttribute:NSForegroundColorAttributeName value:RGB(228,66,65) range:NSMakeRange(range.location, range.length)];
        [_State setAttributedTitle:attri forState:UIControlStateNormal];
        
    }
    
//    switch (state){
//        case -1:
//            return ['未签约','签订契约'];
//        case 0:
//            return ['待确认','修改契约'];
//        case 1:
//            return ['已签约','修改契约'];
//        case 2:
//            return ['已拒绝','修改契约'];
//    }
//    当 LockState == 1 && State >= 0，则显示“分红结算”按钮，否则不显示。

}


+(CGFloat)computeHeight:(id)info{
    return 70+10;
}

-(NSString * )GetShowBetRebate:(NSString *)Rebate{
    NSString * str = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
    float fRebate = ([Rebate floatValue] - [str floatValue]) / 20.0;
    return [NSString stringWithFormat:@"%@~%.1f",Rebate,fRebate];
}


@end






































