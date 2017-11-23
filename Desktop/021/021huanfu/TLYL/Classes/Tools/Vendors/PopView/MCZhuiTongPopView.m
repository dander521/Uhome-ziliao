//
//  MCZhuiTongPopView.m
//  TLYL
//
//  Created by miaocai on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCZhuiTongPopView.h"




@interface MCZhuiTongPopView()
@property (nonatomic,weak) UILabel *dingDanLabel;

@property (nonatomic,weak) UIView *middleView;

@property (nonatomic,weak) UILabel *titleLabel;

@property (nonatomic,weak) UIButton *confirmBtn;

@property (nonatomic,weak) UIButton *cancelBtn;

@property (nonatomic,weak) UIImageView *iconImageV;

@end

@implementation MCZhuiTongPopView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title confirm:(NSString *)confirm cancel:(NSString *)cancel{

    if (self == [super initWithFrame:frame]) {
        [self setUpUIWithTitle:title confirm:confirm cancel:cancel];
    }
    return self;
}
- (void)setUpUIWithTitle:(NSString *)title confirm:(NSString *)confirm cancel:(NSString *)cancel{

    self.frame = CGRectMake(MC_REALVALUE(40), 194 - 64, G_SCREENWIDTH - MC_REALVALUE(80), MC_REALVALUE(220 + 17));
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(17), G_SCREENWIDTH - MC_REALVALUE(80), MC_REALVALUE(220))];
    UIImage *image = [UIImage imageNamed:@"touzhu-beijing"];
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
    bgView.image = newImage;
    [self addSubview:bgView];
    //    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    bgView.userInteractionEnabled = YES;
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((G_SCREENWIDTH - MC_REALVALUE(80) - MC_REALVALUE(180))*0.5, 0, MC_REALVALUE(180), MC_REALVALUE(34))];
    label.backgroundColor = RGB(144, 8, 215);
    label.text = title;
    label.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = MC_REALVALUE(17);
    label.clipsToBounds = YES;
    [self addSubview:label];
    self.titleLabel = label;
    UIView *middleView = [[UIView alloc] init];
    [bgView addSubview:middleView];
    self.middleView = middleView;
    middleView.backgroundColor = RGB(251, 251, 251);
    middleView.layer.borderWidth = 0.5;
    middleView.layer.borderColor = RGB(220, 220, 200).CGColor;
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(MC_REALVALUE(25));
        make.right.equalTo(bgView).offset(MC_REALVALUE(-25));
        make.top.equalTo(bgView).offset(MC_REALVALUE(44));
        make.bottom.equalTo(bgView).offset(MC_REALVALUE(-67));
    }];
    
    
    UIButton *continueBtn = [[UIButton alloc] init];
    [bgView addSubview:continueBtn];
    continueBtn.backgroundColor = RGB(144, 8, 215);
    [continueBtn setTitle:confirm forState:UIControlStateNormal];
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    continueBtn.layer.cornerRadius = 4;
    continueBtn.clipsToBounds = YES;
    [continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MC_REALVALUE(25));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(10));
        make.width.equalTo(@((self.widht - MC_REALVALUE(60))*0.5));
    }];
    self.confirmBtn = continueBtn;
    UIButton *cancelBtn = [[UIButton alloc] init];
    [bgView addSubview:cancelBtn];
    cancelBtn.layer.cornerRadius = 4;
    cancelBtn.clipsToBounds = YES;
    cancelBtn.backgroundColor = RGB(255, 168, 0);
    [cancelBtn setTitle:cancel forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(continueBtn.mas_right).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(10));
        make.width.equalTo(@((self.widht - MC_REALVALUE(60))*0.5));
    }];
    self.cancelBtn = cancelBtn;
    UILabel *dingDanLabel = [[UILabel alloc] init];
    [middleView addSubview:dingDanLabel];
    dingDanLabel.text = @"";
    dingDanLabel.textAlignment = NSTextAlignmentCenter;
    dingDanLabel.textColor = RGB(46, 46, 46);
    dingDanLabel.numberOfLines = 0;
    dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [dingDanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(middleView).offset(MC_REALVALUE(20));
        make.right.equalTo(middleView).offset(-MC_REALVALUE(20));
    }];
    
    self.dingDanLabel = dingDanLabel;
  

}

- (void)continueBtnClick{
    
    if (self.continueBtnBlock) {
        self.continueBtnBlock();
    }
}
- (void)cancelBtnClick{
    if (self.cancelBtnBlock) {
        self.cancelBtnBlock();
    }
}
- (void)show{
    self.hidden = NO;
    self.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)hidden{
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


- (void)setNotiInfo:(NSString *)notiInfo{
    _notiInfo = notiInfo;
    self.dingDanLabel.text = notiInfo;
    if ([notiInfo isEqualToString:@"投注成功"]) {
        self.dingDanLabel.textColor = RGB(35, 198, 46);
        self.dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    } else if([notiInfo isEqualToString:@"投注失败"]){
        self.dingDanLabel.textColor = RGB(249, 84, 83);
        self.dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];

    }else{
        self.dingDanLabel.textColor = RGB(46, 46, 46);
        self.dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];

    }
}
- (void)setIconImage:(UIImage *)iconImage{
     _iconImage = iconImage;
    self.iconImageV.image = iconImage;
    [self.dingDanLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageV.mas_bottom).offset(MC_REALVALUE(5));
        make.centerX.equalTo(self.iconImageV);
    }];
}
- (UIImageView *)iconImageV{
    if (_iconImageV == nil) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0.5 * (G_SCREENWIDTH - MC_REALVALUE(180)), MC_REALVALUE(28), MC_REALVALUE(50), MC_REALVALUE(50))];
        [self.middleView addSubview:imgV];
        _iconImageV = imgV;
          }
    return _iconImageV;
}
@end

