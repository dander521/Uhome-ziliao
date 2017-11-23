//
//  MCCancelPopView.m
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCCancelPopView.h"
#define HEIGHT  180

@interface MCCancelPopView()

/** view */
@property (nonatomic,strong) UIView   * topView;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * sureTitle;
@property (nonatomic,strong) NSString * cancelTitle;

@end

@implementation MCCancelPopView

-(instancetype)initWithFrame:(CGRect)frame Title:(NSString *)title sureTitle:(NSString *)sureTitle andCancelTitle:(NSString *)cancelTitle{
    _title=title;
    _sureTitle=sureTitle;
    _cancelTitle=cancelTitle;
    
    self = [super initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, HEIGHT+G_SCREENHEIGHT)];
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
    self.topView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    
    CGFloat H =100;
    UIView * upView=[[UIView alloc]init];
    [self.topView addSubview:upView];
    upView.backgroundColor=[UIColor whiteColor];
    upView.frame=CGRectMake(13, 0, G_SCREENWIDTH-26, H);
    upView.layer.cornerRadius=6;
    upView.clipsToBounds=YES;
    
    UILabel *titlelb = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, G_SCREENWIDTH-26,15)];
    titlelb.backgroundColor = [UIColor clearColor];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.text = _title;//@"你确定要停止追号吗？";
    titlelb.font = [UIFont systemFontOfSize:12];
    [upView addSubview:titlelb];
    titlelb.textColor=RGB(136,136,136);
    
    UIView * line = [[UIView alloc]init];
    [upView addSubview:line];
    [line setFrame:CGRectMake(0, 50, G_SCREENWIDTH-26, 0.5)];
    line.backgroundColor=RGB(213,213,213);
    
    UIButton * doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setTitle:_sureTitle/*@"立即停追"*/ forState:UIControlStateNormal];
    [doneBtn setTitleColor:RGB(144,8,215) forState:UIControlStateNormal];
    [doneBtn setFrame:CGRectMake(50, 50, G_SCREENWIDTH-26-100, 50)];
    [doneBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [upView addSubview:doneBtn];
    doneBtn.tag=8001;
    doneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    doneBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    

    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.backgroundColor=[UIColor whiteColor];
    cancelBtn.layer.cornerRadius=6;
    cancelBtn.clipsToBounds=YES;
    [cancelBtn setTitle:_cancelTitle/*@"以后再说"*/ forState:UIControlStateNormal];
    [cancelBtn setTitleColor:RGB(46,46,46) forState:UIControlStateNormal];
    [cancelBtn setFrame:CGRectMake(13, 110, G_SCREENWIDTH-26, 50)];
    [cancelBtn addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:cancelBtn];
    cancelBtn.tag=8002;
    cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    cancelBtn.titleLabel.font=[UIFont systemFontOfSize:14];

}

#pragma mark-快速创建
//+(instancetype)cancelPopView{
//    return [[self alloc]init];
//}
+(instancetype)InitPopViewWithTitle:(NSString *)title sureTitle:(NSString *)sureTitle andCancelTitle:(NSString *)cancelTitle{
    return [[self alloc]initWithFrame:CGRectZero Title:title sureTitle:sureTitle andCancelTitle:cancelTitle];
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
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = self.center;
        point.y -= HEIGHT;
        self.center = point;
    } completion:^(BOOL finished) {
        
    }];
    [view addSubview:self];
}


-(void)btnClickAction:(UIButton *)btn{
#pragma mark-点击确定
    if (btn.tag==8001){
        if (self.block) {
            self.block(1);
        }
    }
#pragma mark-点击取消
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        CGPoint point = self.center;
        point.y += HEIGHT;
        self.center = point;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end










