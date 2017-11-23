//
//  MCMMTBTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMTBTableViewCell.h"
#import "MCLotteryID.h"

@interface MCMMTBTableViewCell()

@property (weak, nonatomic)  UILabel *lottoryLabel;
@property (weak, nonatomic)  UILabel *timeLabel;
@property (weak, nonatomic)  UILabel *qihaoLabel;
@property (weak, nonatomic)  UILabel *jiangjinLabel;
@property (weak, nonatomic)  UILabel *jinELabel;
@property (weak, nonatomic)  UILabel *statusLabel;
@property (weak, nonatomic)  UIView *baseView;
@property (weak,nonatomic)  UIImageView *imgV;


@end

@implementation MCMMTBTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI{
    
    self.contentView.backgroundColor = RGB(255, 255, 255);
    UIView *baseView = [[UIView alloc] init];
    [self.contentView addSubview:baseView];
    baseView.backgroundColor = [UIColor whiteColor];
    self.baseView = baseView;
    baseView.layer.borderColor = [UIColor clearColor].CGColor;
    // ming zi
    UILabel *lottoryLabel = [[UILabel alloc] init];
    [baseView addSubview:lottoryLabel];
    self.lottoryLabel = lottoryLabel;
    lottoryLabel.text = @"加载中1";
    
    // 才中
    UILabel *qihaoLabel = [[UILabel alloc] init];
    [baseView addSubview:qihaoLabel];
    self.qihaoLabel = qihaoLabel;
    self.qihaoLabel.text = @"加载中2";
    //jine
    UILabel *timeLabel = [[UILabel alloc] init];
    [baseView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    self.timeLabel.text = @"加载中3";
    
    // qihao
    UILabel *jiangjinLabel = [[UILabel alloc] init];
    [baseView addSubview:jiangjinLabel];
    self.jiangjinLabel = jiangjinLabel;
    self.jiangjinLabel.text = @"加载中4";
    jiangjinLabel.textAlignment = NSTextAlignmentRight;
    UILabel *jinELabel = [[UILabel alloc] init];
    [baseView addSubview:jinELabel];
    // 返点
    self.jinELabel = jinELabel;
    self.jinELabel.textAlignment = NSTextAlignmentRight;
    self.jinELabel.text = @"加载中5";
    
    // 开奖zhuangtai
    UILabel *statusLabel = [[UILabel alloc] init];
    [baseView addSubview:statusLabel];
    statusLabel.text = @"状态6";
    
    self.statusLabel = statusLabel;
    self.lottoryLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.timeLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.qihaoLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.jiangjinLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jinELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.statusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.lottoryLabel.textColor = RGB(46, 46, 46);
    self.timeLabel.textColor = RGB(249, 84, 83);
    self.qihaoLabel.textColor = RGB(46, 46, 46);
    self.jiangjinLabel.textColor = RGB(136, 136, 136);
    self.jinELabel.textColor = RGB(136, 136, 136);
    self.statusLabel.textColor = RGB(136, 136, 136);
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.contentView).offset(MC_REALVALUE(0));
        make.top.equalTo(self);
        make.left.equalTo(self.contentView).offset(MC_REALVALUE(0));
    }];
    
    [self.lottoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.baseView).offset(MC_REALVALUE(11));
    }];
    [self.qihaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MC_REALVALUE(156));
        make.centerY.equalTo(self.lottoryLabel.mas_centerY);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lottoryLabel);
        make.top.equalTo(self.lottoryLabel.mas_bottom).offset(MC_REALVALUE(8));
    }];
    
    [self.jiangjinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView).offset(MC_REALVALUE(-10));
        make.centerY.equalTo(self.lottoryLabel);
    }];
    [self.jinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.jiangjinLabel);
        make.centerY.equalTo(self.timeLabel.mas_centerY);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qihaoLabel);
        make.centerY.equalTo(self.timeLabel);
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDataSource:(MCMMTBmodel *)dataSource{
    _dataSource = dataSource;
    self.lottoryLabel.text = dataSource.UserName;
    self.qihaoLabel.text = [MCLotteryID getLotteryCategoriesNameByID:[NSString stringWithFormat:@"%d",dataSource.BetTb]];
    self.timeLabel.text = [NSString stringWithFormat:@"%d",dataSource.BetMoney];
    NSString *isstr = @"";
    if (dataSource.IssueNumber.length > 16) {
       isstr = [dataSource.IssueNumber substringFromIndex:4];
    }else{
        isstr = dataSource.IssueNumber;
    }
    self.jiangjinLabel.text = isstr;
    self.jinELabel.text = [NSString stringWithFormat:@"%d",dataSource.AwardMoney];
    NSString *orderStr = nil;
    int BetOrderState = dataSource.OrderState;
    if (BetOrderState == -1) {
        orderStr = @"全部";
    } else if (BetOrderState== 64) {
        orderStr = @"购买成功";
    } else if (BetOrderState == 33554432) {
        orderStr = @"未中奖";
    } else if (BetOrderState  == 16777216) {
        orderStr = @"已派奖";
    } else if (BetOrderState == 4) {
        orderStr = @"已撤单";
    } else if (BetOrderState== 32768) {
        orderStr = @"已撤奖";
    } else if(BetOrderState == 1048577){
        orderStr = @"购买成功";
    }else{
        orderStr = @"订单异常";
    }
    self.statusLabel.text = orderStr;
//    self.statusLabel.text = orderStr;
//    if ([orderStr isEqualToString:@"已派奖"]) {
//        self.statusLabel.textColor = [UIColor colorWithHexString:@"ff5757"];
//    } else if([orderStr isEqualToString:@"未中奖"]){
//        self.statusLabel.textColor = [UIColor colorWithHexString:@"1baa79"];
//    }else{
//        self.statusLabel.textColor = [UIColor colorWithHexString:@"3680d3"];
//    }
    //    已派奖ff5757     未中奖1baa79     其他3680d3
}
@end
