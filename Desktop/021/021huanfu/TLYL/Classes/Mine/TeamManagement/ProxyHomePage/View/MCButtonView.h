//
//  MCButtonView.h
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCButtonView : UIView

@property (nonatomic,strong) void(^datePickerBlock)(NSDate *dateS,NSDate *dateE);
@property (nonatomic,strong) void(^datePickerBlockEnd)(NSDate *dateS,NSDate *dateE);
@property (nonatomic,strong) void(^searchBtnBlock)();
@property (nonatomic,strong) void(^dateBtnBlock)(NSInteger index);
@property (nonatomic,weak) UIButton *endDateBtn;
@property (nonatomic,weak) UIButton *beiginDateBtn;
@property (nonatomic,weak) UIButton *lastBtn;
@end
