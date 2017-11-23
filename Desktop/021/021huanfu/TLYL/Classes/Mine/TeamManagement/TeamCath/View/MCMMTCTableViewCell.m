//
//  MCMMTCTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMTCTableViewCell.h"
#import "MCTopUpRecrdTableViewCell.h"


@interface MCMMTCTableViewCell()

@property (weak, nonatomic)  UIView *bgView;
@property (weak, nonatomic)  UILabel *moneyLabel;
@property (weak, nonatomic)  UILabel *moneyDetailLabel;
@property (weak, nonatomic)  UILabel *dateLabel;
@property (weak, nonatomic)  UILabel *dateDetailLabel;
@property (weak, nonatomic)  UILabel *statusLabel;
@property (weak, nonatomic)  UIImageView *imgV;
@property (strong, nonatomic)  NSDictionary *dic;
@end

@implementation MCMMTCTableViewCell
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
    self.statusLabel.text = @"0";
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
    self.moneyLabel.text = @"充值金额";
    self.moneyLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.moneyLabel.textColor = RGB(249, 84, 83);
    
    
    
    UILabel *moneyDetailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:moneyDetailLabel];
    self.moneyDetailLabel = moneyDetailLabel;
    self.moneyDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.moneyDetailLabel.textColor = RGB(136, 136, 136);
    self.moneyDetailLabel.text = @"0";
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
        make.left.equalTo(self).offset(G_SCREENWIDTH * 0.25 - 5);
        make.width.equalTo(@(G_SCREENWIDTH * 0.25 - 6));
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statusLabel);
        make.left.equalTo(self).offset(G_SCREENWIDTH * 0.5 - 13);
        make.width.equalTo(@(G_SCREENWIDTH * 0.25 - 6));
    }];
    self.moneyDetailLabel.textAlignment = NSTextAlignmentLeft;
    [self.moneyDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statusLabel);
        make.right.equalTo(self.mas_right).offset(0);
        make.width.equalTo(@(G_SCREENWIDTH * 0.25 - 6));
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.statusLabel.backgroundColor =[UIColor colorWithHexString:self.dic[@"color"]];
    
}

- (NSDictionary *)getStatusLabelType:(int)DetailsSource{
    /**
     * 得到类型
     * 充
     * 提
     * 转
     * 投
     * 奖
     * 惠
     * 管
     * 返
     * 撤
     * 红
     * 资
     * @param DetailsSource
     * @return
     */
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        switch (DetailsSource) {
            case 1:{
                dic[@"color"] = @"#ffa800";
                dic[@"info"] = @"投";
            }
                break;
            case 10:
            case 11:
            case 12:
            case 13:
            {
                dic[@"color"] = @"#4f7de5";
                dic[@"info"] = @"撤";
            }
                break;
            case 17:
            case 153:
            {
            dic[@"color"] = @"#9153f9";
            dic[@"info"] = @"惠";
            }
                break;
            case 20:
            {
                dic[@"color"] = @"#ffa800";
                dic[@"info"] = @"投";
            }
                break;
            case 30:
            case 40:
            {
                dic[@"color"] = @"#3bc1a0";
                dic[@"info"] = @"返";
            }
                break;
            case 50:
            {
                dic[@"color"] = @"#f95453";
                dic[@"info"] = @"奖";
            }
                break;
            case 60:
            {
                dic[@"color"] = @"#4f7de5";
                dic[@"info"] = @"撤";
            }
                break;
            case 70:
            case 90:
            case 80:
            case 100:
            case 110:
            case 120:
            case 121:
            case 122:
            case 130:
            case 131:
            {
                dic[@"color"] = @"#1ed411";
                dic[@"info"] = @"提";
            }
                break;
            case 140:
            case 150:
            {
                dic[@"color"] = @"#0ba7ec";
                dic[@"info"] = @"充";
            }
                break;
            case 151:
            case 152:
            {
                dic[@"color"] = @"#b0c13b";
                dic[@"info"] = @"管";
            }
                break;
            case 160:
            {
                dic[@"color"] = @"#0ba7ec";
                dic[@"info"] = @"充";
            }
                break;
            case 170:
            case 180:
            case 290:
            case 310:
            case 300:
            {
                dic[@"color"] = @"#f953d0";
                dic[@"info"] = @"转";
            }
                break;
            case 190:
            case 200:
            {
                dic[@"color"] = @"#0ba7ec";
                dic[@"info"] = @"充";
            }
                break;
            case 210:
            {
                dic[@"color"] = @"#54a7db";
                dic[@"info"] = @"红";
            }
                break;
            case 220:
            case 230:
            case 231:
            case 240:
            case 241:
            case 251:
            case 252:
            case 253:
            case 254:
            case 255:
            case 256:
            case 257:
            {
                dic[@"color"] = @"#9153f9";
                dic[@"info"] = @"惠";
            }
                break;
            case 261:
            case 262:
            case 263:
            case 264:
            case 265:
            case 266:
            {
                dic[@"color"] = @"#b2349f";
                dic[@"info"] = @"资";
            }
                break;
            case 267:
            case 268:
            case 269:
            {
                dic[@"color"] = @"#54a7db";
                dic[@"info"] = @"红";
            }
                break;
            case 301:
            case 302:
            {
                dic[@"color"] = @"#b2349f";
                dic[@"info"] = @"资";
            }
                break;
            case 303:
            case 304:
            {
                dic[@"color"] = @"#b0c13b";
                dic[@"info"] = @"管";
            }
                break;
            default:
                break;
        }
    return dic;
    }



- (void)setDataSource:(MCTeamCModel *)dataSource{
    _dataSource = dataSource;
    NSDictionary *dic = [self getStatusLabelType:dataSource.DetailsSource];
    self.dic = dic;
    self.statusLabel.backgroundColor = [UIColor colorWithHexString:dic[@"color"]];
    self.statusLabel.text = dic[@"info"];
    self.dateLabel.text = dataSource.UserName;
    float betMoneyFloat = [dataSource.UseMoney floatValue];
    int betMoneyInt = [dataSource.UseMoney intValue];
    if (betMoneyFloat == betMoneyInt) {
        self.moneyLabel.text = [NSString stringWithFormat:@"%d",betMoneyInt];
    } else {
        NSString *str1 = [NSString stringWithFormat:@"%.2f",betMoneyFloat];
        NSString *str2 = [NSString stringWithFormat:@"%.3f",betMoneyFloat];
        if ([str1 floatValue] == [str2 floatValue]) {
            self.moneyLabel.text = str1;
        } else {
            self.moneyLabel.text = str2;
        }
    }
    float betMoneyFloat1 = [dataSource.ThenBalance floatValue];
    int betMoneyInt1 = [dataSource.ThenBalance intValue];
    if (betMoneyFloat1 == betMoneyInt1) {
        self.moneyDetailLabel.text = [NSString stringWithFormat:@"%d",betMoneyInt1];
    } else {
        NSString *str11 = [NSString stringWithFormat:@"%.2f",betMoneyFloat1];
        NSString *str21 = [NSString stringWithFormat:@"%.3f",betMoneyFloat1];
        if ([str11 floatValue] == [str21 floatValue]) {
            self.moneyDetailLabel.text = str11;
        } else {
            self.moneyDetailLabel.text = str21;
        }
    }

   
    
}
@end
