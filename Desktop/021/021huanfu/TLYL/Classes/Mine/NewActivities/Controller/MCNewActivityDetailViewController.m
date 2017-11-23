//
//  MCNewActivityDetailViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNewActivityDetailViewController.h"
#import "MCNewActGetMoneyModel.h"
#import "MCNewActCharModel.h"

@interface MCNewActivityDetailViewController ()

@property (nonatomic,weak) UILabel *myLabel;
@property (nonatomic,weak) UIButton *btn;
@property (nonatomic,strong) MCNewActGetMoneyModel *getMoneyModel;
@property (nonatomic,strong) MCNewActCharModel *charModel;
@end

@implementation MCNewActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.navigationItem.title = @"活动详情";
    [self loadData];
}
-(void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = RGB(245, 245, 245);
    
    UIImageView *titleImageV = [[UIImageView alloc] init];
    [self.view addSubview:titleImageV];
    titleImageV.image = [UIImage imageNamed:@"{B5716D77-E280-488F-9492-505EB450E9B9}"];
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(13);
        make.right.equalTo(self.view).offset(-13);
        make.height.equalTo(@(92));
        make.top.equalTo(self.view).offset(13 + 64);
        
    }];
    UILabel *titleLabel =  [[UILabel alloc] init];
    [self.view addSubview:titleLabel];
    titleLabel.text = @"情系十一月，宏泰发福利啦！";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGB(46, 46, 46);
    titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(14)];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(titleImageV.mas_bottom).offset(MC_REALVALUE(13));
        
    }];
    
    UILabel *titleSubLabel =  [[UILabel alloc] init];
    [self.view addSubview:titleSubLabel];
    titleSubLabel.textAlignment = NSTextAlignmentLeft;
    titleSubLabel.text = @"活动日期：2017年11月2日-结束时间提前24小时通知";
    titleSubLabel.textColor = RGB(99, 99, 99);
    titleSubLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [titleSubLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(titleLabel.mas_bottom).offset(MC_REALVALUE(13));
        
    }];
    
    
    UILabel *lineTitleLabel =  [[UILabel alloc] init];
    [self.view addSubview:lineTitleLabel];
    lineTitleLabel.backgroundColor = RGB(136, 136, 136);
    [lineTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(titleSubLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.height.equalTo(@(0.5));
    }];
    
    
    UILabel *contentLabel =  [[UILabel alloc] init];
    [self.view addSubview:contentLabel];
    contentLabel.text = @"活动内容：";
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = RGB(46, 46, 46);
    contentLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(11)];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(lineTitleLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    
    
    UIView *bgVIew = [[UIView alloc] init];
    [self.view addSubview:bgVIew];
    [bgVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(contentLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.height.equalTo(@(80));
    }];
    bgVIew.layer.borderWidth = 0.5;
    bgVIew.layer.borderColor = RGB(136, 136, 136).CGColor;
    
    UILabel *chongLabel = [[UILabel alloc] init];
    [bgVIew addSubview:chongLabel];
    chongLabel.textAlignment = NSTextAlignmentCenter;
    chongLabel.text = @"充值金额（元）";
    chongLabel.textColor = RGB(99, 99, 99);
    chongLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [chongLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(bgVIew);
        make.height.equalTo(@(40));
        make.width.equalTo(@(MC_REALVALUE(100)));
    }];
    
    chongLabel.layer.borderWidth = 0.25;
    chongLabel.layer.borderColor = RGB(136, 136, 136).CGColor;
    NSArray *cArr = @[@"1000",@"3000",@"5000",@"10000"];
    for (NSInteger i = 0; i<cArr.count; i++) {
        UILabel *chongJinLabel = [[UILabel alloc] init];
        [bgVIew addSubview:chongJinLabel];
        chongJinLabel.textAlignment = NSTextAlignmentCenter;
        chongJinLabel.text = cArr[i];
        chongJinLabel.textColor = RGB(99, 99, 99);
        chongJinLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        chongJinLabel.layer.borderWidth = 0.25;
        chongJinLabel.layer.borderColor = RGB(136, 136, 136).CGColor;
        chongJinLabel.frame = CGRectMake(0.25*(G_SCREENWIDTH - MC_REALVALUE(26) - MC_REALVALUE(100)) *i + MC_REALVALUE(100), 0, 0.25*(G_SCREENWIDTH - MC_REALVALUE(26) - MC_REALVALUE(100)), 40);
    }
    UILabel *jiangLabel = [[UILabel alloc] init];
    [bgVIew addSubview:jiangLabel];
    jiangLabel.textAlignment = NSTextAlignmentCenter;
    jiangLabel.text = @"奖励金额（元）";
    jiangLabel.textColor = RGB(99, 99, 99);
    jiangLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [jiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgVIew);
        make.top.equalTo(chongLabel.mas_bottom);
        make.height.equalTo(@(40));
        make.width.equalTo(@(MC_REALVALUE(100)));
    }];
    
    jiangLabel.layer.borderWidth = 0.25;
    jiangLabel.layer.borderColor = RGB(136, 136, 136).CGColor;
    
    NSArray *jArr = @[@"28",@"38",@"58",@"88"];
    for (NSInteger i = 0; i<jArr.count; i++) {
        UILabel *jiangLabel = [[UILabel alloc] init];
        [bgVIew addSubview:jiangLabel];
        jiangLabel.textAlignment = NSTextAlignmentCenter;
        jiangLabel.text = jArr[i];
        jiangLabel.textColor = RGB(99, 99, 99);
        jiangLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
        jiangLabel.layer.borderWidth = 0.25;
        jiangLabel.layer.borderColor = RGB(136, 136, 136).CGColor;
        jiangLabel.frame = CGRectMake(0.25*(G_SCREENWIDTH - MC_REALVALUE(26) - MC_REALVALUE(100)) *i + MC_REALVALUE(100), 40, 0.25*(G_SCREENWIDTH - MC_REALVALUE(26) - MC_REALVALUE(100)), 40);
    }

    UILabel *guizeLabel =  [[UILabel alloc] init];
    [self.view addSubview:guizeLabel];
    guizeLabel.text = @"活动规则：";
    guizeLabel.textAlignment = NSTextAlignmentLeft;
    guizeLabel.textColor = RGB(46, 46, 46);
    guizeLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(11)];
    [guizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(bgVIew.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    
    UILabel *infoLabel =  [[UILabel alloc] init];
    [self.view addSubview:infoLabel];
    infoLabel.numberOfLines = 0;

    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.textColor = RGB(99, 99, 99);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"1、每天首充金额消费本金50%即可领取相应奖励！\n2、若发现同IP，同姓名，多账户，进行对刷或利用其它优惠进行套利者，直接冻结账户!\n3、宏泰在线拥有最终解释权和修改权！"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    infoLabel.attributedText = attributedString;
    infoLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(guizeLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    
    UILabel *myLabel =  [[UILabel alloc] init];
    [self.view addSubview:myLabel];
    infoLabel.numberOfLines = 0;
    NSString *str = @"今日首充金额：0元 ，累计消费金额：0元，可领取：0元";
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    myLabel.textColor = RGB(99, 99, 99);
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
    for (int i = 0; i < str.length; i ++) {
        NSString *a = [str substringWithRange:NSMakeRange(i, 1)];
        if ([number containsObject:a]) {
          [attributeString addAttributes:@{NSForegroundColorAttributeName:RGB(249, 84, 83),NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(12)]} range:NSMakeRange(i, 1)];
        }
    }
    self.myLabel = myLabel;
    myLabel.attributedText = attributeString;
    myLabel.textAlignment = NSTextAlignmentLeft;
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleImageV);
        make.top.equalTo(infoLabel.mas_bottom).offset(MC_REALVALUE(10));
        
    }];
    
    
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(myLabel.mas_bottom).offset(MC_REALVALUE(10));
        make.height.equalTo(@(40));
        make.width.equalTo(@(80));
    }];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"立即领取" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnCLick) forControlEvents:UIControlEventTouchUpInside];
    self.btn = btn;
    
}
- (void)loadData{
    
    MCNewActGetMoneyModel *getMoneyModel = [[MCNewActGetMoneyModel alloc] init];
    self.getMoneyModel = getMoneyModel;
    [getMoneyModel refreashDataAndShow];
    __weak typeof(self) weakself= self;
    [BKIndicationView showInView:self.view];
    getMoneyModel.callBackSuccessBlock = ^(id manager) {
        NSString *str = @"";
        if ([manager[@"ReturnMoney"] intValue] <= 0) {
            weakself.btn.backgroundColor = RGB(181, 181, 181);
            weakself.btn.enabled = NO;
            str =[NSString stringWithFormat:@"今日首充金额：%@元，累计消费金额：%@元，可领取：%@元",manager[@"ReceiveMoney"],manager[@"ConsumptionMoney"],@0];
        }else{
            weakself.btn.backgroundColor = [UIColor orangeColor];
            weakself.btn.enabled = YES;
            str =[NSString stringWithFormat:@"今日首充金额：%@元，累计消费金额：%@元，可领取：%@元",manager[@"ReceiveMoney"],manager[@"ConsumptionMoney"],manager[@"ReturnMoney"]];
        }
        NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:str];
        for (int i = 0; i < str.length; i ++) {
            NSString *a = [str substringWithRange:NSMakeRange(i, 1)];
            if ([number containsObject:a]) {
                [attributeString addAttributes:@{NSForegroundColorAttributeName:RGB(249, 84, 83),NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(12)]} range:NSMakeRange(i, 1)];
            }
        }
        weakself.myLabel.attributedText = attributeString;
     
    };
}
- (void)btnCLick{
    MCNewActCharModel *charModel = [[MCNewActCharModel alloc] init];
    self.charModel = charModel;
    [charModel refreashDataAndShow];
    __weak typeof(self) weakself= self;
    [BKIndicationView showInView:self.view];
    charModel.callBackSuccessBlock = ^(id manager) {
        if ([manager[@"ReturnMoney"] intValue] == 1) {
            [SVProgressHUD showInfoWithStatus:manager[@"Remarks"]];
            [weakself loadData];
        } 
    };
}
@end
