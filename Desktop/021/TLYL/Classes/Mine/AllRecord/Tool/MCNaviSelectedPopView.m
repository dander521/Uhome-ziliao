//
//  MCNaviSelectedPopView.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNaviSelectedPopView.h"


@interface MCNaviSelectedPopView()

@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,assign)MCNaviSelectedPopType Type;
@end

@implementation MCNaviSelectedPopView
-(instancetype)InitWithType:(MCNaviSelectedPopType)Type{
    
    if (self == [super init]) {
        _Type=Type;
       [self initView];
    }
    return self;
}

//- (instancetype)initWithFrame:(CGRect)frame{
//    if (self == [super initWithFrame:frame]) {
//        [self initView];
//    }
//    return self;
//}
- (void)initView{
   
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *endDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    CGFloat HHH=200;
    if (_Type == MCNaviSelectedPopType_PersonReport||_Type == MCNaviSelectedPopType_BonusRecord) {
        HHH=150;
    }else if (_Type == MCNaviSelectedPopType_QiPaiXiaJiReport){
        HHH=250;
    }else if (_Type == MCNaviSelectedPopType_dayWageContract){
        HHH=100;
    }else if (_Type == MCNaviSelectedPopType_BonusContract){
        HHH=50;
    }
    
    
    /*
     * 白色框背景
     */
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(13, 13, G_SCREENWIDTH - 26, HHH)];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    self.bgView = bgView;
    
    UIView *bgViewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH - 26, 49.5)];
    bgViewTitle.tag = 1004;
    [bgView addSubview:bgViewTitle];
    bgViewTitle.backgroundColor = [UIColor whiteColor];
    [bgViewTitle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTitleClick)]];
    
    
    self.label1 =[[UILabel alloc]init];
    self.tf1    =[[UITextField alloc]init];
    self.tf1.inputAccessoryView = [self addToolbar];
    int T = 0;
    if (_Type == MCNaviSelectedPopType_PersonReport) {
        
    }else{
        
        if (_Type==MCNaviSelectedPopType_ZhuiHao) {
            [self setLeftText:@"投注彩种" andRightLab:self.label1 andRightText:@"全部彩种" andIndex:0];
            T=1;
        }else if (_Type==MCNaviSelectedPopType_ZhangBian){
            [self setLeftText:@"交易类型" andRightLab:self.label1 andRightText:@"全部" andIndex:0];
            T=1;
        }else if (_Type==MCNaviSelectedPopType_QiPaiXiaJiReport){
            self.xiajiType = [[UILabel alloc]init];
            [self setLeftText:@"用户名称" andRightTf:self.tf1 andRightText:@"请输入用户名" andIndex:0];
            [self setLeftText:@"下级类型" andRightLab:self.xiajiType andRightText:@"全部" andIndex:1];
            T=2;
        }else if (_Type==MCNaviSelectedPopType_BonusRecord){
            [self setLeftText:@"用户名称" andRightTf:self.tf1 andRightText:@"请输入用户名" andIndex:0];
            T=0;
        }else if (_Type==MCNaviSelectedPopType_dayWageRecord || _Type==MCNaviSelectedPopType_dayWageContract){
            [self setLeftText:@"用户名称" andRightTf:self.tf1 andRightText:@"请输入用户名" andIndex:0];
            T=1;
        }else if (_Type == MCNaviSelectedPopType_BonusContract){
            [self setLeftText:@"用户名称" andRightTf:self.tf1 andRightText:@"请输入用户名" andIndex:0];
            T=1;
        }

    }
    
    
    self.label2 =[[UILabel alloc]init];
    if (_Type==MCNaviSelectedPopType_dayWageContract) {
        [self setLeftText:@"契约状态" andRightLab:self.label2 andRightText:@"全部" andIndex:T];
    }else if (_Type == MCNaviSelectedPopType_BonusContract){
        
    }else{
        if (_Type == MCNaviSelectedPopType_PersonReport||_Type == MCNaviSelectedPopType_QiPaiXiaJiReport) {
            [self setLeftText:@"记录选择" andRightLab:self.label2 andRightText:@"当天记录" andIndex:T];
        }else if (_Type == MCNaviSelectedPopType_BonusRecord){
            
        }else{
            [self setLeftText:@"记录选择" andRightLab:self.label2 andRightText:@"当前记录" andIndex:T];
        }

        self.label3 =[[UILabel alloc]init];
        [self setLeftText:@"开始时间" andRightLab:self.label3 andRightText:[NSString stringWithFormat:@"%@",endDateStr] andIndex:T+1];
        
        
        self.label4 =[[UILabel alloc]init];
        [self setLeftText:@"结束时间" andRightLab:self.label4 andRightText:[NSString stringWithFormat:@"%@",endDateStr] andIndex:T+2];
    }

    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"立即搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:btn];
    btn.backgroundColor = RGB(144, 8, 216);
    btn.layer.cornerRadius = 6;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.height.equalTo(@(40));
        make.top.equalTo(bgView.mas_bottom).offset(10);
    }];
    btn.tag=8008;
    self.hidden = YES;
}


-(void)setLeftText:(NSString *)L_text andRightLab:(UILabel *)R_label andRightText:(NSString *)R_text andIndex:(int)index{
    
    
    CGFloat H =50;
    
    
    UIButton * back =[[UIButton alloc]init];
    [self.bgView addSubview:back];
    back.backgroundColor=[UIColor clearColor];
    [back addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    back.tag=8000+index;
    back.frame= CGRectMake(0, 0+H*index, G_SCREENWIDTH-26, H);
    
    UILabel * L_label =[[UILabel alloc]init];
    L_label.textColor=RGB(46, 46, 46);
    L_label.font=[UIFont systemFontOfSize:14];
    L_label.text =L_text;
    L_label.textAlignment=NSTextAlignmentLeft;
    [back  addSubview:L_label];
    L_label.frame= CGRectMake(19, 0, 100, H);
    
    R_label.textColor=RGB(102,102,102);
    R_label.font=[UIFont systemFontOfSize:14];
    R_label.text =R_text;
    R_label.textAlignment=NSTextAlignmentRight;
    [back  addSubview:R_label];
    R_label.frame= CGRectMake(G_SCREENWIDTH-26-35-200, 0, 200, H);
    
    
    UIImageView *imgVe = [[UIImageView alloc] init];
    imgVe.image = [UIImage imageNamed:@"MC_right_arrow"];
    [back addSubview:imgVe];
    imgVe.alpha=0.8;
    [imgVe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(back.mas_right).offset(-16);
        make.centerY.equalTo(back);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(16);
    }];
    
    
    if (index<3) {
        UIView * line=[[UIView alloc]init];
        line.backgroundColor=RGB(231,231,231);
        line.frame=CGRectMake(19, H-0.5, G_SCREENWIDTH-26-19, 0.5);
        [back addSubview:line];
    }

}

#pragma mark-左边Label  右边输入框
-(void)setLeftText:(NSString *)L_text andRightTf:(UITextField *)R_tf andRightText:(NSString *)R_text andIndex:(int)index{
    
    
    CGFloat H =50;
    
    
    UIButton * back =[[UIButton alloc]init];
    [self.bgView addSubview:back];
    back.backgroundColor=[UIColor clearColor];
    [back addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    back.tag=8000+index;
    back.frame= CGRectMake(0, 0+H*index, G_SCREENWIDTH-26, H);
    
    UILabel * L_label =[[UILabel alloc]init];
    L_label.textColor=RGB(46, 46, 46);
    L_label.font=[UIFont systemFontOfSize:14];
    L_label.text =L_text;
    L_label.textAlignment=NSTextAlignmentLeft;
    [back  addSubview:L_label];
    L_label.frame= CGRectMake(19, 0, 100, H);
    
    
    R_tf.textColor=RGB(102,102,102);
//    R_tf.font=[UIFont systemFontOfSize:14];
//    R_tf.text =R_text;
//    R_tf.textAlignment=NSTextAlignmentRight;
    [back  addSubview:R_tf];
    R_tf.frame= CGRectMake(G_SCREENWIDTH-26-35-150, 0, 150, H);
//    R_tf.placeholder=R_text;
//    R_tf.backgroundColor= [UIColor clearColor];
    [R_tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
//    [R_tf setValue:RGB(181,181,181)  forKeyPath:@"_placeholderLabel.textColor"];
//    [R_tf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//    R_tf.contentVerticalAlignment=UIControlContentHorizontalAlignmentRight;
//    R_tf.keyboardType=UIKeyboardTypeDefault;
    R_tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:R_text attributes:@{NSForegroundColorAttributeName:RGB(181, 181, 181),NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    R_tf.textAlignment = NSTextAlignmentRight;
    
    
    UIView * line=[[UIView alloc]init];
    line.backgroundColor=RGB(231,231,231);
    line.frame=CGRectMake(19, H-0.5, G_SCREENWIDTH-26-19, 0.5);
    [back addSubview:line];
    
}

#pragma mark-actionClick
-(void)actionClick:(UIButton *)btn{
    NSInteger T=btn.tag-8000;
    if (btn.tag==8008) {
        [self dismiss];
    }else{
        if (_Type == MCNaviSelectedPopType_PersonReport) {
            T=T+1;
        }
    }
    [self textFieldDone];
    if (self.block) {
        self.block(T);
    }
}

- (void)bgViewTitleClick{
   
}


- (void)showPopView{
    
    self.hidden = NO;
    
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.1  animations:^{
        
        self.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
        
    }];
}
- (UIToolbar *)addToolbar{
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 35)];
    toolbar.tintColor = RGB(144,8,215);
    toolbar.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

//完成
-(void)textFieldDone{
    [self.tf1 resignFirstResponder];
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    
//    textField.text= [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}

@end






















