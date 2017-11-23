//
//  MCXiaJiWageContractTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import "MCXiaJiWageContractTableViewCell.h"
#import "MCDataTool.h"
#import "MCContractMgtTool.h"
#import "MCMineInfoModel.h"

@interface MCXiaJiWageContractTableViewCell()

@property(nonatomic,strong) UIButton * DayWagesProportion;
@property(nonatomic,strong) UIButton * UserName;
@property(nonatomic,strong) UIButton * Rebate;
@property(nonatomic,strong) UIButton * State;

@end

@implementation MCXiaJiWageContractTableViewCell
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
    
    
    _DayWagesProportion =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_DayWagesProportion WithColor:RGB(46, 46, 46) andFont:12 andAlignment:UIControlContentHorizontalAlignmentLeft andTitle:@"比   例： 加载中..."];
    [_DayWagesProportion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.left.equalTo(self.mas_left).offset(18);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(15);
    }];
    
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
    [_State mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.left.equalTo(self.mas_left).offset((G_SCREENWIDTH-26)-100);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
   
    
    
}


-(void)layOutConstraints{
    
   
}

- (void)setDataSource:(MCMyXiaJiDayWagesThreeListModelsDataModel *)dataSource{
    _dataSource = dataSource;
    
    //    用户名：lulu                  返点：1960
    //    比   例:  1.2%日工资           状态：已签约
    [_DayWagesProportion setTitle:[NSString stringWithFormat:@"比   例：%@",[MCContractMgtTool getPercentNumber:dataSource.DayWagesProportion]] forState:UIControlStateNormal];

    [_UserName setTitle:[NSString stringWithFormat:@"用户名：%@",dataSource.UserName] forState:UIControlStateNormal];

    [_Rebate setTitle:[NSString stringWithFormat:@"返点：%@",[self GetShowBetRebate:dataSource.Rebate]] forState:UIControlStateNormal];

    NSString * State = StateDic[dataSource.State][0];
//    [_State setTitle:[NSString stringWithFormat:@"状态：%@",State] forState:UIControlStateNormal];
    
    
    NSString * str = [NSString stringWithFormat:@"状态：%@",State];
    NSRange range = [str rangeOfString:State];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:NSMakeRange(range.location, range.length)];
    [_State setAttributedTitle:attri forState:UIControlStateNormal];


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





































