//
//  MCTopUpMineFilterView.h
//  TLYL
//
//  Created by miaocai on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTopUpMineFilterView : UIView
@property (nonatomic,weak) UIButton *startTimeBtn;
@property (nonatomic,weak) UIButton *endTimeBtn;
@property (nonatomic,weak) UILabel *totalLabel;
@property (nonatomic,strong) void (^startDateBlock)();
@property (nonatomic,strong) void (^endDateBlock)();
@property (nonatomic,strong) void (^recordBtnBlock)();
@property (nonatomic,weak) UIButton *recordBtn;
@end
