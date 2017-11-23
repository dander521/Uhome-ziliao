//
//  MCWithdrawDetailViewController.m
//  TLYL
//
//  Created by MC on 2017/9/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWithdrawDetailViewController.h"
#import "MCGroupPaymentModel.h"

@interface MCWithdrawDetailViewController ()


@property (weak, nonatomic)  UILabel *dingDanNumberLabel;

@property (weak, nonatomic)  UILabel *dingDanDetailLabel;

@property (weak, nonatomic)  UILabel *jinELabel;

@property (weak, nonatomic)  UILabel *jinEDetailLabel;

@property (weak, nonatomic)  UILabel *dateLabel;

@property (weak, nonatomic)  UILabel *dateDetailLabel;

//@property (weak, nonatomic)  UILabel *payMethodLabel;
//
//@property (weak, nonatomic)  UILabel *payMethodDetailLabel;

@property (weak, nonatomic)  UILabel *statusLabel;

@property (weak, nonatomic)  UILabel *statusDetailLabel;

@property (weak, nonatomic)  UILabel *infoLabel;

@property (weak, nonatomic)  UILabel *infoDetailLabel;

@property (weak, nonatomic)  UIButton *btnCopy;


@property (nonatomic,strong) NSString *bankID;

@end

@implementation MCWithdrawDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提款详情";
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
    
    
//    UILabel *payMethodLabel = [[UILabel alloc] init];
//    [self.view addSubview:payMethodLabel];
//    payMethodLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//    payMethodLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
//    payMethodLabel.text = @"方式：";
//    self.payMethodLabel = payMethodLabel;
//    
//    UILabel *payMethodDetailLabel = [[UILabel alloc] init];
//    [self.view addSubview:payMethodDetailLabel];
//    payMethodDetailLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//    payMethodDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
//    self.payMethodDetailLabel = payMethodDetailLabel;
    
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
    
//    [self.payMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.dingDanNumberLabel);
//        make.top.equalTo(self.dateLabel.mas_bottom).offset(MC_REALVALUE(15));
//        
//        
//    }];
//    [self.payMethodDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.payMethodLabel.mas_right);
//        make.top.equalTo(self.payMethodLabel);
//    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dingDanNumberLabel);
//        make.top.equalTo(self.payMethodLabel.mas_bottom).offset(MC_REALVALUE(15));
                make.top.equalTo(self.dateDetailLabel.mas_bottom).offset(MC_REALVALUE(15));
        
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
    
    
    /*
    DrawingsType（提款方式）说明：
    当 DrawingsType = 0 时，前台显示为“自动出款”
    当 DrawingsType = 1 时，前台显示为“提款”
    当 DrawingsType = 2 时，前台显示为“人工提款”
    当 DrawingsType = 7 时，前台显示为“其他扣款”
    当 DrawingsType = 8 时，前台显示为“活动扣款”
    当 DrawingsType 不为上述 时，前台显示为 “—”*/
    self.dingDanDetailLabel.text = self.dataSorce.DrawingsOrder;
    float betMoneyFloat = [self.dataSorce.DrawingsMoney floatValue];
    int betMoneyInt = [self.dataSorce.DrawingsMoney intValue];
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
    int DrawingsType =  [self.dataSorce.DrawingsType intValue];
    NSString *str = @"";
    if (DrawingsType == 0) {
        str = @"自动出款";
    } else if (DrawingsType == 1){
        str = @"提款";
    }else if (DrawingsType == 2){
        str = @"人工提款";
    }else if (DrawingsType == 7){
        str = @"其他扣款";
    }else if (DrawingsType == 8){
        str = @"活动扣款";
    }else{
        str = @"—";
    }
    
//  self.payMethodDetailLabel.text = str;
//    交易状态（0：未处理；1：交易中；2：拒绝；3：交易成功；4：交易失败）
    if ([self.dataSorce.DrawingsState isEqualToString:@"0"]) {
        self.statusDetailLabel.text = @"未处理";
        self.statusDetailLabel.textColor = RGB(178, 11, 25);
    } else if ([self.dataSorce.DrawingsState isEqualToString:@"1"]){
        self.statusDetailLabel.text = @"交易中";
        self.statusDetailLabel.textColor = RGB(27, 129, 207);
    }else if ([self.dataSorce.DrawingsState isEqualToString:@"2"]){
        self.statusDetailLabel.text = @"拒绝";
        self.statusDetailLabel.textColor = RGB(178, 11, 25);
    }else if ([self.dataSorce.DrawingsState isEqualToString:@"3"]){
        self.statusDetailLabel.text = @"交易成功";
        self.statusDetailLabel.textColor = RGB(27, 129, 207);
    }else if ([self.dataSorce.DrawingsState isEqualToString:@"4"]){
        self.statusDetailLabel.text = @"交易失败";
        self.statusDetailLabel.textColor = RGB(178, 11, 25);
    }
    
    int DrawingsState = [self.dataSorce.DrawingsState intValue];
    NSString *str1 = @"";
    
    /*
    DrawingsMark（交易备注）说明：
    当 DrawingsState = 2 时，交易备注取 DrawingsMark 的值.
    当 DrawingsType = 0 或 1 时，交易备注为“用户提款”.
    当 DrawingsType = 2 或 其他 时，交易备注取 DrawingsMark 的值.*/
    if (DrawingsState == 2) {
        str1 = self.dataSorce.DrawingsMark;
    } else if (DrawingsType == 0){
        str1 = @"用户提款";
    }else if (DrawingsType == 1){
        str1 = @"用户提款";
    }else {
        str1 = self.dataSorce.DrawingsMark;
    }
    self.infoDetailLabel.text = str1;
        
    
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

