//
//  MCMMTBPopView.m
//  TLYL
//
//  Created by miaocai on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMTBPopView.h"

@interface MCMMTBPopView()
@property (nonatomic,weak) UITextField *tf;
@end

@implementation MCMMTBPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.frame = CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *endDateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(13, 13 + 64, G_SCREENWIDTH - 26, 250)];
    [self addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    self.bgView = bgView;
    
    UIView *bgViewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH - 26, 49.5)];
    bgViewTitle.tag = 1004;
    [bgView addSubview:bgViewTitle];
    bgViewTitle.backgroundColor = [UIColor whiteColor];

    self.titleLab =[[UILabel alloc]init];
    self.titleLab.textColor=RGB(46, 46, 46);
    self.titleLab.font=[UIFont systemFontOfSize:14];
    self.titleLab.text =@"会员名称";
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    [bgViewTitle  addSubview:_titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(11);
        make.left.equalTo(bgView).offset(11);
        make.height.equalTo(@(38));
        
    }];
    
    UITextField  *tf=[[UITextField alloc]init];
    [bgViewTitle addSubview:tf];
    self.tf = tf;
    tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名称" attributes:@{NSForegroundColorAttributeName:RGB(181, 181, 181),NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(14)]}];
    tf.textAlignment = NSTextAlignmentRight;
 
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.titleLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
    }];

    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = RGB(213, 213, 213);
    [bgViewTitle addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewTitle.mas_bottom);
        make.right.left.equalTo(bgViewTitle);
    }];
    
    UIView *bgViewSt = [[UIView alloc] initWithFrame:CGRectMake(0, 50, G_SCREENWIDTH - 26, 49.5)];
    [bgView addSubview:bgViewSt];
    bgViewSt.tag = 1001;
    [bgViewSt addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewStClick)]];
    bgViewSt.backgroundColor = [UIColor whiteColor];
    self.statusLab =[[UILabel alloc]init];
    self.statusLab.textColor=RGB(46, 46, 46);
    self.statusLab.font=[UIFont systemFontOfSize:14];
    self.statusLab.text =@"彩种";
    self.statusLab.textAlignment=NSTextAlignmentCenter;
    [bgViewSt  addSubview:self.statusLab];
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(11);
        make.left.equalTo(self.titleLab);
        make.height.equalTo(@(38));
        
    }];
    
    self.statusLabDetail =[[UILabel alloc]init];
    self.statusLabDetail.textColor=RGB(102, 102, 102);
    self.statusLabDetail.font=[UIFont systemFontOfSize:14];
    self.statusLabDetail.text =@"全部彩种";
    self.statusLabDetail.textAlignment=NSTextAlignmentRight;
    [bgViewSt  addSubview: self.statusLabDetail];
    
    [self.statusLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.statusLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
        
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = RGB(213, 213, 213);
    [bgViewSt addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewSt.mas_bottom);
        make.right.left.equalTo(bgViewSt);
    }];
    UIImageView *imgVst = [[UIImageView alloc] init];
    imgVst.image = [UIImage imageNamed:@"MC_right_arrow"];
    [bgViewSt addSubview:imgVst];
    [imgVst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgViewSt.mas_right).offset(-16);
        make.centerY.equalTo(bgViewSt);
    }];
    
    UIView *bgViewStatus = [[UIView alloc] initWithFrame:CGRectMake(0, 100, G_SCREENWIDTH - 26, 49.5)];
    [self.bgView addSubview:bgViewStatus];
    [bgViewStatus addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewTitleClick)]];
    bgViewStatus.backgroundColor = [UIColor whiteColor];
    
    UILabel *stLabel =[[UILabel alloc]init];
    stLabel.textColor=RGB(46, 46, 46);
    stLabel.font=[UIFont systemFontOfSize:14];
    stLabel.text =@"状态";
    self.stLabel = stLabel;
    stLabel.textAlignment=NSTextAlignmentCenter;
    [bgViewStatus addSubview:stLabel];
    
    [stLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLab.mas_bottom).offset(11);
        make.left.equalTo(self.statusLab);
        make.height.equalTo(@(38));
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = RGB(213, 213, 213);
    [bgViewStatus addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewSt.mas_bottom);
        make.right.left.equalTo(bgViewStatus);
    }];
    UILabel *stValueLabel =[[UILabel alloc]init];
    stValueLabel.text = @"全部";
    stValueLabel.textColor=RGB(102, 102, 102);
    stValueLabel.font=[UIFont systemFontOfSize:14];
    self.stValueLabel = stValueLabel;
    stValueLabel.textAlignment=NSTextAlignmentRight;
    [bgViewStatus  addSubview: stValueLabel];
    
    [stValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(stLabel);
        make.width.equalTo(@(MC_REALVALUE(129)));
    }];
    
    UIImageView *imgVs = [[UIImageView alloc] init];
    imgVs.image = [UIImage imageNamed:@"MC_right_arrow"];
    [bgViewStatus addSubview:imgVs];
    [imgVs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(stValueLabel.mas_right).offset(5);
        make.centerY.equalTo(stValueLabel);
    }];
    

    
    UIView *bgViewStart = [[UIView alloc] initWithFrame:CGRectMake(0, 150, G_SCREENWIDTH - 26, 49.5)];
    [bgView addSubview:bgViewStart];
    bgViewStart.tag = 1003;
    [bgViewStart addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewStartClick)]];
    bgViewStart.backgroundColor = [UIColor whiteColor];
    self.startDateLab =[[UILabel alloc]init];
    self.startDateLab.textColor=RGB(46, 46, 46);
    self.startDateLab.font=[UIFont systemFontOfSize:14];
    self.startDateLab.text =@"开始时间";
    self.startDateLab.textAlignment=NSTextAlignmentCenter;
    [bgViewStart addSubview:self.startDateLab];
    
    [self.startDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(stLabel.mas_bottom).offset(11);
        make.left.equalTo(stLabel);
        make.height.equalTo(@(38));
    }];
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = RGB(213, 213, 213);
    [bgViewStart addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewStart.mas_bottom);
        make.right.left.equalTo(bgViewStart);
    }];
    self.startDateLabDetail =[[UILabel alloc]init];
    self.startDateLabDetail.textColor=RGB(102, 102, 102);
    self.startDateLabDetail.font=[UIFont systemFontOfSize:14];
    self.startDateLabDetail.text =endDateStr;
    self.startDateLabDetail.textAlignment=NSTextAlignmentRight;
    [bgViewStart addSubview: self.startDateLabDetail];
    
    [self.startDateLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.startDateLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
    }];
    
    UIImageView *imgVs1 = [[UIImageView alloc] init];
    imgVs1.image = [UIImage imageNamed:@"MC_right_arrow"];
    [bgViewStart addSubview:imgVs1];
    [imgVs1 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(bgViewStart.mas_right).offset(-16);
        make.centerY.equalTo(self.startDateLab);
    }];
    
    UIView *bgViewEnd = [[UIView alloc] initWithFrame:CGRectMake(0, 200, G_SCREENWIDTH - 26, 49.5)];
    [bgView addSubview:bgViewEnd];

    bgViewEnd.tag = 1002;
    [bgViewEnd addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick)]];
    self.endDateLab =[[UILabel alloc]init];
    self.endDateLab.textColor=RGB(46, 46, 46);
    self.endDateLab.font=[UIFont systemFontOfSize:14];
    self.endDateLab.text =@"结束时间";
    self.endDateLab.textAlignment=NSTextAlignmentCenter;
    [bgViewEnd  addSubview:self.endDateLab];
    
    [self.endDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startDateLab.mas_bottom).offset(11);
        make.left.equalTo(self.titleLab);
        make.height.equalTo(@(38));
        
    }];
    
    self.endDateLabDetail =[[UILabel alloc]init];
    self.endDateLabDetail.textColor=RGB(102, 102, 102);
    self.endDateLabDetail.font=[UIFont systemFontOfSize:14];
    self.endDateLabDetail.text =endDateStr;
    self.endDateLabDetail.textAlignment=NSTextAlignmentRight;
    [bgViewEnd  addSubview: self.endDateLabDetail];
    
    [self.endDateLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.endDateLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
        
    }];
    
    UIImageView *imgVe = [[UIImageView alloc] init];
    imgVe.image = [UIImage imageNamed:@"MC_right_arrow"];
    [bgViewEnd addSubview:imgVe];
    [imgVe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgViewEnd.mas_right).offset(-16);
        make.centerY.equalTo(self.endDateLab);
    }];
    
    
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"立即搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:btn];
    btn.backgroundColor = RGB(144, 8, 216);
    btn.layer.cornerRadius = 6;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.height.equalTo(@(40));
        make.top.equalTo(bgView.mas_bottom).offset(10);
    }];
    self.hidden = YES;
    
}


//结束时间
- (void)bgViewClick{
    [self.tf resignFirstResponder];
    if (self.endDateBlock) {
        self.endDateBlock();
    }
}
//开始时间
- (void)bgViewStartClick{
   [self.tf resignFirstResponder];
    if (self.startDateBlock) {
        self.startDateBlock();
    }
}
// 彩种
- (void)bgViewStClick{
    [self.tf resignFirstResponder];
    if (self.statusBlock) {
        self.statusBlock();
    }
}
//状态
- (void)bgViewTitleClick{
    [self.tf resignFirstResponder];
    if (self.lotteryBlock) {
        self.lotteryBlock();
    }
}

- (void)searchBtnClick{
    [self.tf resignFirstResponder];
    if (self.searchBtnBlock) {
        self.searchBtnBlock(self.tf.text);
    }
    self.hidden = YES;
}

- (void)showPopView{
    
    self.hidden = NO;
    
}
- (void)hidePopView{
    
    [UIView animateWithDuration:0.1  animations:^{
        
        self.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
        
    }];
}
@end









