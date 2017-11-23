
//
//  MCButtonView.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCButtonView.h"
#import "UIImage+Extension.h"


@interface MCButtonView()

@property (nonatomic,strong) NSDate *minDate;

@property (nonatomic,strong) NSDate *maxDate;



@end

@implementation MCButtonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{

    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    [dataFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateStrE = [dataFormatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-24 * 60 * 60]];
//    NSString *dateStrS = [dataFormatter stringFromDate:[NSDate date]];
    NSArray *titleArr = @[@"一周",@"半月",@"一月",dateStrE,dateStrE];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    NSDate *senddate=[NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: senddate];
    NSDate *localDate = [senddate dateByAddingTimeInterval: interval];
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:localDate];
    NSArray *arrMouth = nil;
    if ([self bissextile:(int)[comps year]]) {
        arrMouth = @[@31,@29,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
    } else {
        arrMouth = @[@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
    }
    NSNumber * mo1 = arrMouth[comps.month - 3];
    NSNumber * mo2 = arrMouth[comps.month - 2];
    NSNumber * mo3 = arrMouth[comps.month - 1];
    
    self.minDate = [NSDate dateWithTimeIntervalSinceNow:- ([mo1 intValue] + [mo2 intValue] + [mo3 intValue]) * 3600 * 24];
    self.maxDate = [NSDate dateWithTimeIntervalSinceNow:-1 * 3600 * 24];

    for (NSInteger i = 0; i<titleArr.count; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        [self addSubview:btn];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        btn.tag = i+101;
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        if (i<=2) {
            if (i==0) {
                btn.selected = YES;
                self.lastBtn = btn;
            }
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage createImageWithColor:RGB(255, 168, 0)] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage createImageWithColor:RGB(187, 187, 187)] forState:UIControlStateNormal];
            btn.frame = CGRectMake(i*MC_REALVALUE(38) + MC_REALVALUE(8) *i, MC_REALVALUE(12), MC_REALVALUE(38), MC_REALVALUE(26));
            [btn addTarget:self action:@selector(btnDateClick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [btn setTitleColor:RGB(144, 8, 215) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            if (i==3) {
               btn.frame = CGRectMake(self.widht - MC_REALVALUE(73)*2 - 2 - MC_REALVALUE(30) - 17, MC_REALVALUE(12), MC_REALVALUE(73), MC_REALVALUE(26));
                [btn addTarget:self action:@selector(btnDatePicker) forControlEvents:UIControlEventTouchUpInside];
                self.beiginDateBtn = btn;
                
            
            } else {
               btn.frame = CGRectMake(self.widht - MC_REALVALUE(73) - MC_REALVALUE(30), MC_REALVALUE(12), MC_REALVALUE(73), MC_REALVALUE(26));
                [btn addTarget:self action:@selector(btnDatePickerEnd) forControlEvents:UIControlEventTouchUpInside];
                self.endDateBtn = btn;
            }
            
        }
        
    }
    UIView *line = [[UIView alloc] init];
    [self addSubview:line];
    line.backgroundColor = RGB(144, 8, 215);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beiginDateBtn.mas_right).offset(MC_REALVALUE(1));
        make.height.equalTo(@(0.75));
        make.centerY.equalTo(self);
        make.right.equalTo(self.endDateBtn.mas_left).offset(MC_REALVALUE(-1));
    }];
    UIButton *searchBtn = [[UIButton alloc] init];
    [self addSubview:searchBtn];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"dlgl-ss"] forState:UIControlStateNormal];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(MC_REALVALUE(25)));
        make.right.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
}

- (BOOL)bissextile:(int)year {
    
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}
- (void)btnDateClick:(UIButton *)btn{
    self.lastBtn.selected = NO;
    btn.selected = !btn.selected;
    self.lastBtn = btn;
    if (self.dateBtnBlock) {
        self.dateBtnBlock(btn.tag);
    }
}
- (void)searchBtnClick{
    self.lastBtn.selected = NO;
    if (self.searchBtnBlock) {
        self.searchBtnBlock();
    }
}
- (void)btnDatePicker{
    if (self.datePickerBlock) {
        self.datePickerBlock(self.minDate,self.maxDate);
    }
}
- (void)btnDatePickerEnd{
    if (self.datePickerBlockEnd) {
        self.datePickerBlockEnd(self.minDate,self.maxDate);
    }
}
@end
