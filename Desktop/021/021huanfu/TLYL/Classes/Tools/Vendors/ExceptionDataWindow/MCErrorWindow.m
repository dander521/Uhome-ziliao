//
//  MCErrorWindow.m
//  TLYL
//
//  Created by miaocai on 2017/8/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCErrorWindow.h"
#import "UIImage+Extension.h"

@interface MCErrorWindow()
@property (nonatomic,strong)MCErrorWindow *alertWindow;
@end

@implementation MCErrorWindow


- (instancetype)alertInstanceWithFrame:(CGRect)frame{
    //    static dispatch_once_t onceToken;
    //    dispatch_once(&onceToken, ^{
    _alertWindow = [[MCErrorWindow alloc] initWithFrame:frame];
    _alertWindow.userInteractionEnabled=YES;
    _alertWindow.backgroundColor = [UIColor whiteColor];
    [_alertWindow setUpUI];
    //    });
    return _alertWindow;
}

- (void)btnClick{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCErrorWindow_Retry" object:nil];
}
- (void)setUpUI{

    _alertWindow.backgroundColor = [UIColor whiteColor];
    UIImageView *imgV = [[UIImageView alloc] init];
    [self addSubview:imgV];
    imgV.image = [UIImage imageNamed:@"error_network"];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(MC_REALVALUE(89));
        make.height.equalTo(@(MC_REALVALUE(150)));
        make.width.equalTo(@(MC_REALVALUE(250)));
        make.centerX.equalTo(self);
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(imgV.mas_bottom).offset(MC_REALVALUE(65));
        make.height.equalTo(@(MC_REALVALUE(50)));
    }];
    [btn setTitle:@"重试" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage createImageWithColor:RGB(144, 8, 215)] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 4.0f;
    btn.clipsToBounds = YES;
}


@end
