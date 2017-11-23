//
//  MCZhuanTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCZhuanTableViewCell.h"

@interface MCZhuanTableViewCell()

@property (weak, nonatomic)  UIView *bgView;
@property (weak, nonatomic)  UILabel *moneyLabel;
@property (weak, nonatomic)  UILabel *moneyDetailLabel;
@property (weak, nonatomic)  UILabel *dateLabel;
@property (weak, nonatomic)  UILabel *dateDetailLabel;
@property (weak, nonatomic)  UILabel *statusLabel;
@property (weak, nonatomic)  UIImageView *imgV;

@end

@implementation MCZhuanTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        self.backgroundColor = [UIColor colorWithHexString:@"#eff6fd"];
    }
    return self;
}

- (void)setUpUI{
    UIView *bgview = [[UIView alloc] init];
    [self.contentView addSubview:bgview];
    self.bgView = bgview;
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *statusLabel = [[UILabel alloc] init];
    [self.contentView addSubview:statusLabel];
    self.statusLabel = statusLabel;
    self.statusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.statusLabel.textColor = [UIColor whiteColor];
    self.statusLabel.backgroundColor = RGB(249, 83, 209);
    self.statusLabel.text = @"转";
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    self.dateLabel.text = @"时间";
    self.dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.dateLabel.textColor = RGB(136, 136, 136);
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    [self.contentView addSubview:moneyLabel];
    self.moneyLabel = moneyLabel;
    self.moneyLabel.text = @"金额";
    self.moneyLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.moneyLabel.textColor = RGB(249, 84, 83);
    
    
    
    UILabel *moneyDetailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:moneyDetailLabel];
    self.moneyDetailLabel = moneyDetailLabel;
    self.moneyDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.moneyDetailLabel.textColor = RGB(136, 136, 136);
    self.moneyDetailLabel.text = @"状态";
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(MC_REALVALUE(27)));
        make.top.equalTo(self).offset(MC_REALVALUE(20));
        make.left.equalTo(self).offset(MC_REALVALUE(22));
        
    }];
    self.statusLabel.layer.cornerRadius = 13.5;
    self.statusLabel.clipsToBounds = YES;
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statusLabel);
        make.left.equalTo(self.statusLabel.mas_right).offset(MC_REALVALUE(20));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statusLabel);
        make.left.equalTo(self.dateLabel.mas_right).offset(MC_REALVALUE(20));
    }];
    
    [self.moneyDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statusLabel);
        make.right.equalTo(self.mas_right).offset(MC_REALVALUE(-20));
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.statusLabel.backgroundColor = RGB(249, 83, 209);
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.statusLabel.backgroundColor = RGB(249, 83, 209);
}

- (void)setDataSource:(MCZhuanRecordModel *)dataSource{
    _dataSource = dataSource;
    NSString *str = [dataSource.InsertTime stringByReplacingOccurrencesOfString:@"-" withString:@""];
    self.dateLabel.text = str;
    float betMoneyFloat = [dataSource.TransferMoney floatValue];
    int betMoneyInt = [dataSource.TransferMoney intValue];
    if (betMoneyFloat == betMoneyInt) {
        self.moneyLabel.text = [NSString stringWithFormat:@"%d元",betMoneyInt];
    } else {
        NSString *str1 = [NSString stringWithFormat:@"%.2f元",betMoneyFloat];
        NSString *str2 = [NSString stringWithFormat:@"%.3f元",betMoneyFloat];
        if ([str1 floatValue] == [str2 floatValue]) {
            self.moneyLabel.text = str1;
        } else {
            self.moneyLabel.text = str2;
        }
    }
    

    
    if ([dataSource.TransferType isEqualToString:@"2"]) {
        self.moneyDetailLabel.text = @"成功";
        self.moneyDetailLabel.textColor = RGB(30, 212, 17);
    }else if ([dataSource.TransferType isEqualToString:@"4"]){
        self.moneyDetailLabel.text = @"失败";
        self.moneyDetailLabel.textColor = RGB(249, 84, 83);
        
    }else if ([dataSource.TransferType isEqualToString:@"3"]){
        self.moneyDetailLabel.text = @"处理中";
        self.moneyDetailLabel.textColor = RGB(144, 8, 215);
    }else{}
    //    self.statusLabel.textColor = RGB(220, 102, 109);
    
}
@end
