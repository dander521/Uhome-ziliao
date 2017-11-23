//
//  MCDatePickerView.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCDatePickerView.h"

#define HEIGHT  262

@interface MCDatePickerView()
@property (nonatomic,strong) NSString * title;
/** view */
@property (nonatomic,strong) UIView *topView;

/** srting */
@property (nonatomic,strong) NSString *selectedQuestion;
@property (nonatomic,strong) NSDate *minDate;
@property (nonatomic,strong) NSDate *maxDate;
@property (strong, nonatomic)  UIDatePicker *datePicker;

@end

@implementation MCDatePickerView

-(instancetype)initWithTitle:(NSString *)title Mindate:(NSDate *)minDate MaxDate:(NSDate *)maxdate{
    self = [super initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, HEIGHT+G_SCREENHEIGHT)];
    _title=title;
    _minDate=minDate;
    _maxDate=maxdate;
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIView *backView = [[UIView alloc]init];
    [self addSubview:backView];
    backView.backgroundColor=RGB(0, 0, 0);
    backView.alpha=0.5;
    backView.frame=CGRectMake(0, 0, G_SCREENWIDTH,HEIGHT+G_SCREENHEIGHT);
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, G_SCREENHEIGHT, G_SCREENWIDTH, HEIGHT)];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];
    
    CGFloat H =40;
    UIView * upView=[[UIView alloc]init];
    [self.topView addSubview:upView];
    upView.backgroundColor=RGB(248, 248, 248);
    upView.frame=CGRectMake(0, 0, G_SCREENWIDTH, H);
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setTitleColor:RGB(51, 142, 251) forState:UIControlStateNormal];
    [doneBtn setFrame:CGRectMake(G_SCREENWIDTH-110, 0, 100, H)];
    [doneBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:doneBtn];
    doneBtn.tag=8001;
    doneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    doneBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(51, 142, 251) forState:UIControlStateNormal];
    [cancelBtn setFrame:CGRectMake(10, 0, 100, H)];
    [cancelBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:cancelBtn];
    cancelBtn.tag=8002;
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, G_SCREENWIDTH-200, H)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = _title;
    titlelb.font = [UIFont systemFontOfSize:15];
    [self.topView addSubview:titlelb];
    titlelb.textColor=RGB(46, 46, 46);
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, H, G_SCREENWIDTH, HEIGHT-H)];
    datePicker.backgroundColor=RGB(255, 255, 255);
    [self.topView addSubview:datePicker];
    [datePicker setValue:RGB(46, 46, 46) forKey:@"textColor"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone localTimeZone]];
    self.datePicker = datePicker;
    datePicker.minimumDate= _minDate;
    datePicker.maximumDate= _maxDate;

}

#pragma mark-快速创建
+(instancetype)InitWithTitle:(NSString *)title Mindate:(NSDate *)minDate MaxDate:(NSDate *)maxdate{
    return [[self alloc]initWithTitle:title Mindate:minDate MaxDate:maxdate];
}

#pragma mark-弹出
- (void)show
{
    // 设置当前显示时间
    [self.datePicker setDate:[NSDate date] animated:YES];

    [self showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark-添加弹出移除的动画效果
- (void)showInView:(UIView *)view
{
    // 浮现
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint point = self.center;
        point.y -= HEIGHT;
        self.center = point;
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:self];
}


-(void)btnClickAction:(UIButton *)btn{
    if (btn.tag==8001){
        
        
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += HEIGHT;
        self.center = point;
    } completion:^(BOOL finished) {
#pragma mark-点击确定
        if (btn.tag==8001) {
            NSDate *select = self.datePicker.date;
            NSDateFormatter *dateFormmater = [[NSDateFormatter alloc]init];
            [dateFormmater setDateFormat:@"yyyy/MM/dd"];
            NSString *resultString = [dateFormmater stringFromDate:select];
            if (self.sureBlock) {
                self.sureBlock(resultString);
            }
        }
        [self removeFromSuperview];
    }];
    
}





@end
