//
//  MCKHCenterSucView.m
//  TLYL
//
//  Created by miaocai on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKHCenterSucView.h"
#import "MCMMDetailPopView.h"
#import "MCGroupPaymentModel.h"

@interface MCKHCenterSucView()
@property (nonatomic,weak) UILabel *dingDanNumberLabel;
@property (nonatomic,weak) UILabel *dingDanDetailLabel;
@property (nonatomic,weak) UILabel *mimaLabel;
@end

@implementation MCKHCenterSucView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64);
        self.backgroundColor =  [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        [self setUpUI];
    }
    return self;
}



- (void)setUpUI{
    UIView *popView = [[UIView alloc] init];
    popView.frame = CGRectMake(MC_REALVALUE(33), (G_SCREENHEIGHT - MC_REALVALUE(191 + 64 + 49 + 17))*0.5, G_SCREENWIDTH - MC_REALVALUE(66), MC_REALVALUE(191 + 17));
    popView.backgroundColor = [UIColor clearColor];
    [self addSubview:popView];
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(17), popView.widht, popView.heiht - MC_REALVALUE(17))];
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
    [popView addSubview:bgView];
    //    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    bgView.userInteractionEnabled = YES;
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((popView.widht - MC_REALVALUE(180))*0.5, 0, MC_REALVALUE(180), MC_REALVALUE(34))];
    label.backgroundColor = RGB(144, 8, 215);
    label.text = @"注册成功";
    label.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = MC_REALVALUE(17);
    label.clipsToBounds = YES;
    [popView addSubview:label];
    
    
    UIView *middleView = [[UIView alloc] init];
    [bgView addSubview:middleView];
    middleView.backgroundColor = RGB(251, 251, 251);
    middleView.layer.borderWidth = 0.5;
    middleView.layer.borderColor = RGB(220, 220, 200).CGColor;
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(popView).offset(MC_REALVALUE(25));
        make.right.equalTo(popView).offset(MC_REALVALUE(-25));
        make.top.equalTo(popView).offset(MC_REALVALUE(36));
        make.bottom.equalTo(popView).offset(MC_REALVALUE(-49));
    }];
    
    
    UIButton *continueBtn = [[UIButton alloc] init];
    [bgView addSubview:continueBtn];
    continueBtn.backgroundColor = RGB(144, 8, 215);
    [continueBtn setTitle:@"复制并关闭" forState:UIControlStateNormal];
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    continueBtn.layer.cornerRadius = 4;
    continueBtn.clipsToBounds = YES;
    [continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(10));
        make.width.equalTo(@(MC_REALVALUE(126)));
    }];
    
    
    UILabel *dingDanLabel = [[UILabel alloc] init];
    [middleView addSubview:dingDanLabel];
    self.dingDanNumberLabel = dingDanLabel;
    dingDanLabel.textColor = RGB(102, 102, 102);
    dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    UILabel *dingDanDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:dingDanDetailLabel];
    dingDanDetailLabel.textColor = RGB(102, 102, 102);
    dingDanDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.dingDanDetailLabel = dingDanDetailLabel;
    
    UILabel *mimaLabel = [[UILabel alloc] init];
    [middleView addSubview:mimaLabel];
    mimaLabel.textColor = RGB(102, 102, 102);
    mimaLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.mimaLabel = mimaLabel;
    
    [self.dingDanNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView).offset(MC_REALVALUE(33));
        make.centerX.equalTo(middleView);
        
    }];
    [self.dingDanDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(middleView);
        make.top.equalTo(self.dingDanNumberLabel.mas_bottom).offset(MC_REALVALUE(8));
    }];
    
    [mimaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(middleView);
        make.top.equalTo(self.dingDanDetailLabel.mas_bottom).offset(MC_REALVALUE(8));
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidden];
}

- (void)continueBtnClick{
    
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
- (void)setDataSource:(MCFirstKaiHuModel *)dataSource{
    _dataSource = dataSource;
    NSString *nameStr =[NSString stringWithFormat:@"用户名：%@",dataSource.subUserName];
    NSRange redRange = NSMakeRange(0, [nameStr rangeOfString:@"："].location);
   NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:nameStr];
    [att addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(12)],NSForegroundColorAttributeName:RGB(46, 46, 46)} range:redRange];
    self.dingDanNumberLabel.attributedText = att;
    NSString *fandianStr =[NSString stringWithFormat:@"返点：%d",dataSource.Rebate];
    NSRange fRange = NSMakeRange(0, [fandianStr rangeOfString:@"："].location);
    NSMutableAttributedString *attf = [[NSMutableAttributedString alloc] initWithString:fandianStr];
    [attf addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(12)],NSForegroundColorAttributeName:RGB(46, 46, 46)} range:fRange];
    self.dingDanDetailLabel.attributedText = attf;
    NSString *mimaStr =[NSString stringWithFormat:@"初始密码：%@",dataSource.Password];
    NSRange mRange = NSMakeRange(0, [mimaStr rangeOfString:@"："].location);
    NSMutableAttributedString *attm = [[NSMutableAttributedString alloc] initWithString:mimaStr];
    [att addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(12)],NSForegroundColorAttributeName:RGB(46, 46, 46)} range:mRange];
    self.mimaLabel.attributedText = attm;

}
@end
