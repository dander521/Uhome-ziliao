//
//  MCZhuiTongCoverView.m
//  TLYL
//
//  Created by miaocai on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCZhuiTongCoverView.h"

@implementation MCZhuiTongCoverView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title confirm:(NSString *)confirm cancel:(NSString *)cancel{
    
    if (self == [super initWithFrame:frame]) {
        [self setUpUIWithTitle:title confirm:confirm cancel:cancel];
    }
    return self;
}
- (void)show{
    self.hidden = NO;
    [self.popView show];
}

- (void)hidden{
    self.hidden = YES;
    [self.popView hidden];
}

- (void)setUpUIWithTitle:(NSString *)title confirm:(NSString *)confirm cancel:(NSString *)cancel{
    MCZhuiTongPopView *popView = [[MCZhuiTongPopView alloc] initWithFrame:CGRectMake(MC_REALVALUE(33), (G_SCREENHEIGHT - 64 - G_SCREENWIDTH + MC_REALVALUE(66)) * 0.5, G_SCREENWIDTH - MC_REALVALUE(66), MC_REALVALUE(300)) title:title confirm:confirm cancel:cancel];
    self.popView = popView;
    __weak typeof(self) weakSelf = self;
    popView.cancelBtnBlock = ^{
        [weakSelf hidden];
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    };
    popView.continueBtnBlock = ^{
        [weakSelf hidden];
        if (self.coverViewBlock) {
            self.coverViewBlock();
        }
    };
  
    [self addSubview:popView];
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [self hidden];
//}
- (void)setNotiInfo:(NSString *)notiInfo{
    _notiInfo = notiInfo;
    self.popView.notiInfo = notiInfo;
}

- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    self.popView.iconImage = iconImage;
}
@end
