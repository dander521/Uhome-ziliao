//
//  MCGameRecordMineFilterView.h
//  TLYL
//
//  Created by miaocai on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCGameRecordMineFilterView : UIView
/**全部等按钮被点击的回掉*/
@property (nonatomic,strong) void (^gameRecFilterBtnClickBlock)(int index);
/**滑动改变按钮状态*/
- (void)changeBtnStatus:(int)index;
@property (nonatomic,weak) UILabel *totalLabel;
@property (nonatomic,strong) void (^recordBtnBlock)();
@property (nonatomic,strong) void (^startDateBlock)();
@property (nonatomic,strong) void (^endDateBlock)();
@property (nonatomic,weak) UIButton *startTimeBtn;
@property (nonatomic,weak) UIButton *endTimeBtn;
@property (nonatomic,weak) UIButton *recordBtn;

@end
