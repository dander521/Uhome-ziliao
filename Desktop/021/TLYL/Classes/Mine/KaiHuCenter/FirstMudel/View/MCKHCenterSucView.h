//
//  MCKHCenterSucView.h
//  TLYL
//
//  Created by miaocai on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCFirstKaiHuModel.h"
@interface MCKHCenterSucView : UIView
@property (nonatomic,strong) MCFirstKaiHuModel *dataSource;
@property (nonatomic,strong) void(^cancelBtnBlock)();
@property (nonatomic,strong) void(^continueBtnBlock)();
- (void)show;
- (void)hidden;
@end
