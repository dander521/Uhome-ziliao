//
//  MCHomePageInfoCycleView.h
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCSystemNoticeListModel.h"
@interface MCHomePageInfoCycleView : UIView

@property (nonatomic,strong) void (^systemNoticeClickBlock)(MCSystemNoticeListModel *model);

@end
