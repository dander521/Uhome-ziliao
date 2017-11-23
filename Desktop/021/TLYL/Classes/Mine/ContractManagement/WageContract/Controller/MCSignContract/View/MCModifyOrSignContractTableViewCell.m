//
//  MCModifyOrSignContractTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyOrSignContractTableViewCell.h"
#import "MCWageButton.h"

@interface MCModifyOrSignContractTableViewCell ()

@end

@implementation MCModifyOrSignContractTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=[UIColor whiteColor];
    self.layer.cornerRadius=6;
    self.clipsToBounds=YES;
    
    UILabel * title = [[UILabel alloc]init];
    [self addSubview:title];
    title.text=@"请选择新的日工资标准";
    title.textColor=RGB(144,8,215);
    title.font=[UIFont boldSystemFontOfSize:12];
    title.textAlignment = NSTextAlignmentCenter;
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(55);
    }];
    
//    日工资标准                   销量                      活跃人数
    UILabel * lab1 = [[UILabel alloc]init];
    [self addSubview:lab1];
    lab1.text=@"日工资标准";
    lab1.textColor=RGB(46,46,46);
    lab1.font=[UIFont systemFontOfSize:12];
    lab1.textAlignment = NSTextAlignmentLeft;
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(55);
        make.left.equalTo(self.mas_left).offset(30);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    UILabel * lab2 = [[UILabel alloc]init];
    [self addSubview:lab2];
    lab2.text=@"销量";
    lab2.textColor=RGB(46,46,46);
    lab2.font=[UIFont systemFontOfSize:12];
    lab2.textAlignment = NSTextAlignmentCenter;
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(55);
        make.centerX.equalTo(self.mas_centerX).offset(20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];

    
    UILabel * lab3 = [[UILabel alloc]init];
    [self addSubview:lab3];
    lab3.text=@"活跃人数";
    lab3.textColor=RGB(46,46,46);
    lab3.font=[UIFont systemFontOfSize:12];
    lab3.textAlignment = NSTextAlignmentRight;
    [lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(55);
        make.right.equalTo(self.mas_right).offset(-25);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
}


-(void)setDataSources:(MCGetMyAndSubDayWagesThreeDataModel *)dataSources{
    _dataSources=dataSources;

    _end_T = 0;
    _begin_T = 0;
    if (dataSources.MyDayWagesThree.count>0) {
        //最大值=自己的标准
        MCMyDayWagesThreeRdDayRuleDataModel * myModel=dataSources.MyDayWagesThree[0];
        //最小值=当前用户的自己的标准
        MCMyDayWagesThreeRdDayRuleDataModel * minModel;
        if (dataSources.SubordinateDayWagesThree.count>0) {
            minModel = dataSources.SubordinateDayWagesThree[0];
        }
        
        for (int i=0; i<dataSources.InitDayWagesRules.count ;i++ ) {
            MCMyDayWagesThreeRdDayRuleDataModel * model=dataSources.InitDayWagesRules[i];
            
            if (dataSources.SubordinateDayWagesThree.count>0) {
                if ([model.DayWagesProportion isEqualToString:minModel.DayWagesProportion]) {
//                    _begin_T = i;
                    _begin_T = i+1;
                }
            }
            
            if ([model.DayWagesProportion isEqualToString:myModel.DayWagesProportion]) {
                _end_T = i+1;
            }
        }
    }
    if (_begin_T>_end_T) {
//        _begin_T=_end_T-1;
        return;
    }

    for (int j=_begin_T ; j<_end_T ;j++) {
        MCWageButton * back = [[MCWageButton alloc]init];
        back.tag=1000+j;
        [self addSubview:back];
        back.frame = CGRectMake(20, (j-_begin_T)*50+55+30, G_SCREENWIDTH-60, 40);
        back.dataSource=dataSources.InitDayWagesRules[j];
        [back addTarget:self action:@selector(selectDayWage:) forControlEvents:UIControlEventTouchUpInside];
//        if (j==_begin_T) {
//            [self selectDayWage:back];
//        }
    }

}

-(void)selectDayWage:(MCWageButton*)btn{
    _modifyOrSign_selectedModel = _dataSources.InitDayWagesRules[btn.tag-1000];
    for (int i=0;i<_end_T;i++) {
        if (i==(btn.tag-1000)) {

        }else{
            MCWageButton* wBtn = [self viewWithTag:i+1000];
            wBtn.isSelected=NO;
        }
    }
    btn.isSelected=YES;
}

+(CGFloat)computeHeight:(MCGetMyAndSubDayWagesThreeDataModel *)info{
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
//                    begin_T = i;
                    begin_T = i+1;
                }
            }
            if ([model.DayWagesProportion isEqualToString:myModel.DayWagesProportion]) {
                end_T = i+1;
            }
        }
        
        if (begin_T>end_T) {
            begin_T=end_T-1;
            return 0.0001;
        }
        CGFloat H = (end_T-begin_T)*50+65 +30;
        return H;
    }

    return 0.0001;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

















