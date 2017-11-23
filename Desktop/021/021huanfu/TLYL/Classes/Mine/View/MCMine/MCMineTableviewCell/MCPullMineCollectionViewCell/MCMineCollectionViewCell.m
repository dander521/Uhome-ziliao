//
//  MCMineCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineCollectionViewCell.h"

@interface MCMineCollectionViewCell()
@property (nonatomic,strong)UIImageView *imgV_logo;

@end

@implementation MCMineCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}
    
-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    _titleLab.text =dataSource;
    NSDictionary * dic_logo=@{@"个人资料":@"personal-account-data",@"银行卡管理":@"personal-account-bank",@"安全中心":@"personal-account-security",@"充值记录":@"personal-finance-drawing",@"提款记录":@"personal-finance-recharge",@"投注记录":@"personal-order-game",@"追号记录":@"personal-order-number",@"帐变记录":@"personal-order-change",@"个人报表":@"personal-order-my",@"开户中心":@"personal-team-open",@"会员管理":@"personal-team-member",@"契约管理":@"personal-team-contract",@"团队报表":@"personal-team-team"};
    _imgV_logo.image=[UIImage imageNamed:dic_logo[dataSource]];

}

-(void)initView{
    self.backgroundColor = [UIColor  clearColor];

    _imgV_logo=[[UIImageView alloc]init];
    _imgV_logo.backgroundColor=[UIColor clearColor];
    _imgV_logo.layer.cornerRadius=35/2.0;
    _imgV_logo.clipsToBounds=YES;
    [self addSubview:_imgV_logo];
    [_imgV_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
    }];
    
    _titleLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _titleLab.alpha=0.8;
    _titleLab.textColor=RGB(68, 68, 68);
    _titleLab.font=[UIFont systemFontOfSize:12];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgV_logo.mas_bottom).offset(5);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    
}



@end
