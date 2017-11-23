//
//  MCSignContractHeaderView.m
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSignContractHeaderView.h"
@interface MCSignContractHeaderView ()

//我的日工资契约：每天1.1%的日工资
//用户名：工资代理3                                 当前日工资：0
@property (nonatomic,strong) UILabel * DayWagesProportion ;
@property (nonatomic,strong) UILabel * UserName;
//@property (nonatomic,strong) UILabel * Wage;


@end

@implementation MCSignContractHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *baseView = [[UIView alloc] init];
    [self addSubview:baseView];
    baseView.backgroundColor = [UIColor whiteColor];
    baseView.frame=CGRectMake(0, 15, G_SCREENWIDTH-26, 71);
    baseView.clipsToBounds=YES;
    baseView.layer.cornerRadius=6;
    

    _DayWagesProportion = [[UILabel alloc] init];
    _DayWagesProportion.font=[UIFont systemFontOfSize:12];
    _DayWagesProportion.textColor=RGB(46,46,46);
    _DayWagesProportion.textAlignment=NSTextAlignmentLeft;
    [baseView addSubview:self.DayWagesProportion];
    _DayWagesProportion.text = @"我的日工资契约：加载中...";
    [_DayWagesProportion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView.mas_top).offset(10);
        make.left.equalTo(baseView.mas_left).offset(16);
        make.right.equalTo(baseView.mas_right).offset(-16);
        make.height.mas_equalTo(20);
    }];
    
    _UserName = [[UILabel alloc] init];
    [baseView addSubview:_UserName];
    _UserName.font=[UIFont systemFontOfSize:12];
    _UserName.textColor=RGB(46,46,46);
    _UserName.textAlignment=NSTextAlignmentLeft;
    _UserName.text = @"用户名：加载中...  当前日工资：0 ";
    [_UserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(baseView.mas_bottom).offset(-10);
        make.left.equalTo(baseView.mas_left).offset(16);
        make.right.equalTo(baseView.mas_right).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    
//    _Wage = [[UILabel alloc] init];
//    [baseView addSubview:_Wage];
//    _Wage.font=[UIFont systemFontOfSize:12];
//    _Wage.textColor=RGB(46,46,46);
//    _Wage.textAlignment=NSTextAlignmentRight;
//    _Wage.text = @"当前日工资：0 ";
//    [_Wage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(baseView.mas_bottom).offset(-10);
//        make.left.equalTo(baseView.mas_left).offset(16);
//        make.right.equalTo(baseView.mas_right).offset(-16);
//        make.height.mas_equalTo(20);
//    }];
    
    
    
}



-(void)setDataSource:(MCGetMyAndSubDayWagesThreeDataModel *)dataSource{
    _dataSource=dataSource;
    if (dataSource.MyDayWagesThree.count>0) {
        MCMyDayWagesThreeRdDayRuleDataModel * model1 = dataSource.MyDayWagesThree[0];
        _DayWagesProportion.text = [NSString stringWithFormat:@"我的日工资契约：%@",model1.DayWageStandard];

    }
    
//    _UserName.text = @"用户名：加载中...";
    if (_xiaJiModel && dataSource) {
        if (dataSource.SubordinateDayWagesThree.count>0) {
            MCMyDayWagesThreeRdDayRuleDataModel * model2 = dataSource.SubordinateDayWagesThree[0];
            //        _Wage.text = [NSString stringWithFormat:@"当前日工资：%@",model2.DayWageStandard];
            _UserName.text = [NSString stringWithFormat:@"用户名：%@  当前日工资：%@",_xiaJiModel.UserName,model2.DayWageStandard];
        }else{
            
            _UserName.text = [NSString stringWithFormat:@"用户名：%@  当前日工资：0",_xiaJiModel.UserName];
        }
        
    }


    
    
}

-(void)setXiaJiModel:(MCMyXiaJiDayWagesThreeListModelsDataModel *)xiaJiModel{
    
    _xiaJiModel=xiaJiModel;
//    _UserName.text = [NSString stringWithFormat:@"用户名：%@",xiaJiModel.UserName];
    if (_xiaJiModel && _dataSource) {
        if (_dataSource.SubordinateDayWagesThree.count>0) {
            MCMyDayWagesThreeRdDayRuleDataModel * model2 = _dataSource.SubordinateDayWagesThree[0];
            //        _Wage.text = [NSString stringWithFormat:@"当前日工资：%@",model2.DayWageStandard];
            _UserName.text = [NSString stringWithFormat:@"用户名：%@  当前日工资：%@",_xiaJiModel.UserName,model2.DayWageStandard];
        }else{
            
            _UserName.text = [NSString stringWithFormat:@"用户名：%@  当前日工资：0",_xiaJiModel.UserName];
        }
        
    }
}


+(CGFloat)computeHeight:(id)info{
    return 71+15+10;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
