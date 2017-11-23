//
//  MCzhongJiangRecoredTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCzhongJiangRecoredTableViewCell.h"
#import "MCDataTool.h"
#import "MCLotteryID.h"

@interface MCzhongJiangRecoredTableViewCell()

@property (weak, nonatomic)  UILabel *lottoryLabel;
@property (weak, nonatomic)  UILabel *timeLabel;
@property (weak, nonatomic)  UILabel *qihaoLabel;
@property (weak, nonatomic)  UILabel *jiangjinLabel;
@property (weak, nonatomic)  UILabel *jinELabel;
@property (weak, nonatomic)  UILabel *statusLabel;
@property (weak, nonatomic)  UIView *baseView;
@property (weak,nonatomic)  UIImageView *imgV;


@end

@implementation MCzhongJiangRecoredTableViewCell
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
    
    UILabel *lottoryLabel = [[UILabel alloc] init];
    [baseView addSubview:lottoryLabel];
    self.lottoryLabel = lottoryLabel;
    lottoryLabel.text = @"彩种";
    
    
    UILabel *qihaoLabel = [[UILabel alloc] init];
    [baseView addSubview:qihaoLabel];
    self.qihaoLabel = qihaoLabel;
    self.qihaoLabel.text = @"期号";
    
    UILabel *timeLabel = [[UILabel alloc] init];
    [baseView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    self.timeLabel.text = @"00:00";
    
    
    UILabel *jiangjinLabel = [[UILabel alloc] init];
    [baseView addSubview:jiangjinLabel];
    self.jiangjinLabel = jiangjinLabel;
    self.jiangjinLabel.text = @"12345";
    jiangjinLabel.textAlignment = NSTextAlignmentRight;
    UILabel *jinELabel = [[UILabel alloc] init];
    [baseView addSubview:jinELabel];
    self.jinELabel = jinELabel;
    self.jinELabel.textAlignment = NSTextAlignmentRight;
    self.jinELabel.text = @"金额";
    
    
    UILabel *statusLabel = [[UILabel alloc] init];
    [baseView addSubview:statusLabel];
    statusLabel.text = @"状态";
    
    self.statusLabel = statusLabel;
    self.lottoryLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.timeLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.qihaoLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jiangjinLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.jinELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.statusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.lottoryLabel.textColor = RGB(46, 46, 46);
    self.timeLabel.textColor = RGB(136, 136, 136);
    self.qihaoLabel.textColor = RGB(136, 136, 136);
    self.jiangjinLabel.textColor = RGB(249, 84, 83);
    self.jinELabel.textColor = RGB(136, 136, 136);
    self.statusLabel.textColor = RGB(136, 136, 136);
}
- (void)layoutSubviews{
    [super layoutSubviews];
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

- (void)setDataSource:(MCUserWinRecordDetailDataModel *)dataSource{
    _dataSource = dataSource;
    self.qihaoLabel.text = [NSString stringWithFormat:@"%@期",dataSource.IssueNumber];

    self.timeLabel.text = dataSource.InsertTime;
    float betMoneyFloat = [dataSource.BetMoney floatValue];
    int betMoneyInt = [dataSource.BetMoney intValue];
    if (betMoneyFloat == betMoneyInt) {
        self.jiangjinLabel.text = [NSString stringWithFormat:@"%d元",betMoneyInt];
    } else {

        NSString *str1 = [NSString stringWithFormat:@"%.2f元",betMoneyFloat];
        NSString *str2 = [NSString stringWithFormat:@"%.3f元",betMoneyFloat];
        if ([str1 floatValue] == [str2 floatValue]) {
            self.jiangjinLabel.text = str1;
        } else {
            self.jiangjinLabel.text = str2;
        }
    }
    float awardMoneyFloat = [dataSource.AwardMoney floatValue];
    int awardMoneyInt = [dataSource.AwardMoney intValue];
    if (awardMoneyFloat == awardMoneyInt) {
        self.jinELabel.text = [NSString stringWithFormat:@"%d元",awardMoneyInt];
    } else {

        NSString *str1 = [NSString stringWithFormat:@"%.2f元",awardMoneyFloat];
        NSString *str2 = [NSString stringWithFormat:@"%.3f元",awardMoneyFloat];
        if ([str1 floatValue] == [str2 floatValue]) {
            self.jinELabel.text = str1;
        } else {
            self.jinELabel.text = str2;
        }
    }
    self.lottoryLabel.text = [MCLotteryID getLotteryCategoriesNameByID:dataSource.BetTb];
    int BetOrderState = [dataSource.OrderState intValue];
    NSString *orderStr = @"";
    if ((BetOrderState & 1) == 1) {
        orderStr = @"购买成功";
    } else if ((BetOrderState & 32768) == 32768) {
        orderStr = @"已撤奖";
    } else if ((BetOrderState & 64) == 64) {
        orderStr = @"已出票";

    } else if ((BetOrderState & 16777216) == 16777216) {
        orderStr = @"已派奖";

    } else if ((BetOrderState & 33554432) == 33554432) {
        orderStr = @"未中奖";

    } else if ((BetOrderState & 4096) == 4096) {
        orderStr = @"已结算";

    } else if ((BetOrderState & 512) == 512) {
        orderStr = @"强制结算";

    } else if ((BetOrderState & 4) == 4) {
        orderStr = @"已撤单";

    } else {
        orderStr = @"订单异常";

    }
    self.statusLabel.text = orderStr;
    if ([orderStr isEqualToString:@"已派奖"]) {
        self.statusLabel.textColor = [UIColor colorWithHexString:@"ff5757"];
    } else if([orderStr isEqualToString:@"未中奖"]){
        self.statusLabel.textColor = [UIColor colorWithHexString:@"1baa79"];
    }else{
        self.statusLabel.textColor = [UIColor colorWithHexString:@"3680d3"];
    }
    //    已派奖ff5757     未中奖1baa79     其他3680d3
}

+(CGFloat)computeHeight:(id)info{
    return 77;
}

@end















