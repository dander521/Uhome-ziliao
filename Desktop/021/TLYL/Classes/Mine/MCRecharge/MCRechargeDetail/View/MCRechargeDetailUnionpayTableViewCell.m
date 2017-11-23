//
//  MCRechargeDetailUnionpayTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/8/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeDetailUnionpayTableViewCell.h"


@interface MCRechargeDetailUnionpayTableViewCell ()
@property (nonatomic,strong)UIView * backView;
//充值方式
@property (nonatomic,strong)UILabel * typeLab;
//金额
@property (nonatomic,strong)UILabel * moneyLab;


@property (nonatomic,strong)UIButton * payBtn;
@end

@implementation MCRechargeDetailUnionpayTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    _backView=[[UIView alloc]init];
    [self addSubview:_backView];
    _backView.backgroundColor=[UIColor whiteColor];
    _backView.clipsToBounds=YES;
    _backView.layer.cornerRadius=5;
    _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 60);
    
    UILabel * typeLab =[[UILabel alloc]init];
    [self setLab:typeLab andIndex:0 andText:@"充值方式："];
    _typeLab=typeLab;
    
    UILabel * moneyLab=[[UILabel alloc]init];
    [self setLab:moneyLab andIndex:1 andText:@"充值金额："];
    _moneyLab=moneyLab;
    
    //付款
    _payBtn=[[UIButton alloc]init];
    [self setFooter:_payBtn];
    
}

-(void)setFooter:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"付款" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//    [btn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"Button_Determin_Right"] forState:UIControlStateNormal];
    btn.backgroundColor=RGB(144,8,215);
    [self addSubview:btn];
    [btn addTarget:self action:@selector(payToWeb) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=5.0;
    btn.clipsToBounds=YES;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_backView.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
    }];
}

-(void)payToWeb{
    if (self.block) {
        self.block();
    }
}
-(void)setLab:(UILabel *)lab andIndex:(int)index andText:(NSString *)text{
    
    UILabel * LeftLab=[[UILabel alloc]init];
    [_backView addSubview:LeftLab];
    LeftLab.text=text;
    LeftLab.textColor=RGB(102, 102, 102);
    LeftLab.font=[UIFont systemFontOfSize:14];
    [LeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(10);
        make.top.equalTo(_backView.mas_top).offset(30*index);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(75);
    }];
    
    [_backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.backgroundColor=[UIColor clearColor];
    lab.textColor=RGB(144,8,215);
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(LeftLab.mas_right).offset(0);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.top.equalTo(LeftLab.mas_top).offset(0);
        make.bottom.equalTo(LeftLab.mas_bottom).offset(0);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setDataSource:(MCRechargeModel*)dataSource{
    
    _dataSource=dataSource;
    _typeLab.text=dataSource.PayBank;
    _moneyLab.text=dataSource.PayMoney;
    
}
+(CGFloat)computeHeight:(id)info{
    return 60+10+50;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

