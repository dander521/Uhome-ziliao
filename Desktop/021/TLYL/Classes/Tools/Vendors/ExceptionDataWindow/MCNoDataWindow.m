//
//  MCNoDataWindow.m
//  TLYL
//
//  Created by miaocai on 2017/8/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNoDataWindow.h"
@interface MCNoDataWindow()

@property(nonatomic,strong)MCNoDataWindow *alertWindow;
@end

@implementation MCNoDataWindow

- (instancetype)alertInstanceWithFrame:(CGRect)frame{
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
    _alertWindow = [[MCNoDataWindow alloc] initWithFrame:frame];
    _alertWindow.userInteractionEnabled=YES;
    _alertWindow.backgroundColor = [UIColor whiteColor];
    [_alertWindow setUpUI];
//    });
    return _alertWindow;
}


//- (void)btnClick{
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"MCNoDataWindow_Retry" object:nil];
//}
- (void)layoutSubviews{
    [super layoutSubviews];
 
}
- (void)setUpUI{
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [self addSubview:imgV];
    imgV.image = [UIImage imageNamed:@"noData_network"];
    imgV.frame = CGRectMake((G_SCREENWIDTH - MC_REALVALUE(250)) * 0.5, (self.heiht - MC_REALVALUE(150)) * 0.5, MC_REALVALUE(250), MC_REALVALUE(150));

//    UIButton *btn = [[UIButton alloc] init];
//    [self addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(20);
//        make.right.equalTo(self.mas_right).offset(-20);
//        make.top.equalTo(imgV.mas_bottom).offset(MC_REALVALUE(65));
//        make.height.equalTo(@(MC_REALVALUE(50)));
//    }];
//    [btn setTitle:@"重试" forState:UIControlStateNormal];
//    btn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    btn.layer.cornerRadius = 4.0f;
//    btn.clipsToBounds = YES;
}

@end
