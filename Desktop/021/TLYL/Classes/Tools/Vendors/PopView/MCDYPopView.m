//
//  MCDYPopView.m
//  TLYL
//
//  Created by miaocai on 2017/9/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCDYPopView.h"
#import "MCGroupPaymentModel.h"
#define dicBankCode @{ @"5":@"16",@"8":@"17",@"9":@"19",@"14":@"20",@"15":@"21",@"16":@"22",@"18":@"23",@"19":@"24",@"20":@"25",@"21":@"26",@"22":@"27",@"23":@"28",@"24":@"29",@"25":@"30",@"26":@"31",@"32":@"32",@"33":@"33",@"34":@"34",@"35":@"35",@"36":@"36",@"37":@"37",@"38":@"38",@"39":@"39",@"40":@"40",@"41":@"41",@"42":@"42",@"43":@"43",@"44":@"44",@"45":@"45",@"47":@"47",@"48":@"48",@"50":@"50",@"51":@"51",@"52":@"52",@"53":@"53",@"54":@"54",@"55":@"55",@"57":@"57",@"58":@"58",@"59":@"59",@"60":@"60",@"61":@"61",@"62":@"62",@"63":@"63",@"64":@"64",@"65":@"65",@"66":@"66",@"67":@"67",@"68":@"68",@"69":@"69",@"70":@"70",@"6":@"151",@"12":@"152",@"11":@"153",@"10":@"154",@"13":@"155",@"17":@"156",@"157":@"157",@"71":@"71",@"72":@"72",@"73":@"73",@"74":@"74",@"75":@"75",@"76":@"76",@"77":@"77",@"78":@"78",@"79":@"79",@"80":@"80",@"81":@"81",@"82":@"82",@"83":@"83",@"84":@"84",@"85":@"85",@"86":@"86",@"87":@"87",@"88":@"88",@"89":@"89",@"90":@"90",@"91":@"91",@"92":@"92",@"93":@"93",@"94":@"94",@"95":@"95",@"96":@"96",@"97":@"97",@"98":@"98",@"99":@"99",@"100":@"100"}

static MCDYPopView *_instance;
@interface MCDYPopView()

@property (nonatomic,weak) UILabel *dingDanNumberLabel;
@property (nonatomic,weak) UILabel *dingDanDetailLabel;
@property (nonatomic,weak) UILabel *jinELabel;
@property (nonatomic,weak) UILabel *jinEDetailLabel;
@property (nonatomic,weak) UILabel *dateLabel;
@property (nonatomic,weak) UILabel *dateDetailLabel;
@property (nonatomic,weak) UILabel *statusLabel;
@property (nonatomic,weak) UILabel *statusDetailLabel;
@property (nonatomic,weak) UILabel *jiaoyiStatusLabelDetail;
@property (nonatomic,weak) UILabel *jiaoyiStatusLabel;
@property (nonatomic,weak) UIButton *continueBtn;
@property (nonatomic,weak) UILabel *zhuanStatusDetailLabel;
@property (nonatomic,weak) UILabel *zhuanStatusLabel;
@property (nonatomic,weak) UILabel *infoLabel;
@property (nonatomic,weak) UILabel *infoDetailLabel;
@property (nonatomic,weak) UIView *middleView;
@end
@implementation MCDYPopView
- (instancetype)init{
    if (self == [super init]) {
        self.hidden = YES;
        [self setUiUP];
    }
    
    return self;
}

- (void)setUiUP{
    self.frame = CGRectMake(0, 194 - 64, G_SCREENWIDTH - MC_REALVALUE(40), MC_REALVALUE(280 + 17));
    self.backgroundColor = [UIColor clearColor];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(17), G_SCREENWIDTH - MC_REALVALUE(40), MC_REALVALUE(280))];
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
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((self.widht - MC_REALVALUE(180))*0.5, 0, MC_REALVALUE(180), MC_REALVALUE(34))];
    label.backgroundColor = RGB(144, 8, 215);
    label.text = @"资金明细";
    label.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = MC_REALVALUE(17);
    label.clipsToBounds = YES;
    [self addSubview:label];
    
    UIView *middleView = [[UIView alloc] init];
    [bgView addSubview:middleView];
    middleView.backgroundColor = RGB(251, 251, 251);
    middleView.layer.borderWidth = 0.5;
    middleView.layer.borderColor = RGB(220, 220, 200).CGColor;
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MC_REALVALUE(20));
        make.right.equalTo(self).offset(MC_REALVALUE(-20));
        make.top.equalTo(self).offset(MC_REALVALUE(44));
        make.height.equalTo(@(MC_REALVALUE(190)));
    }];
    
    
    UIButton *continueBtn = [[UIButton alloc] init];
    [bgView addSubview:continueBtn];
    continueBtn.backgroundColor = RGB(144, 8, 215);
    [continueBtn setTitle:@"继续充值" forState:UIControlStateNormal];
    [continueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    continueBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    continueBtn.layer.cornerRadius = 4;
    continueBtn.clipsToBounds = YES;
    [continueBtn addTarget:self action:@selector(continueBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [continueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MC_REALVALUE(25));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(8));
        make.width.equalTo(@((self.widht - MC_REALVALUE(60))*0.5));
    }];
    self.continueBtn = continueBtn;
    UIButton *cancelBtn = [[UIButton alloc] init];
    [bgView addSubview:cancelBtn];
    cancelBtn.layer.cornerRadius = 4;
    cancelBtn.clipsToBounds = YES;
    cancelBtn.backgroundColor = RGB(255, 168, 0);
    [cancelBtn setTitle:@"取消返回" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(continueBtn.mas_right).offset(MC_REALVALUE(10));
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(8));
        make.width.equalTo(@((self.widht - MC_REALVALUE(60))*0.5));
    }];
    
    UILabel *dingDanLabel = [[UILabel alloc] init];
    [middleView addSubview:dingDanLabel];
    self.dingDanNumberLabel = dingDanLabel;
    dingDanLabel.text = @"订单编号：";
    dingDanLabel.textColor = RGB(46, 46, 46);
    dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    UILabel *dingDanDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:dingDanDetailLabel];
    dingDanDetailLabel.textColor = RGB(46, 46, 46);
    dingDanDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.dingDanDetailLabel = dingDanDetailLabel;
    
    UILabel *jiaoyiStatusLabel = [[UILabel alloc] init];
    [middleView addSubview:jiaoyiStatusLabel];
    self.jiaoyiStatusLabel = jiaoyiStatusLabel;
    jiaoyiStatusLabel.text = @"交易类型：";
    jiaoyiStatusLabel.textColor = RGB(46, 46, 46);
    jiaoyiStatusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    UILabel *statusLabelDetail = [[UILabel alloc] init];
    [middleView addSubview:statusLabelDetail];
    self.middleView = middleView;
    statusLabelDetail.textColor = RGB(46, 46, 46);
    statusLabelDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jiaoyiStatusLabelDetail = statusLabelDetail;
    
    
    UILabel *jinELabel = [[UILabel alloc] init];
    [middleView addSubview:jinELabel];
    jinELabel.text = @"交易金额：";
    jinELabel.textColor = RGB(46, 46, 46);
    jinELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jinELabel = jinELabel;
    
    
    UILabel *jinEDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:jinEDetailLabel];
    jinEDetailLabel.textColor = RGB(249, 84, 83);
    jinEDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jinEDetailLabel = jinEDetailLabel;
    
    UILabel *zhuanStatusLabel = [[UILabel alloc] init];
    [middleView addSubview:zhuanStatusLabel];
    zhuanStatusLabel.textColor = RGB(46, 46, 46);
    zhuanStatusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhuanStatusLabel.text = @"转账状态：";
    self.zhuanStatusLabel = zhuanStatusLabel;
    
    UILabel *zhuanStatusDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:zhuanStatusDetailLabel];
    zhuanStatusDetailLabel.textColor = RGB(46, 46, 46);
    zhuanStatusDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.zhuanStatusDetailLabel = zhuanStatusDetailLabel;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    [middleView addSubview:dateLabel];
    dateLabel.textColor = RGB(46, 46, 46);
    dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    dateLabel.text = @"账变时间：";
    self.dateLabel = dateLabel;
    
    UILabel *dateDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:dateDetailLabel];
    dateDetailLabel.textColor = RGB(46, 46, 46);
    dateDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.dateDetailLabel = dateDetailLabel;
    
    
    UILabel *statusLabel = [[UILabel alloc] init];
    [middleView addSubview:statusLabel];
    statusLabel.textColor = RGB(46, 46, 46);
    statusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    statusLabel.text = @"充值状态：";
    self.statusLabel = statusLabel;
    
    UILabel *statusDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:statusDetailLabel];
    statusDetailLabel.textColor = RGB(46, 46, 46);
    statusDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.statusDetailLabel = statusDetailLabel;
    
    
    UILabel *infoLabel = [[UILabel alloc] init];
    [middleView addSubview:infoLabel];
    infoLabel.textColor = RGB(46, 46, 46);
    infoLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    infoLabel.text = @"备注信息：";
    self.infoLabel = infoLabel;
    
    UILabel *infoDetailLabel = [[UILabel alloc] init];
    [middleView addSubview:infoDetailLabel];
    infoDetailLabel.textColor = RGB(46, 46, 46);
    infoDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.infoDetailLabel = infoDetailLabel;
    
    [self.dingDanNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView).offset(MC_REALVALUE(10));
        make.left.equalTo(self.middleView).offset(MC_REALVALUE(10));
        
    }];
    [self.dingDanDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel.mas_right);
        make.top.equalTo(self.dingDanNumberLabel);
    }];
    [self.jiaoyiStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dingDanNumberLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.left.equalTo(self.dingDanNumberLabel);
        
    }];
    [self.jiaoyiStatusLabelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jiaoyiStatusLabel.mas_right);
        make.top.equalTo(self.jiaoyiStatusLabel);
    }];
    
    
    [self.jinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jiaoyiStatusLabel.mas_bottom).offset(MC_REALVALUE(10));
        
        
    }];
    [self.jinEDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jinELabel.mas_right);
        make.top.equalTo(self.jinELabel);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jinELabel.mas_bottom).offset(MC_REALVALUE(10));
        
        
    }];
    [self.dateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right);
        make.top.equalTo(self.dateLabel);
    }];
    
    
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    [self.statusDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right);
        make.top.equalTo(self.statusLabel);
    }];
    
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    [self.infoDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.infoLabel.mas_right);
        make.top.equalTo(self.infoLabel);
    }];
    self.statusDetailLabel.numberOfLines = 0;
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
#pragma mark -- 充值
- (void)setDataSource:(MCTopUpRecordModel *)dataSource{
    _dataSource = dataSource;
    self.infoLabel.hidden = NO;
    self.infoDetailLabel.hidden = NO;
    int re = [dataSource.RechargeType intValue];
//    RechargeType！=2 && RechargeType！=3 && RechargeType！=4 , 同时 RechargeMark 没有值时，交易备注显示为“用户充值”
    if (re !=2 &&re !=3 &&re !=4 && [dataSource.RechargeMark isEqualToString:@""]) {
         self.infoDetailLabel.text = @"用户充值";//dataSource.
    } else {
        self.infoDetailLabel.text = dataSource.RechargeMark;
    }
   
    self.zhuanStatusLabel.hidden = YES;
    self.zhuanStatusDetailLabel.hidden = YES;
    self.jiaoyiStatusLabel.text = @"交易类型：";
    self.statusLabel.text = @"充值状态：";
    [self.dingDanNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView).offset(MC_REALVALUE(21));
        make.left.equalTo(self.middleView).offset(MC_REALVALUE(10));
        
    }];
    [self.dingDanDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel.mas_right);
        make.top.equalTo(self.dingDanNumberLabel);
    }];
    [self.jiaoyiStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dingDanNumberLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.left.equalTo(self.dingDanNumberLabel);
        
    }];
    [self.jiaoyiStatusLabelDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jiaoyiStatusLabel.mas_right);
        make.top.equalTo(self.jiaoyiStatusLabel);
    }];
    
    
    [self.jinELabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jiaoyiStatusLabel.mas_bottom).offset(MC_REALVALUE(10));
        
        
    }];
    [self.jinEDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jinELabel.mas_right);
        make.top.equalTo(self.jinELabel);
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jinELabel.mas_bottom).offset(MC_REALVALUE(10));
        
        
    }];
    [self.dateDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right);
        make.top.equalTo(self.dateLabel);
    }];
    
    
    
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    [self.statusDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right);
        make.top.equalTo(self.statusLabel);
    }];

    [self.continueBtn setTitle:@"继续充值" forState:UIControlStateNormal];
    self.jiaoyiStatusLabel.text = @"交易类型：";
     self.dingDanDetailLabel.text = dataSource.RechargeOrder;
    float betMoneyFloat = [self.dataSource.RechargeMoney floatValue];
    int betMoneyInt = [self.dataSource.RechargeMoney intValue];
    if (betMoneyFloat == betMoneyInt) {
        self.jinEDetailLabel.text = [NSString stringWithFormat:@"%d元",betMoneyInt];
    } else {
        NSString *str1 = [NSString stringWithFormat:@"%.2f元",betMoneyFloat];
        NSString *str2 = [NSString stringWithFormat:@"%.3f元",betMoneyFloat];
        if ([str1 floatValue] == [str2 floatValue]) {
            self.jinEDetailLabel.text = str1;
        } else {
            self.jinEDetailLabel.text = str2;
        }
    }
    self.dateDetailLabel.text = dataSource.CreateTime;
    
    //状态
    if ([self.dataSource.RechargeState isEqualToString:@"0"]) {
        self.statusDetailLabel.text = @"未处理";
        self.statusDetailLabel.textColor = RGB(144, 8, 215);
    } else if ([self.dataSource.RechargeState isEqualToString:@"1"]){
        self.statusDetailLabel.text = @"交易成功";
        self.statusDetailLabel.textColor = RGB(30, 212, 17);
    }else if ([self.dataSource.RechargeState isEqualToString:@"2"]){
        self.statusDetailLabel.text = @"交易失败";
        self.statusDetailLabel.textColor = RGB(249, 84, 83);
    }else{
//        self.statusDetailLabel.text = @"未处理";
//        self.statusDetailLabel.textColor = RGB(144, 8, 215);
    }
    
    //方式
    /*
     RechargeType（交易类型）说明：
     当 RechargeType = 2 时，前台显示为“其他”
     当 RechargeType = 3 时，前台显示为“人工存款”
     当 RechargeType = 4 时，前台显示为“活动”
     当 RechargeType 不为上述 时，前台显示为 对应的银行名称。*/
    int RechargeType =  [self.dataSource.RechargeType intValue];
    if (RechargeType == 2) {
        self.jiaoyiStatusLabelDetail.text = @"其他";
    } else if(RechargeType == 3) {
        self.jiaoyiStatusLabelDetail.text = @"人工存款";
    }else if(RechargeType == 4){
        self.jiaoyiStatusLabelDetail.text = @"活动";
    }else{

        for (NSString *key in dicBankCode.allKeys) {
            if ([key isEqualToString:self.dataSource.RechargeType]) {
                dataSource.BankCode = dicBankCode[key];
            }
        }
        bool isPay = NO;
        
        for ( NSDictionary *dic in self.arrData) {
            if ([dic[@"Pay"] isEqualToString:dataSource.BankCode]) {
                self.jiaoyiStatusLabelDetail.text = dic[@"PayName"];
                isPay = YES;
            }
        }
        if (isPay == YES) {
            
        } else {
            self.jiaoyiStatusLabelDetail.text = @"其他";
        }
    }
    
}
#pragma mark -- 提款
- (void)setDataSourceD:(MCWithdrawModel *)dataSourceD{
    _dataSourceD = dataSourceD;
    self.infoLabel.hidden = NO;
    self.infoDetailLabel.hidden = NO;
    int re = [dataSourceD.DrawingsMark intValue];
    if (re ==0 ||re ==1 ) {
        self.infoDetailLabel.text = @"用户提款";
    } else {
        self.infoDetailLabel.text = dataSourceD.DrawingsMark;
    }
    self.zhuanStatusLabel.hidden = YES;
    self.zhuanStatusDetailLabel.hidden = YES;
    [self.dingDanNumberLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView).offset(MC_REALVALUE(21));
        make.left.equalTo(self.middleView).offset(MC_REALVALUE(10));
        
    }];
    [self.dingDanDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel.mas_right);
        make.top.equalTo(self.dingDanNumberLabel);
    }];
    [self.jiaoyiStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dingDanNumberLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.left.equalTo(self.dingDanNumberLabel);
        
    }];
    [self.jiaoyiStatusLabelDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jiaoyiStatusLabel.mas_right);
        make.top.equalTo(self.jiaoyiStatusLabel);
    }];
    
    
    [self.jinELabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jiaoyiStatusLabel.mas_bottom).offset(MC_REALVALUE(10));
        
        
    }];
    [self.jinEDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jinELabel.mas_right);
        make.top.equalTo(self.jinELabel);
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jinELabel.mas_bottom).offset(MC_REALVALUE(10));
        
        
    }];
    [self.dateDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right);
        make.top.equalTo(self.dateLabel);
    }];
    
    
    
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    [self.statusDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right);
        make.top.equalTo(self.statusLabel);
    }];
   
    [self.continueBtn setTitle:@"继续提款" forState:UIControlStateNormal];
        float betMoneyFloat = [dataSourceD.DrawingsMoney floatValue];
        int betMoneyInt = [dataSourceD.DrawingsMoney intValue];
        if (betMoneyFloat == betMoneyInt) {
            self.jinEDetailLabel.text = [NSString stringWithFormat:@"%d元",betMoneyInt];
        } else {
            NSString *str1 = [NSString stringWithFormat:@"%.2f元",betMoneyFloat];
            NSString *str2 = [NSString stringWithFormat:@"%.3f元",betMoneyFloat];
            if ([str1 floatValue] == [str2 floatValue]) {
                self.jinEDetailLabel.text = str1;
            } else {
                self.jinEDetailLabel.text = str2;
            }
        }
        self.dateDetailLabel.text = dataSourceD.CreateTime;
        
        //状态
        if ([dataSourceD.DrawingsState isEqualToString:@"0"]) {
            self.statusDetailLabel.text = @"未处理";
            self.statusDetailLabel.textColor = RGB(144, 8, 215);
        } else if ([dataSourceD.DrawingsState isEqualToString:@"1"]){
            self.statusDetailLabel.text = @"交易成功";
            self.statusDetailLabel.textColor = RGB(30, 212, 17);
        }else if ([dataSourceD.DrawingsState isEqualToString:@"2"]){
            self.statusDetailLabel.text = @"交易失败";
            self.statusDetailLabel.textColor = RGB(249, 84, 83);
        }
        int RechargeType =  [dataSourceD.DrawingsType intValue];
        if (RechargeType == 2) {
            self.jiaoyiStatusLabelDetail.text = @"其他";
        } else if(RechargeType == 3) {
            self.jiaoyiStatusLabelDetail.text = @"人工存款";
        }else if(RechargeType == 4){
            self.jiaoyiStatusLabelDetail.text = @"活动";
        }else{
            for (NSString *key in dicBankCode.allKeys) {
                if ([key isEqualToString:dataSourceD.DrawingsType]) {
                    dataSourceD.BankCode = dicBankCode[key];
                }
            }
            bool isPay = NO;
            for ( NSDictionary *dic in self.arrData) {
                if ([dic[@"Pay"] isEqualToString:dataSourceD.BankCode]) {
                    self.jiaoyiStatusLabelDetail.text = dic[@"PayName"];
                    isPay = YES;
                }
            }
            if (isPay == YES) {
                
            } else {
                self.jiaoyiStatusLabelDetail.text = @"其他";
            }
            
        }
    self.statusLabel.text = @"提款状态：";
}
#pragma mark -- 转账
- (void)setDataSourceZ:(MCZhuanRecordModel *)dataSourceZ{
    _dataSourceZ = dataSourceZ;
    self.infoLabel.hidden = YES;
    self.infoDetailLabel.hidden = YES;
    self.zhuanStatusLabel.hidden = NO;
    self.zhuanStatusDetailLabel.hidden = NO;
     self.statusDetailLabel.textColor = RGB(46, 46, 46);
    [self.dingDanNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView).offset(MC_REALVALUE(14));
        make.left.equalTo(self.middleView).offset(MC_REALVALUE(10));
        
    }];
    [self.zhuanStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jinELabel.mas_bottom).offset(MC_REALVALUE(10));
        
        
    }];
    [self.zhuanStatusDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.zhuanStatusLabel.mas_right);
        make.top.equalTo(self.zhuanStatusLabel);
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.zhuanStatusLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    [self.dateDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right);
        make.top.equalTo(self.dateLabel);
    }];
    
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    
    [self.statusDetailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right);
        make.top.equalTo(self.statusLabel);
        make.width.equalTo(@(MC_REALVALUE(260 - 40)));
    }];
    self.dingDanDetailLabel.text = dataSourceZ.OrderId;
    self.statusLabel.text = @"备注信息:";
     [self.continueBtn setTitle:@"继续转账" forState:UIControlStateNormal];
     self.jiaoyiStatusLabel.text = @"资金去向：";
    NSString *jiaoyiS = @"";
    if ([dataSourceZ.DetailsSource isEqualToString:@"300"]){
        jiaoyiS = @"棋牌-->彩票";
    }else if ([dataSourceZ.DetailsSource isEqualToString:@"290"]){
        jiaoyiS = @"彩票-->棋牌";
    }else {
        jiaoyiS =@"返款";
    }
    self.jiaoyiStatusLabelDetail.text = jiaoyiS;
    float betMoneyFloat = [dataSourceZ.TransferMoney floatValue];
    int betMoneyInt = [dataSourceZ.TransferMoney intValue];
    if (betMoneyFloat == betMoneyInt) {
        self.jinEDetailLabel.text = [NSString stringWithFormat:@"%d元",betMoneyInt];
    } else {
        NSString *str1 = [NSString stringWithFormat:@"%.2f元",betMoneyFloat];
        NSString *str2 = [NSString stringWithFormat:@"%.3f元",betMoneyFloat];
        if ([str1 floatValue] == [str2 floatValue]) {
            self.jinEDetailLabel.text = str1;
        } else {
            self.jinEDetailLabel.text = str2;
        }
    }
    self.dateDetailLabel.text = dataSourceZ.InsertTime;
    //状态
    if ([dataSourceZ.TransferType isEqualToString:@"3"]) {
        self.zhuanStatusDetailLabel.text = @"未处理";
        self.zhuanStatusDetailLabel.textColor = RGB(144, 8, 215);
    } else if ([dataSourceZ.TransferType isEqualToString:@"2"]){
        self.zhuanStatusDetailLabel.text = @"交易成功";
        self.zhuanStatusDetailLabel.textColor = RGB(30, 212, 17);
    }else if ([dataSourceZ.TransferType isEqualToString:@"4"]){
        self.zhuanStatusDetailLabel.text = @"交易失败";
        self.zhuanStatusDetailLabel.textColor = RGB(249, 84, 83);
    }
    self.statusDetailLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.statusDetailLabel.text = dataSourceZ.Marks;
    
}
@end
