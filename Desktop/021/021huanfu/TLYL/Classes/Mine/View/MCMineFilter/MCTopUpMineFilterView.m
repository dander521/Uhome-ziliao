//
//  MCTopUpMineFilterView.m
//  TLYL
//
//  Created by miaocai on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTopUpMineFilterView.h"
#import "MCMineFilterButton.h"


@interface MCTopUpMineFilterView ()



@property (nonatomic,weak) UIView *lineView1;
@property (nonatomic,weak) UIView *lineView2;
@property (nonatomic,weak) UIView *lineView3;

@end

@implementation MCTopUpMineFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    UIButton *recordBtn = [[UIButton alloc] init];
    [self addSubview:recordBtn];
    self.recordBtn = recordBtn;
    [recordBtn setTitle:@"当前记录" forState:UIControlStateNormal];
    [recordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    recordBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(18)];
    [recordBtn setImage:[UIImage imageNamed:@"Record_More_drop-down-1"] forState:UIControlStateNormal];
    MCMineFilterButton *startTimeBtn= [[MCMineFilterButton alloc] init];
    [self addSubview:startTimeBtn];
    self.startTimeBtn = startTimeBtn;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dataFormatter stringFromDate:[NSDate date]];

    [startTimeBtn setTitle:currentDateStr forState:UIControlStateNormal];
    [startTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    startTimeBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [startTimeBtn setImage:[UIImage imageNamed:@"Record_More_time-1"] forState:UIControlStateNormal];
    [startTimeBtn addTarget:self action:@selector(startTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    MCMineFilterButton *endTimeBtn = [[MCMineFilterButton alloc] init];
    [self addSubview:endTimeBtn];
    self.endTimeBtn = endTimeBtn;
    [endTimeBtn setTitle:currentDateStr forState:UIControlStateNormal];
    [endTimeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [endTimeBtn setImage:[UIImage imageNamed:@"Record_More_time-1"] forState:UIControlStateNormal];
    [endTimeBtn addTarget:self action:@selector(endTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIView *lineView1 = [[UIView alloc] init];
    [self addSubview:lineView1];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#b6b6b6"];
    self.lineView1 = lineView1;
    UIView *lineView2 = [[UIView alloc] init];
    [self addSubview:lineView2];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#b6b6b6"];
    self.lineView2 = lineView2;
    UIView *lineView3 = [[UIView alloc] init];
    [self addSubview:lineView3];
    self.lineView3 = lineView3;
    lineView3.backgroundColor = [UIColor colorWithHexString:@"#b6b6b6"];
    UILabel *totalLabel = [[UILabel alloc] init];
    [self addSubview:totalLabel];
    self.totalLabel = totalLabel;
    self.totalLabel.text = @"记录总数：0条";
    self.totalLabel.font = [UIFont systemFontOfSize:12];
    self.totalLabel.textAlignment = NSTextAlignmentCenter;
    self.totalLabel.textColor = [UIColor darkGrayColor];
    self.recordBtn.backgroundColor = [UIColor colorWithHexString:@"#eff6fd"];
    self.startTimeBtn.backgroundColor = [UIColor colorWithHexString:@"#eff6fd"];
    self.endTimeBtn.backgroundColor = [UIColor colorWithHexString:@"#eff6fd"];
    self.totalLabel.backgroundColor = [UIColor colorWithHexString:@"#eff6fd"];
    recordBtn.backgroundColor = [UIColor whiteColor];
    [recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchDown];
    startTimeBtn.backgroundColor = [UIColor whiteColor];
    endTimeBtn.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.equalTo(@(G_SCREENWIDTH/3));
        make.height.equalTo(@(44));
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recordBtn.mas_right);
        make.top.equalTo(self).offset(2);
        make.height.equalTo(@(40));
        make.width.equalTo(@(1));
    }];
    [self.startTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.equalTo(@(G_SCREENWIDTH/3-1));
        make.left.equalTo(self.lineView1.mas_right);
        make.height.equalTo(@(44));
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTimeBtn.mas_right);
        make.top.equalTo(self).offset(2);
        make.width.equalTo(@(1));
        make.height.equalTo(@(40));
    }];
    [self.endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.equalTo(@(G_SCREENWIDTH/3 -1));
        make.right.equalTo(self);
        make.height.equalTo(@(44));
    }];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2);
        make.top.equalTo(self.startTimeBtn.mas_bottom);
        make.right.equalTo(self).offset(-2);
        make.height.equalTo(@(1));
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(MC_REALVALUE(20)));
    }];
}

- (void)recordBtnClick{
    
    if (self.recordBtnBlock) {
        self.recordBtnBlock();
    }
    
}
- (void)startTimeBtnClick{
    if (self.startDateBlock) {
        self.startDateBlock();
    }
}
- (void)endTimeBtnClick{
    if (self.endDateBlock) {
        self.endDateBlock();
    }
}


@end
