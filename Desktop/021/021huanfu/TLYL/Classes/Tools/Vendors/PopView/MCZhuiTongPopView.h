//
//  MCZhuiTongPopView.h
//  TLYL
//
//  Created by miaocai on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCZhuiTongPopView : UIView

@property (nonatomic,strong) void(^cancelBtnBlock)();
@property (nonatomic,strong) void(^continueBtnBlock)();
@property (nonatomic,strong) NSString *notiInfo;
@property (nonatomic,weak) UIImage *iconImage;
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title confirm:(NSString *)confirm cancel:(NSString *)cancel;
- (void)show;

- (void)hidden;

@end
