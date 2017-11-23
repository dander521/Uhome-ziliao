//
//  MCMyselfWageContractTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMyselfWageContractTableViewCell.h"
#import "MCDataTool.h"
#import "MCContractMgtTool.h"

@interface MCMyselfWageContractTableViewCell()

//DayWageStandard    String    日工资标准（文本显示）
@property (nonatomic,strong) UILabel * DayWagesProportion ;//日工资标准（数据）
@property (nonatomic,strong) UILabel * DaySales;//销量
@property (nonatomic,strong) UILabel * ActiveNumber;// 活跃人数

@end

@implementation MCMyselfWageContractTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    

    self.backgroundColor = [UIColor clearColor];
    
    UIView *baseView = [[UIView alloc] init];
    [self addSubview:baseView];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.frame=CGRectMake(13, 0, G_SCREENWIDTH-26, 94);
    baseView.clipsToBounds=YES;
    baseView.layer.cornerRadius=6;
    
    
    UILabel *lab1 = [[UILabel alloc] init];
    [baseView addSubview:lab1];
    lab1.text = @"我的日工资契约";
    lab1.frame=CGRectMake(20, 15, 100, 18);
    lab1.font=[UIFont systemFontOfSize:12];
    lab1.textColor =RGB(46,46,46);
    
    UIButton *dayWageRuleBtn = [[UIButton alloc]init];
    [baseView addSubview:dayWageRuleBtn];
    [dayWageRuleBtn setTitle:@"日工资规则" forState:UIControlStateNormal];
    [dayWageRuleBtn setTitleColor:RGB(144,8,215) forState:UIControlStateNormal];
    dayWageRuleBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    dayWageRuleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [dayWageRuleBtn addTarget:self action:@selector(popDayWageRule) forControlEvents:UIControlEventTouchUpInside];
    [dayWageRuleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.centerY.equalTo(lab1.mas_centerY);
        make.right.equalTo(baseView.mas_right).offset(-15);
        make.width.mas_equalTo(70);
    }];
    
    
    UIView *baseView2 = [[UIView alloc] init];
    [baseView addSubview:baseView2];
    baseView2.backgroundColor = RGB(246,243,248);
    baseView2.frame=CGRectMake(20, 43, G_SCREENWIDTH-60, 41);
    baseView2.layer.cornerRadius =5;
    baseView2.clipsToBounds=YES;
    
    
    //日工资标准：1.1%        0        ：0
    _DayWagesProportion = [[UILabel alloc] init];
    _DayWagesProportion.font=[UIFont systemFontOfSize:12];
    _DayWagesProportion.textColor=RGB(249,84,83);
    _DayWagesProportion.textAlignment=NSTextAlignmentLeft;
    [baseView2 addSubview:self.DayWagesProportion];
    _DayWagesProportion.text = @"日工资标准：加载中...";
    [_DayWagesProportion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseView2);
        make.left.equalTo(baseView2.mas_left).offset(18);
        make.width.mas_equalTo(150);
    }];
    
    _DaySales = [[UILabel alloc] init];
    [baseView2 addSubview:_DaySales];
    _DaySales.font=[UIFont systemFontOfSize:12];
    _DaySales.textColor=RGB(249,84,83);
    _DaySales.textAlignment=NSTextAlignmentCenter;
    _DaySales.text = @"销量：加载中...";
    [_DaySales mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseView2);
        make.centerX.equalTo(baseView2.mas_centerX);
        make.width.mas_equalTo(100);
    }];

    
    _ActiveNumber = [[UILabel alloc] init];
    [baseView2 addSubview:_ActiveNumber];
    _ActiveNumber.font=[UIFont systemFontOfSize:12];
    _ActiveNumber.textColor=RGB(249,84,83);
    _ActiveNumber.textAlignment=NSTextAlignmentRight;
    _ActiveNumber.text = @"活跃人数：加载中...";
    [_ActiveNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(baseView2);
        make.right.equalTo(baseView2.mas_right).offset(-18);
        make.width.mas_equalTo(150);
    }];

    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDataSource:(MCMyDayWagesThreeRdDayRuleDataModel *)dataSource{
    _dataSource = dataSource;
   _DayWagesProportion.text = [NSString stringWithFormat:@"日工资标准：%@",[MCContractMgtTool getPercentNumber:dataSource.DayWagesProportion]];
    _DaySales.text = [NSString stringWithFormat:@"销量：%@",dataSource.DaySales];
    _ActiveNumber.text = [NSString stringWithFormat:@"活跃人数：%@",dataSource.ActiveNumber];

}

+(CGFloat)computeHeight:(id)info{
    return 94;
}

#pragma mark-popDayWageRule
-(void)popDayWageRule{
    if (self.dayWageRuleBlock) {
        self.dayWageRuleBlock();
    }
}

@end















