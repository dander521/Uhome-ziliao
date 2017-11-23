//
//  MCPaySelectedLotteryPickView.h
//  TLYL
//
//  Created by MC on 2017/10/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCPaySelectedLotteryPickView : UIView

/** 问题库 */
@property (nonatomic,strong) NSArray *dataSource;

//快速创建
+(instancetype)pickerView;

//弹出
-(void)show;


@end
























