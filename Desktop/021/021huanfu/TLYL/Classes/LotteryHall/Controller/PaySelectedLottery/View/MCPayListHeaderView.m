//
//  MCPayListHeaderView.m
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPayListHeaderView.h"
#import "MCUserMoneyModel.h"

@interface MCPayListHeaderView ()
//余额
@property (nonatomic,strong)UILabel * yuElab;


@property (nonatomic,strong)NSTimer * timer;

@end

@implementation MCPayListHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
-(void)setLab:(UILabel *)lab withColor:(UIColor *)color andFont:(CGFloat)font andText:(NSString *)text andTextAlignment:(NSTextAlignment)textAlignment{
    lab.text=text;
    lab.textColor=color;
    lab.font=[UIFont systemFontOfSize:font];
    lab.textAlignment=textAlignment;
}
-(void)createUI{

    
    self.backgroundColor=RGB(249, 249, 249);
    
    UIImageView * logoimgV=[[UIImageView alloc]init];
    [self addSubview:logoimgV];
    logoimgV.frame=CGRectMake(10, 12, 16, 16);
    logoimgV.image=[UIImage imageNamed:@"PaySelected_touzhu-yue-icon"];
        
    UILabel * lab=[[UILabel alloc]init];
    [self setLab:lab withColor:RGB(0, 0, 0) andFont:13 andText:@"余额" andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(logoimgV.mas_right).offset(10);
    }];
        
    UILabel * yuElab=[[UILabel alloc]init];
    [self setLab:yuElab withColor:RGB(250, 85, 88) andFont:13 andText:@"加载中..." andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:yuElab];
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    yuElab.text = [MCMathUnits GetMoneyShowNum:userMoneyModel.LotteryMoney];
    _yuElab=yuElab;
    [yuElab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(lab.mas_right).offset(10);
    }];

    
        
    UILabel * titleLabel=[[UILabel alloc]init];
    _titleLabel=titleLabel;
    [self setLab:titleLabel withColor:RGB(142, 0, 211) andFont:13 andText:@"00:00:00" andTextAlignment:NSTextAlignmentRight];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo(65);
    }];
    
    UILabel * issueNumberLab=[[UILabel alloc]init];
    _issueNumberLab=issueNumberLab;
    [self setLab:issueNumberLab withColor:RGB(0, 0, 0) andFont:13 andText:@"加载中..." andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:issueNumberLab];
    [issueNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.right.equalTo(titleLabel.mas_left).offset(0);
    }];
    
    
 
    
}

+(CGFloat)computeHeight:(id)info{
    return 40;
}

-(void)setYuE:(NSString *)yuE{
    _yuElab.text=[MCMathUnits GetMoneyShowNum:yuE];
}

-(void)setDataSource:(int)dataSource{
    _dataSource=dataSource;
    [self SetTime];
    [self add_timer];
}

-(void)stopTimer{
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [self.timer invalidate];
    
    self.timer = nil;
}
#pragma mark-添加定时器
-(void)add_timer{
    
    [self stopTimer];
    
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    [currentRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

-(void)timerAction{
    if (_dataSource==0) {
        _titleLabel.text =@"00:00:00";
        [self stopTimer];
        if (self.timeISZeroBlock) {
            self.timeISZeroBlock();
        }
    }else{
        _dataSource--;
        [self SetTime];
        
    }
    
}
#pragma mark-设计时间
-(void)SetTime{
    int hour   = (int)_dataSource/3600;
    int minute = (int)(_dataSource - hour*3600)/60;
    int second = (int)_dataSource%60;
    _titleLabel.text =[NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour,minute,second];
    _issueNumberLab.text=[NSString stringWithFormat:@"%@期",_IssueNumber];
}



@end














































