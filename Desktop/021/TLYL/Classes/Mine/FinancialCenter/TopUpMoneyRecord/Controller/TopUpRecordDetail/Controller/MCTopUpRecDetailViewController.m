//
//  MCTopUpRecDetailViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTopUpRecDetailViewController.h"
#import "MCGroupPaymentModel.h"

#define dicBankCode @{ @"5":@"16",@"8":@"17",@"9":@"19",@"14":@"20",@"15":@"21",@"16":@"22",@"18":@"23",@"19":@"24",@"20":@"25",@"21":@"26",@"22":@"27",@"23":@"28",@"24":@"29",@"25":@"30",@"26":@"31",@"32":@"32",@"33":@"33",@"34":@"34",@"35":@"35",@"36":@"36",@"37":@"37",@"38":@"38",@"39":@"39",@"40":@"40",@"41":@"41",@"42":@"42",@"43":@"43",@"44":@"44",@"45":@"45",@"47":@"47",@"48":@"48",@"50":@"50",@"51":@"51",@"52":@"52",@"53":@"53",@"54":@"54",@"55":@"55",@"57":@"57",@"58":@"58",@"59":@"59",@"60":@"60",@"61":@"61",@"62":@"62",@"63":@"63",@"64":@"64",@"65":@"65",@"66":@"66",@"67":@"67",@"68":@"68",@"69":@"69",@"70":@"70",@"6":@"151",@"12":@"152",@"11":@"153",@"10":@"154",@"13":@"155",@"17":@"156",@"157":@"157",@"71":@"71",@"72":@"72",@"73":@"73",@"74":@"74",@"75":@"75",@"76":@"76",@"77":@"77",@"78":@"78",@"79":@"79",@"80":@"80",@"81":@"81",@"82":@"82",@"83":@"83",@"84":@"84",@"85":@"85",@"86":@"86",@"87":@"87",@"88":@"88",@"89":@"89",@"90":@"90",@"91":@"91",@"92":@"92",@"93":@"93",@"94":@"94",@"95":@"95",@"96":@"96",@"97":@"97",@"98":@"98",@"99":@"99",@"100":@"100"}

@interface MCTopUpRecDetailViewController ()


@property (weak, nonatomic)  UILabel *dingDanNumberLabel;

@property (weak, nonatomic)  UILabel *dingDanDetailLabel;

@property (weak, nonatomic)  UILabel *jinELabel;

@property (weak, nonatomic)  UILabel *jinEDetailLabel;

@property (weak, nonatomic)  UILabel *dateLabel;

@property (weak, nonatomic)  UILabel *dateDetailLabel;

@property (weak, nonatomic)  UILabel *payMethodLabel;
//方式
@property (weak, nonatomic)  UILabel *payMethodDetailLabel;

@property (weak, nonatomic)  UILabel *statusLabel;
//状态
@property (weak, nonatomic)  UILabel *statusDetailLabel;

@property (weak, nonatomic)  UILabel *infoLabel;
//备注
@property (weak, nonatomic)  UILabel *infoDetailLabel;

@property (weak, nonatomic)  UIButton *btnCopy;


@property (nonatomic,strong) NSString *bankID;

@end

@implementation MCTopUpRecDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"充值详情";
    
    [self setUpUI];
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)setUpUI{
    
    UILabel *dingDanLabel = [[UILabel alloc] init];
    [self.view addSubview:dingDanLabel];
    self.dingDanNumberLabel = dingDanLabel;
    dingDanLabel.text = @"订单号：";
    dingDanLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    
    UILabel *dingDanDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:dingDanDetailLabel];
    dingDanDetailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    dingDanDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.dingDanDetailLabel = dingDanDetailLabel;
    
    UIButton *btnCopy = [[UIButton alloc] init];
    [self.view addSubview:btnCopy];
    self.btnCopy = btnCopy;
    [btnCopy setTitle:@"复制" forState:UIControlStateNormal];
    [btnCopy setTitleColor:RGB(71, 143, 212) forState:UIControlStateNormal];
    btnCopy.layer.borderWidth = 1.0f;
    btnCopy.layer.cornerRadius = 2;
    btnCopy.clipsToBounds = YES;
    btnCopy.layer.borderColor = RGB(71, 143, 212).CGColor;
    btnCopy.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14.0f)];
    [btnCopy addTarget:self action:@selector(btnCopyClick) forControlEvents:UIControlEventTouchDown];
    UILabel *jinELabel = [[UILabel alloc] init];
    [self.view addSubview:jinELabel];
    jinELabel.text = @"金额：";
    jinELabel.textColor = [UIColor colorWithHexString:@"#666666"];
    jinELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.jinELabel = jinELabel;
    
    
    UILabel *jinEDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:jinEDetailLabel];
    jinEDetailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    jinEDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.jinEDetailLabel = jinEDetailLabel;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    [self.view addSubview:dateLabel];
    dateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    dateLabel.text = @"时间：";
    self.dateLabel = dateLabel;
    
    UILabel *dateDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:dateDetailLabel];
    dateDetailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    dateDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.dateDetailLabel = dateDetailLabel;
    
    
    UILabel *statusLabel = [[UILabel alloc] init];
    [self.view addSubview:statusLabel];
    statusLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    statusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    statusLabel.text = @"状态：";
    self.statusLabel = statusLabel;
    
    UILabel *statusDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:statusDetailLabel];
    statusDetailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    statusDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.statusDetailLabel = statusDetailLabel;
    
    
    UILabel *payMethodLabel = [[UILabel alloc] init];
    [self.view addSubview:payMethodLabel];
    payMethodLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    payMethodLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    payMethodLabel.text = @"方式：";
    self.payMethodLabel = payMethodLabel;
    
    UILabel *payMethodDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:payMethodDetailLabel];
    payMethodDetailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    payMethodDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.payMethodDetailLabel = payMethodDetailLabel;
    
    UILabel *infoLabel = [[UILabel alloc] init];
    [self.view addSubview:infoLabel];
    infoLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    infoLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    infoLabel.text = @"备注：";
    self.infoLabel = infoLabel;
    
    UILabel *infoDetailLabel = [[UILabel alloc] init];
    [self.view addSubview:infoDetailLabel];
    infoDetailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    infoDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.infoDetailLabel = infoDetailLabel;
    
    [self.dingDanNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(MC_REALVALUE(25));
        make.left.equalTo(self.view).offset(MC_REALVALUE(10));
        
    }];
    [self.dingDanDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel.mas_right);
        make.top.equalTo(self.dingDanNumberLabel);
    }];
    
    [self.btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-MC_REALVALUE(10));
        make.centerY.equalTo(self.dingDanNumberLabel);
        make.height.equalTo(@(MC_REALVALUE(30)));
        make.width.equalTo(@(MC_REALVALUE(72)));
    }];
    
    [self.jinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.dingDanNumberLabel.mas_bottom).offset(MC_REALVALUE(15));
        
        
    }];
    [self.jinEDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.jinELabel.mas_right);
        make.top.equalTo(self.jinELabel);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.jinELabel.mas_bottom).offset(MC_REALVALUE(15));
        
        
    }];
    [self.dateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateLabel.mas_right);
        make.top.equalTo(self.dateLabel);
    }];
    
    [self.payMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(MC_REALVALUE(15));
        
        
    }];
    [self.payMethodDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.payMethodLabel.mas_right);
        make.top.equalTo(self.payMethodLabel);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.payMethodLabel.mas_bottom).offset(MC_REALVALUE(15));
//        make.top.equalTo(self.dateDetailLabel.mas_bottom).offset(MC_REALVALUE(15));
        
    }];
    [self.statusDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.statusLabel.mas_right);
        make.top.equalTo(self.statusLabel);
    }];
    
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
        make.top.equalTo(self.statusLabel.mas_bottom).offset(MC_REALVALUE(15));
        
        
    }];
    [self.infoDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.infoLabel.mas_right);
        make.top.equalTo(self.infoLabel);
    }];
    
        self.dingDanDetailLabel.text = self.dataSorce.RechargeOrder;
    
    
    float betMoneyFloat = [self.dataSorce.RechargeMoney floatValue];
    int betMoneyInt = [self.dataSorce.RechargeMoney intValue];
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
        self.dateDetailLabel.text = self.dataSorce.CreateTime;

    //状态
    if ([self.dataSorce.RechargeState isEqualToString:@"0"]) {
        self.statusDetailLabel.text = @"未处理";
        self.statusDetailLabel.textColor = RGB(178, 11, 25);
    } else if ([self.dataSorce.RechargeState isEqualToString:@"1"]){
        self.statusDetailLabel.text = @"交易成功";
        self.statusDetailLabel.textColor = RGB(27, 129, 207);
    }else if ([self.dataSorce.RechargeState isEqualToString:@"2"]){
        self.statusDetailLabel.text = @"交易失败";
        self.statusDetailLabel.textColor = RGB(178, 11, 25);
    }



    //方式
    /*
    RechargeType（交易类型）说明：
    当 RechargeType = 2 时，前台显示为“其他”
    当 RechargeType = 3 时，前台显示为“人工存款”
    当 RechargeType = 4 时，前台显示为“活动”
    当 RechargeType 不为上述 时，前台显示为 对应的银行名称。*/
    int RechargeType =  [self.dataSorce.RechargeType intValue];
    if (RechargeType == 2) {
        self.payMethodDetailLabel.text = @"其他";
    } else if(RechargeType == 3) {
        self.payMethodDetailLabel.text = @"人工存款";
    }else if(RechargeType == 4){
        self.payMethodDetailLabel.text = @"活动";
    }else{
        for (NSString *key in dicBankCode.allKeys) {
            if ([key isEqualToString:self.dataSorce.RechargeType]) {
                self.bankID = dicBankCode[key];
            }
        }
        for ( MCGroupPaymentModel *model1 in self.arrData) {
            
            if ([model1.Pay isEqualToString:self.bankID]) {
                 self.payMethodDetailLabel.text = model1.PayName;
            }
        }
    }

 
    /*
     RechargeMark（交易备注）说明：
     交易备注取 RechargeMark 的值.
     当RechargeType！=2 && RechargeType！=3 && RechargeType！=4 , 同时 RechargeMark 没有值时，交易备注显示为“用户充值”。*/
    if(RechargeType!=2 && RechargeType!=3 && RechargeType !=4 && ([self.dataSorce.RechargeMark isEqualToString:@""] || self.dataSorce.RechargeMark == nil)){
    
        self.infoDetailLabel.text = @"用户充值";
        
    }else{
        self.infoDetailLabel.text =self.dataSorce.RechargeMark;
    }

}
- (void)btnCopyClick{
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.dingDanDetailLabel.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
    }
}

@end




/*
RechargeType（交易类型）说明：
当 RechargeType = 2 时，前台显示为“其他”
当 RechargeType = 3 时，前台显示为“人工存款”
当 RechargeType = 4 时，前台显示为“活动”
当 RechargeType 不为上述 时，前台显示为 对应的银行名称。
RechargeMark（交易备注）说明：
交易备注取 RechargeMark 的值.
当RechargeType！=2 && RechargeType！=3 && RechargeType！=4 , 同时 RechargeMark 没有值时，交易备注显示为“用户充值”。



*/
