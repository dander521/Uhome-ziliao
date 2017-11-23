//
//  MCMMCKaiJiangView.h
//  TLYL
//
//  Created by MC on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StopKaiJiang)(void);
@interface MCMMCKaiJiangView : UIView

@property (nonatomic,strong)NSString * dataSource;

@property (nonatomic,copy)StopKaiJiang block;

@property (nonatomic,weak)UILabel  * lab_title;

@end
