//
//  MCMMCSuccessView.h
//  TLYL
//
//  Created by MC on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Success_BackToTZBlock)(void);
@interface MCMMCSuccessView : UIView

@property (nonatomic,strong)NSString * dataSource;

@property (nonatomic,copy)Success_BackToTZBlock block;

-(void)startTimer;
-(void)stopTimer;
@property (nonatomic,strong)UILabel * lab_title;

@end
