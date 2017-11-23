//
//  MCPaySelectedLotteryHeaderView.m
//  TLYL
//
//  Created by MC on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPaySelectedLotteryHeaderView.h"
@interface MCPaySelectedLotteryHeaderView ()
/**距024期截止：05：33：22*/
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,weak) UILabel *timeLabel;

@end

@implementation MCPaySelectedLotteryHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=[UIColor whiteColor];
    /**距024期截止：05：33：22*/
    _titleLabel =[[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.textColor=RGB(0, 0, 0);
    _titleLabel.font=[UIFont systemFontOfSize:MC_REALVALUE(12)];
    _titleLabel.text =@"加载中";
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLabel];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [self addSubview:imgV];
    imgV.image = [UIImage imageNamed:@"touzhu-yue-icon"];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(MC_REALVALUE(16)));
        make.left.equalTo(self).offset(MC_REALVALUE(16));
        make.centerY.equalTo(self.mas_centerY);
    }];
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    label.text = @"余额";
    [label sizeToFit];
    label.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(12)];
    label.textColor = [UIColor blackColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).offset(MC_REALVALUE(8));
        make.centerY.equalTo(imgV.mas_centerY);
    }];
    UILabel *valueLabel = [[UILabel alloc] init];
    [self addSubview:valueLabel];
    valueLabel.text = @"加载中";
    [valueLabel sizeToFit];
    valueLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(12)];
    valueLabel.textColor = RGB(249, 84, 83);
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(MC_REALVALUE(8));
        make.centerY.equalTo(imgV.mas_centerY);
    }];
    self.valueLabel = valueLabel;
    [self layOutConstraints];
}

+(CGFloat)computeHeight:(id)info{
    return 30;
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
        _titleLabel.text =@"距-期截止 : 00:00:00";
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
    _titleLabel.text =[NSString stringWithFormat:@"%@期 ",_IssueNumber];
    self.timeLabel.text = [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hour,minute,second];
}


-(void)layOutConstraints{
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(12)];
    timeLabel.textColor = RGB(144, 8, 215);
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(MC_REALVALUE(-18));
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.timeLabel.mas_left);
    }];
    
}


@end













































