//
//  MCZhuiTongCoverView.h
//  TLYL
//
//  Created by miaocai on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCZhuiTongPopView.h"


@interface MCZhuiTongCoverView:UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title confirm:(NSString *)confirm cancel:(NSString *)cancel;
@property (nonatomic,weak) MCZhuiTongPopView *popView;
@property (nonatomic,strong) NSString *notiInfo;
@property (nonatomic,strong) void (^coverViewBlock)();
@property (nonatomic,strong) void (^cancelBlock)();
@property (nonatomic,weak) UIImage *iconImage;
- (void)show;
- (void)hidden;
@end



