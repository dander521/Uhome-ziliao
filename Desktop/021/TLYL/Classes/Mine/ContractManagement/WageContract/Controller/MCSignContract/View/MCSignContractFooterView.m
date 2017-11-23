//
//  MCSignContractFooterView.m
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSignContractFooterView.h"
@interface MCSignContractFooterView ()

@property (nonatomic,copy)UIButton * btn;

@end

@implementation MCSignContractFooterView
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
    UIButton * btn = [[UIButton alloc]init];
    [self setFooter:btn];
    btn.frame=CGRectMake(0, 25, G_SCREENWIDTH-26, 40);
    _btn=btn;
}

-(void)setFooter:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"设定契约" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.backgroundColor=RGB(144,8,215);
    [self addSubview:btn];
    [btn addTarget:self action:@selector(setSignContract) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=6.0;
    btn.clipsToBounds=YES;
}


-(void)setSignContract{
    if (self.block) {
        self.block();
    }
}

+(CGFloat)computeHeight:(id)info{
    return 20+40+30;
}

-(void)setFooterViewHidden:(MCGetMyAndSubDayWagesThreeDataModel *)info{
    int begin_T = 0;
    int end_T = 0;
    
    if (info.MyDayWagesThree.count>0) {
        MCMyDayWagesThreeRdDayRuleDataModel * myModel=info.MyDayWagesThree[0];
        MCMyDayWagesThreeRdDayRuleDataModel * minModel;
        if (info.SubordinateDayWagesThree.count>0) {
            minModel = info.SubordinateDayWagesThree[0];
        }
        
        for (int i=0; i<info.InitDayWagesRules.count ;i++ ) {
            MCMyDayWagesThreeRdDayRuleDataModel * model=info.InitDayWagesRules[i];
            
            if (info.SubordinateDayWagesThree.count>0) {
                if ([model.DayWagesProportion isEqualToString:minModel.DayWagesProportion]) {
                    begin_T = i;
                }
            }
            if ([model.DayWagesProportion isEqualToString:myModel.DayWagesProportion]) {
                end_T = i+1;
            }
        }
        
        if (begin_T>end_T) {
            begin_T=end_T-1;
            _btn.hidden=YES;
            return;
        }
        
        _btn.hidden=NO;
        return;
    }
    
    _btn.hidden=YES;
}

@end




































