//
//  MCCZTXView.h
//  TLYL
//
//  Created by miaocai on 2017/6/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCZTXView : UIView
@property (nonatomic,strong) void (^tixianBtnClickBlock)();
@property (nonatomic,strong) void (^chongzhiBtnClickBlock)();
@property (nonatomic,strong) void (^gameBtnClickBlock)();
@property (nonatomic,strong) void (^activityBtnClickBlock)();
@end
