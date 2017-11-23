//
//  MCSignalPickView.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCSignalPickView.h"

#define HEIGHT  262

@interface MCSignalPickView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSString * title;
/** view */
@property (nonatomic,strong) UIView *topView;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;
/** srting */
@property (nonatomic,strong) NSString *selectedQuestion;



@end

@implementation MCSignalPickView

-(instancetype)initWithTitle:(NSString *)title{
    self = [super initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, HEIGHT+G_SCREENHEIGHT)];
    _title=title;
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
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.pickerView setFrame:CGRectMake(0, H, G_SCREENWIDTH, HEIGHT-H)];
    [self.pickerView setBackgroundColor:RGB(255, 255, 255)];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    [self.topView addSubview:self.pickerView];
    
}

#pragma mark-快速创建
+(instancetype)InitWithTitle:(NSString *)title{
    return [[self alloc]initWithTitle:title];
}

#pragma mark-弹出
- (void)show
{
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
        if (!self.selectedQuestion) {
            self.selectedQuestion = self.dataSource[0];
        }
        
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += HEIGHT;
        self.center = point;
    } completion:^(BOOL finished) {
#pragma mark-点击确定
        if (btn.tag==8001) {
            NSLog(@"selectedQuestion==%@",self.selectedQuestion);
            if (self.block) {
                self.block(self.selectedQuestion);
            }
        }
        [self removeFromSuperview];
    }];
    
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataSource count];
}

#pragma mark - 代理
// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataSource[row];
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedQuestion = self.dataSource[row];
}

@end










