//
//  MCMMCFaildView.h
//  TLYL
//
//  Created by MC on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Faild_BackToTZBlock)(void);
@interface MCMMCFaildView : UIView

@property (nonatomic,strong)NSString * dataSource;

@property (nonatomic,copy)Faild_BackToTZBlock block;

-(void)startTimer;
-(void)stopTimer;

@end
