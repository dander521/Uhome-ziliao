//
//  MCChartView.h
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCChartView : UIView

@property (nonatomic,strong) id dataSource;
@property (nonatomic,strong) void(^dateTypeBtnBlock)(NSInteger index);
@property (nonatomic,strong) void(^chartTypeBtnBlock)(NSInteger index);
@end
