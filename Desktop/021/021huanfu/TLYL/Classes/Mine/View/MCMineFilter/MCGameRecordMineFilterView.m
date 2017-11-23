//
//  MCGameRecordMineFilterView.m
//  TLYL
//
//  Created by miaocai on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGameRecordMineFilterView.h"
#import "MCMineFilterButton.h"

@interface MCGameRecordMineFilterView ()



@property (nonatomic,weak) UIView *lineView1;
@property (nonatomic,weak) UIView *lineView2;
@property (nonatomic,weak) UIView *lineView3;

@property (nonatomic,weak) UIView *lineView;
@property (nonatomic,weak) UIView *topView;

@end

@implementation MCGameRecordMineFilterView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    
//    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 44)];
//    [self addSubview:topView];
//    self.topView = topView;
//    topView.backgroundColor = [UIColor whiteColor];
//    NSArray *titleArray = @[@"全部",@"待开奖",@"已中奖",@"未中奖"];
//    
//    for (NSInteger i = 0; i<titleArray.count; i++) {
//        UIButton *btn = [[UIButton alloc] init];
//        [topView addSubview:btn];
//        btn.frame = CGRectMake(i * 0.25 * G_SCREENWIDTH, 0, 0.25 * G_SCREENWIDTH, 42);
//        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"#b1b1b1"] forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateSelected];
//        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
//        btn.tag = i + 1000;
//       
//        
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
//        if (btn.tag == 1000) {
//            [self btnClick:btn];
//        }else{
//            btn.selected = NO;
//        }
//    }
//    UIView *lineView0 = [[UIView alloc] initWithFrame:CGRectMake(0, 43, G_SCREENWIDTH, 1)];
//    lineView0.backgroundColor = [UIColor colorWithHexString:@"#b1b1b1"];
//    [topView addSubview:lineView0];
//    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, 60, 2)];
//    [topView addSubview:lineView];
//    lineView.backgroundColor = MC_SKYBLUE_COLOR;
//    self.lineView = lineView;
    UIButton *recordBtn = [[UIButton alloc] init];
    [self addSubview:recordBtn];
    self.recordBtn = recordBtn;
    [recordBtn setImage:[UIImage imageNamed:@"Record_More_drop-down-1"] forState:UIControlStateNormal];
    [recordBtn setTitle:@"当前记录" forState:UIControlStateNormal];
    [recordBtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    recordBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(15)];
    [recordBtn setBackgroundColor:[UIColor whiteColor]];
    [recordBtn addTarget:self action:@selector(recordBtnClick) forControlEvents:UIControlEventTouchDown];
    MCMineFilterButton *startTimeBtn= [[MCMineFilterButton alloc] init];
    [self addSubview:startTimeBtn];
    self.startTimeBtn = startTimeBtn;
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *currentDateStr = [dataFormatter stringFromDate:[NSDate date]];
    [startTimeBtn setTitle:currentDateStr forState:UIControlStateNormal];
    [startTimeBtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    startTimeBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [startTimeBtn setImage:[UIImage imageNamed:@"Record_More_time-1"] forState:UIControlStateNormal];
    [startTimeBtn addTarget:self action:@selector(startTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [startTimeBtn setBackgroundColor:[UIColor whiteColor]];
    MCMineFilterButton *endTimeBtn = [[MCMineFilterButton alloc] init];
    [self addSubview:endTimeBtn];
    self.endTimeBtn = endTimeBtn;
    [endTimeBtn setTitle:currentDateStr forState:UIControlStateNormal];
    [endTimeBtn setTitleColor:[UIColor colorWithHexString:@"#444444"] forState:UIControlStateNormal];
    [endTimeBtn addTarget:self action:@selector(endTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    endTimeBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [endTimeBtn setBackgroundColor:[UIColor whiteColor]];
    [endTimeBtn setImage:[UIImage imageNamed:@"Record_More_time-1"] forState:UIControlStateNormal];
    UIView *lineView1 = [[UIView alloc] init];
    [self addSubview:lineView1];
    lineView1.backgroundColor = [UIColor darkGrayColor];
    self.lineView1 = lineView1;
    UIView *lineView2 = [[UIView alloc] init];
    [self addSubview:lineView2];
    lineView2.backgroundColor = [UIColor darkGrayColor];
    self.lineView2 = lineView2;
    UIView *lineView3 = [[UIView alloc] init];
    [self addSubview:lineView3];
    self.lineView3 = lineView3;
    lineView3.backgroundColor = MC_SEPAETOR_COLOR;
    UILabel *totalLabel = [[UILabel alloc] init];
    [self addSubview:totalLabel];
    self.totalLabel = totalLabel;
    self.totalLabel.text = @"记录总数：0条";
    self.totalLabel.font = [UIFont systemFontOfSize:12];
    self.totalLabel.textAlignment = NSTextAlignmentCenter;
    self.totalLabel.textColor = [UIColor colorWithHexString:@"#b1b1b1"];
    self.totalLabel.backgroundColor = RGB(237, 246, 252);
}

- (void)layoutSubviews{
 
    [super layoutSubviews];
    
    [self.recordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@(G_SCREENWIDTH/3));
        make.height.equalTo(@(44));
        make.left.equalTo(self);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recordBtn.mas_right);
        make.top.equalTo(self).offset(2);
        make.height.equalTo(@(40));
        make.width.equalTo(@(0.5));
    }];
    [self.startTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@(G_SCREENWIDTH/3-0.5));
        make.left.equalTo(self.lineView1.mas_right);
        make.height.equalTo(@(44));
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startTimeBtn.mas_right);
        make.top.equalTo(self).offset(2);
        make.width.equalTo(@(0.5));
        make.height.equalTo(@(40));
    }];
    [self.endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.width.equalTo(@(G_SCREENWIDTH/3 -0.5));
        make.right.equalTo(self);
        make.height.equalTo(@(44));
    }];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2);
        make.top.equalTo(self.startTimeBtn.mas_bottom);
        make.right.equalTo(self).offset(-2);
        make.height.equalTo(@(0.5));
    }];
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(MC_REALVALUE(20)));
    }];
    
     
}
- (void)changeBtnStatus:(int)index{

    for (UIView *view in self.topView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn1 = (UIButton *)view;
            if (btn1.tag - 1000 == index) {
                btn1.selected = YES;
                [UIView animateWithDuration:0.25 animations:^{
                    self.lineView.size = CGSizeMake(60, 2);
                    self.lineView.center = CGPointMake(btn1.centerX, 43);
                }];
            } else {
                btn1.selected = NO;
            }
            
        }
    }
 

}
- (void)btnClick:(UIButton *)btn{
     btn.selected = !btn.selected;
    for (UIView *view in self.topView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn1 = (UIButton *)view;
            if (btn == btn1) {
                btn.selected = YES;
            }else{
                btn1.selected = NO;
            }
        }
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.size = CGSizeMake(60, 2);
        self.lineView.center = CGPointMake(btn.centerX, 43);
    }];
    int index = (int)btn.tag - 1000;
    if (self.gameRecFilterBtnClickBlock) {
        self.gameRecFilterBtnClickBlock(index);
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

- (void)recordBtnClick{
    if (self.recordBtnBlock) {
        self.recordBtnBlock();
    }
}
@end
