//
//  MCKaiHuThdPopView.h
//  TLYL
//
//  Created by miaocai on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCRegisteredLinksModel.h"
@interface MCKaiHuThdPopView : UIView

@property (nonatomic,strong) MCRegisteredLinksModel *dataSource;

@property (nonatomic,strong) void(^closeBtnBlock)(NSString *);
@property (nonatomic,strong) void(^delBtnBlock)();
@property (nonatomic,strong) void(^hiddenViewBlock)();
- (void)show;
- (void)hidden;

@end
