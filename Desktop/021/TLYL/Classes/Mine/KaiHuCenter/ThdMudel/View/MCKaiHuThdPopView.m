//
//  MCKaiHuThdPopView.m
//  TLYL
//
//  Created by miaocai on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//



#import "MCKaiHuThdPopView.h"


@interface MCKaiHuThdPopView()

@property (nonatomic,weak) UILabel *dingDanUrlLabel;
@property (nonatomic,weak) UILabel *userTypeDetailLabel;
@property (nonatomic,weak) UILabel *fandianDetailLabel;
@property (nonatomic,weak) UILabel *renshuDetailLabel;
@property (nonatomic,weak) UILabel *dateDetailLabel;
@property (nonatomic,weak) UIButton *closeBtn;

@end

@implementation MCKaiHuThdPopView

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
    popView.frame = CGRectMake(MC_REALVALUE(33), (G_SCREENHEIGHT - MC_REALVALUE(203 + 17 + 64 + 49))*0.5, G_SCREENWIDTH - MC_REALVALUE(66), MC_REALVALUE(203 + 17));
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
    label.text = @"代理链接";
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
        make.top.equalTo(popView).offset(MC_REALVALUE(44));
        make.bottom.equalTo(popView).offset(MC_REALVALUE(-67));
    }];
    
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [bgView addSubview:closeBtn];
    closeBtn.backgroundColor = RGB(144, 8, 215);
    [closeBtn setTitle:@"关闭链接" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    closeBtn.layer.cornerRadius = 4;
    closeBtn.clipsToBounds = YES;
    [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middleView);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(8));
        make.width.equalTo(@(MC_REALVALUE(126)));
    }];
    self.closeBtn = closeBtn;
    UIButton *delBtn = [[UIButton alloc] init];
    [bgView addSubview:delBtn];
    delBtn.backgroundColor = [UIColor orangeColor];
    [delBtn setTitle:@"删除链接" forState:UIControlStateNormal];
    [delBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    delBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    delBtn.layer.cornerRadius = 4;
    delBtn.clipsToBounds = YES;
    [delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(middleView);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(8));
        make.width.equalTo(@(MC_REALVALUE(126)));
    }];
    
    
    UILabel *dingDanUrlLabel = [[UILabel alloc] init];
    dingDanUrlLabel.text = @"加载中";
    [middleView addSubview:dingDanUrlLabel];
    self.dingDanUrlLabel = dingDanUrlLabel;
    dingDanUrlLabel.textColor = RGB(144, 8, 215);
    dingDanUrlLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [dingDanUrlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(middleView).offset(MC_REALVALUE(20));
    }];
    
    UILabel *userTypeLabel = [[UILabel alloc] init];
    [middleView addSubview:userTypeLabel];
    userTypeLabel.textColor = RGB(46, 46, 46);
    userTypeLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
      userTypeLabel.text = @"用户类型：";
    [userTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanUrlLabel);
        make.top.equalTo(dingDanUrlLabel.mas_bottom).offset(MC_REALVALUE(5));
    }];
    UILabel *userTypeDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:userTypeDetailLabel];
    self.userTypeDetailLabel = userTypeDetailLabel;
    userTypeDetailLabel.textColor = RGB(102, 102, 102);
    userTypeDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [userTypeDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userTypeLabel);
        make.left.equalTo(userTypeLabel.mas_right);
    }];
    
    UILabel *fandianLabel = [[UILabel alloc] init];
    [middleView addSubview:fandianLabel];
    fandianLabel.textColor = RGB(46, 46, 46);
    fandianLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    fandianLabel.text = @"彩票返点：";
    
    UILabel *fandianDetailLabel = [[UILabel alloc] init];
    fandianDetailLabel.text = @"加载中";
    [middleView addSubview:fandianDetailLabel];
    fandianDetailLabel.textColor = RGB(102, 102, 102);
    fandianDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.fandianDetailLabel = fandianDetailLabel;
    fandianDetailLabel.textAlignment = NSTextAlignmentLeft;
    [fandianDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userTypeLabel);
        make.right.equalTo(middleView).offset(MC_REALVALUE(-18));
    }];
    [fandianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userTypeLabel);
        make.right.equalTo(fandianDetailLabel.mas_left);
    }];
    
    UILabel *renshuLabel = [[UILabel alloc] init];
    [middleView addSubview:renshuLabel];
    renshuLabel.textColor = RGB(46, 46, 46);
    renshuLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    renshuLabel.text = @"注册人数：";
    [renshuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanUrlLabel);
        make.top.equalTo(fandianDetailLabel.mas_bottom).offset(MC_REALVALUE(5));
    }];
    UILabel *renshuDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:renshuDetailLabel];
    renshuDetailLabel.textColor = RGB(102, 102, 102);
    renshuDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.renshuDetailLabel = renshuDetailLabel;
    
    [renshuDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(renshuLabel.mas_right);
        make.top.equalTo(renshuLabel);
    }];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    [middleView addSubview:dateLabel];
    dateLabel.textColor = RGB(46, 46, 46);
    dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    dateLabel.text = @"生成时间：";
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanUrlLabel);
        make.top.equalTo(renshuDetailLabel.mas_bottom).offset(MC_REALVALUE(5));
    }];
    UILabel *dateDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:dateDetailLabel];
    dateDetailLabel.textColor = RGB(102, 102, 102);
    dateDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.dateDetailLabel = dateDetailLabel;
    [dateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLabel.mas_right);
        make.top.equalTo(dateLabel);
    }];
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hidden];
    if (self.hiddenViewBlock) {
        self.hiddenViewBlock();
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
- (void)closeBtnClick:(UIButton *)btn{
    if (self.closeBtnBlock) {
        self.closeBtnBlock([btn titleForState:UIControlStateNormal]);
    }
}
- (void)delBtnClick{
    if (self.delBtnBlock) {
        self.delBtnBlock();
    }
}
- (void)setDataSource:(MCRegisteredLinksModel *)dataSource{
    _dataSource = dataSource;
    self.dingDanUrlLabel.text = dataSource.RegistUrl;
     NSNumber *min_Rebate = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
    NSString * str = @"";
    if (dataSource.UserType == 1) {
        self.userTypeDetailLabel.text = @"代理";
       str = [NSString stringWithFormat:@"%d~%.1f",dataSource.Rebate,(dataSource.Rebate-[min_Rebate integerValue])/20.0];
    } else {
         self.userTypeDetailLabel.text = @"会员";
       str = [NSString stringWithFormat:@"%d~%.1f",dataSource.Rebate,(dataSource.Rebate-[min_Rebate integerValue])/20.0];
    }
    if (dataSource.Status == 1) {
        [self.closeBtn setTitle:@"关闭链接" forState:UIControlStateNormal];
    }else{
        [self.closeBtn setTitle:@"开启链接" forState:UIControlStateNormal];
    }
    self.fandianDetailLabel.text = str;
    self.renshuDetailLabel.text = [NSString stringWithFormat:@"%d",dataSource.RegisteredNum];
    self.dateDetailLabel.text = dataSource.CreateTime;
}

    
    

@end
