//
//  MCSignalPickView.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MCSignalPickViewBlock)(NSString * selectedType);

@interface MCSignalPickView : UIView

@property (nonatomic,strong) NSArray <NSString *>*dataSource;
@property (nonatomic,copy)MCSignalPickViewBlock block;

//快速创建
+(instancetype)InitWithTitle:(NSString *)title;

//弹出
-(void)show;

@end
