

//
//  MCNaviPopView.m
//  TLYL
//
//  Created by miaocai on 2017/7/28.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNaviPopView.h"



@interface MCNaviPopView()
@end

@implementation MCNaviPopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
- (void)initView{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *endDateStr = [dateFormatter stringFromDate:[NSDate date]];
   
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(13, 13, G_SCREENWIDTH - 26, 200)];
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
    self.titleLab =[[UILabel alloc]init];
    self.titleLab.textColor=RGB(46, 46, 46);
    self.titleLab.font=[UIFont systemFontOfSize:14];
    self.titleLab.text =@"投注彩种";
    self.titleLab.textAlignment=NSTextAlignmentCenter;
    
    [bgViewTitle  addSubview:_titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(11);
        make.left.equalTo(bgView).offset(11);
        make.height.equalTo(@(38));
        
    }];
    
    self.titleLabDetail =[[UILabel alloc]init];
    self.titleLabDetail.textColor=RGB(102, 102, 102);
    self.titleLabDetail.font=[UIFont systemFontOfSize:14];
    self.titleLabDetail.text =@"全部";
    self.titleLabDetail.textAlignment=NSTextAlignmentRight;
    [bgViewTitle addSubview: self.titleLabDetail];
    self.bgViewTitle = bgViewTitle;
    [self.titleLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.titleLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
    }];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    self.imgV = imgV;
    imgV.image = [UIImage imageNamed:@"MC_right_arrow"];
    [bgViewTitle addSubview:imgV];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabDetail.mas_right).offset(5);
        make.centerY.equalTo(self.titleLab);
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
    self.statusLab.text =@"记录选择";
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
    self.statusLabDetail.text =@"当前记录";
    self.statusLabDetail.textAlignment=NSTextAlignmentRight;
    [bgViewSt  addSubview: self.statusLabDetail];
    self.bgViewSt = bgViewSt;
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
         make.left.equalTo(self.titleLabDetail.mas_right).offset(5);
        make.centerY.equalTo(self.statusLab);
    }];
    self.imgVst = imgVst;
    UIView *bgViewStart = [[UIView alloc] initWithFrame:CGRectMake(0, 100, G_SCREENWIDTH - 26, 49.5)];
    [bgView addSubview:bgViewStart];
    self.bgViewStart = bgViewStart;
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
        make.top.equalTo(self.statusLab.mas_bottom).offset(11);
        make.left.equalTo(self.titleLab);
        make.height.equalTo(@(38));
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = RGB(213, 213, 213);
    [bgViewStart addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewStart.mas_bottom);
        make.right.left.equalTo(bgViewStart);
    }];
    self.line3 = line3;
    self.startDateLabDetail =[[UILabel alloc]init];
    self.startDateLabDetail.textColor=RGB(102, 102, 102);
    self.startDateLabDetail.font=[UIFont systemFontOfSize:14];
    self.startDateLabDetail.text =endDateStr;
    self.startDateLabDetail.textAlignment=NSTextAlignmentRight;
    [bgViewStart  addSubview: self.startDateLabDetail];
    
    [self.startDateLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-30));
        make.centerY.equalTo(self.startDateLab);
        make.width.equalTo(@(MC_REALVALUE(129)));
    }];
    
    UIImageView *imgVs = [[UIImageView alloc] init];
    imgVs.image = [UIImage imageNamed:@"MC_right_arrow"];
    [bgViewStart addSubview:imgVs];
    [imgVs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabDetail.mas_right).offset(5);
        make.centerY.equalTo(self.startDateLab);
    }];
    
    UIView *bgViewEnd = [[UIView alloc] initWithFrame:CGRectMake(0, 150, G_SCREENWIDTH - 26, 49.5)];
    [bgView addSubview:bgViewEnd];
    self.bgViewEnd = bgViewEnd;
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
         make.left.equalTo(self.titleLabDetail.mas_right).offset(5);
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
- (void)bgViewClick{
    if (self.endDateBlock) {
        self.endDateBlock();
    }
}

- (void)bgViewStartClick{
    if (self.startDateBlock) {
        self.startDateBlock();
    }
}
- (void)bgViewStClick{
    if (self.statusBlock) {
        self.statusBlock();
    }
}

- (void)bgViewTitleClick{
    if (self.lotteryBlock) {
        self.lotteryBlock();
    }
}

- (void)searchBtnClick{
    if (self.startBtnBlock) {
        self.startBtnBlock();
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

