//
//  MCNaviPopView.h
//  TLYL
//
//  Created by miaocai on 2017/7/28.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHTNaviPopCELL 45
#define WIDTHNaviPopCELL  90

@interface MCNaviPopView : UIView
@property (nonatomic,weak) UIImageView *imgV;
// 注册时间 imgv
@property (nonatomic,weak) UIImageView *imgVst;
// 注册时间 bg
@property (nonatomic,weak) UIView *bgViewSt;
@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)UILabel *titleLabDetail;
@property (nonatomic,weak) UIView *bgViewStart;
@property (nonatomic,weak) UIView *bgViewEnd;
@property (nonatomic,strong)UILabel *startDateLab;
@property (nonatomic,strong)UILabel *startDateLabDetail;
@property (nonatomic,strong)UILabel *endDateLab;
@property (nonatomic,strong)UILabel *endDateLabDetail;
@property (nonatomic,strong)UIView *line3;
@property (nonatomic,strong)UILabel *statusLab;
@property (nonatomic,strong)UILabel *statusLabDetail;
@property (nonatomic,strong)UIView *bgViewTitle;
@property (nonatomic,strong)UIView *line;
@property (nonatomic,weak) UIView *bgView;
@property (nonatomic,strong) NSArray *dataSourceArray;
@property (nonatomic,strong) void (^startDateBlock)();
@property (nonatomic,strong) void (^endDateBlock)();
@property (nonatomic,strong) void (^lotteryBlock)();
@property (nonatomic,strong) void (^statusBlock)();
@property (nonatomic,strong) void (^recordSelectedBlock)(NSInteger);
@property (nonatomic,strong) void (^startBtnBlock)();

- (void)showPopView;
- (void)hidePopView;

@end
