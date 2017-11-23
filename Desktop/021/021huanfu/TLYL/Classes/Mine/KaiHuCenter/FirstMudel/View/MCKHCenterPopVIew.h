//
//  MCKHCenterPopVIew.h
//  TLYL
//
//  Created by miaocai on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRegisterSubbyLinkModel.h"

@interface MCKHCenterPopVIew : UIView

@property (nonatomic,weak) UILabel *dingDanNumberLabel;
@property (nonatomic,weak) UILabel *dingDanDetailLabel;
@property (nonatomic,strong) MCRegisterSubbyLinkModel *dataSource;
@property (nonatomic,strong) void(^continueBtnBlock)();
@property (nonatomic,strong) void(^cancelBtnBlock)();
- (void)show;
- (void)hidden;
@end
