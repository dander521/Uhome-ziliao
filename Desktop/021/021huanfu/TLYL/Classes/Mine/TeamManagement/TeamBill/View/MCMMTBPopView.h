//
//  MCMMTBPopView.h
//  TLYL
//
//  Created by miaocai on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNaviPopView.h"

@interface MCMMTBPopView : UIView

// 会员名称
@property (nonatomic,strong)UILabel *titleLab;

//startDateLab 开始时间
@property (nonatomic,strong)UILabel *startDateLab;
//startDateLab 开始时间value
@property (nonatomic,strong)UILabel *startDateLabDetail;
//endDateLab 结束时间
@property (nonatomic,strong)UILabel *endDateLab;
//endDateLab 结束时间 value
@property (nonatomic,strong)UILabel *endDateLabDetail;

@property (nonatomic,strong)UILabel *stLabel;
// 中奖状态
@property (nonatomic,strong)UILabel *stValueLabel;
//statusLab 彩种
@property (nonatomic,strong)UILabel *statusLab;
//statusLabDetail 彩种value
@property (nonatomic,strong)UILabel *statusLabDetail;

// baseVIew
@property (nonatomic,weak) UIView *bgView;

@property (nonatomic,strong) NSArray *dataSourceArray;
//开始日期
@property (nonatomic,strong) void (^startDateBlock)();
//结束日期
@property (nonatomic,strong) void (^endDateBlock)();
//状态//记录选择
@property (nonatomic,strong) void (^lotteryBlock)();
// 彩种  帐变类型
@property (nonatomic,strong) void (^statusBlock)();

// 搜索
@property (nonatomic,strong) void (^searchBtnBlock)(NSString *str);

- (void)showPopView;
- (void)hidePopView;
@end
