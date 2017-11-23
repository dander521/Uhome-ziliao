//
//  MCTopTotalView.m
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTopTotalView.h"

@interface MCTopTotalView()

@property (nonatomic,weak) UILabel *yueValueLabel;
@property (nonatomic,weak) UILabel *personValueLabel;
@property (nonatomic,weak) UILabel *chongzhiValueLabel;
@property (nonatomic,weak) UILabel *tixianValueLabel;
@property (nonatomic,weak) UILabel *touzhuValueLabel;
@property (nonatomic,weak) UILabel *renshuValueLabel;
@property (nonatomic,weak) UILabel *zhuceValueLabel;
@property (nonatomic,weak) UILabel *dengluValueLabel;
@property (nonatomic,weak) UILabel *yueLabel;

@end

@implementation MCTopTotalView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
     CGFloat font = MC_REALVALUE(12);
    UIImageView *titleImageV = [[UIImageView alloc] init];
    [self addSubview:titleImageV];
    titleImageV.image = [UIImage imageNamed:@"dlgl-tdzl"];
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MC_REALVALUE(22));
        make.top.equalTo(self).offset(MC_REALVALUE(16));
        make.height.width.equalTo(@(MC_REALVALUE(22)));
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"24小时团队总览";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV.mas_right).offset(MC_REALVALUE(7));
        make.centerY.equalTo(titleImageV);
    }];
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = RGB(246, 243, 248);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV);
        make.top.equalTo(titleImageV.mas_bottom).offset(MC_REALVALUE(11));
        make.right.equalTo(self).offset(MC_REALVALUE(-14));
        make.height.equalTo(@(MC_REALVALUE(140)));
    }];
    
    CGFloat topPadding = MC_REALVALUE(12.5);
    CGFloat vPadding = MC_REALVALUE(0);
   
    UILabel *yueLabel = [[UILabel alloc] init];
    [bgView addSubview:yueLabel];
    yueLabel.font = [UIFont systemFontOfSize:font];
    yueLabel.textAlignment = NSTextAlignmentLeft;
    yueLabel.text = @"团队余额:";
    yueLabel.textColor = RGB(46, 46, 46);
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(MC_REALVALUE(22));
        make.top.equalTo(bgView).offset(MC_REALVALUE(19));
    }];
    self.yueLabel = yueLabel;
    UILabel *yueValueLabel = [[UILabel alloc] init];
    [bgView addSubview:yueValueLabel];
    yueValueLabel.font = [UIFont systemFontOfSize:font];
    yueValueLabel.textAlignment = NSTextAlignmentLeft;
    yueValueLabel.text = @"加载中";
    self.yueValueLabel = yueValueLabel;
    yueValueLabel.textColor = RGB(249, 84, 83);
    [yueValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel.mas_right).offset(vPadding);
        make.top.equalTo(yueLabel);
    }];
    
    UILabel *personLabel = [[UILabel alloc] init];
    [bgView addSubview:personLabel];
    personLabel.font = [UIFont systemFontOfSize:font];
    personLabel.textAlignment = NSTextAlignmentLeft;
    personLabel.text = @"团队成员:";
    personLabel.textColor = RGB(46, 46, 46);
    [personLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(MC_REALVALUE(167));
        make.top.equalTo(yueLabel);
    }];
    
    UILabel *personValueLabel = [[UILabel alloc] init];
    [bgView addSubview:personValueLabel];
    personValueLabel.font = [UIFont systemFontOfSize:font];
    personValueLabel.textAlignment = NSTextAlignmentLeft;
    personValueLabel.text = @"加载中";
    self.personValueLabel = personValueLabel;
    personValueLabel.textColor = RGB(46, 46, 46);
    [personValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personLabel.mas_right).offset(vPadding);
        make.top.equalTo(yueLabel);
    }];
    
    
    
    UILabel *chongzhiLabel = [[UILabel alloc] init];
    [bgView addSubview:chongzhiLabel];
    chongzhiLabel.font = [UIFont systemFontOfSize:font];
    chongzhiLabel.textAlignment = NSTextAlignmentLeft;
    chongzhiLabel.text = @"团队充值:";
    chongzhiLabel.textColor = RGB(46, 46, 46);
    [chongzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel);
        make.top.equalTo(yueLabel.mas_bottom).offset(topPadding);
    }];
    
    UILabel *chongzhiValueLabel = [[UILabel alloc] init];
    [bgView addSubview:chongzhiValueLabel];
    chongzhiValueLabel.font = [UIFont systemFontOfSize:font];
    chongzhiValueLabel.textAlignment = NSTextAlignmentLeft;
    chongzhiValueLabel.text = @"加载中";
    self.chongzhiValueLabel = chongzhiValueLabel;
    chongzhiValueLabel.textColor = RGB(46, 46, 46);
    [chongzhiValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chongzhiLabel.mas_right).offset(vPadding);
        make.top.equalTo(chongzhiLabel);
    }];
    
    UILabel *tixianLabel = [[UILabel alloc] init];
    [bgView addSubview:tixianLabel];
    tixianLabel.font = [UIFont systemFontOfSize:font];
    tixianLabel.textAlignment = NSTextAlignmentLeft;
    tixianLabel.text = @"团队提款:";
    tixianLabel.textColor = RGB(46, 46, 46);
    [tixianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(MC_REALVALUE(167));
        make.top.equalTo(chongzhiLabel);
    }];
    
    UILabel *tixianValueLabel = [[UILabel alloc] init];
    [bgView addSubview:tixianValueLabel];
    tixianValueLabel.font = [UIFont systemFontOfSize:font];
    tixianValueLabel.textAlignment = NSTextAlignmentLeft;
    tixianValueLabel.text = @"加载中";
    self.tixianValueLabel = tixianValueLabel;
    tixianValueLabel.textColor = RGB(46, 46, 46);
    [tixianValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tixianLabel.mas_right).offset(vPadding);
        make.top.equalTo(chongzhiLabel);
    }];
    
    
    UILabel *touzhuLabel = [[UILabel alloc] init];
    [bgView addSubview:touzhuLabel];
    touzhuLabel.font = [UIFont systemFontOfSize:font];
    touzhuLabel.textAlignment = NSTextAlignmentLeft;
    touzhuLabel.text = @"团队投注:";
    touzhuLabel.textColor = RGB(46, 46, 46);
    [touzhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel);
        make.top.equalTo(chongzhiLabel.mas_bottom).offset(topPadding);
    }];
    
    UILabel *touzhuValueLabel = [[UILabel alloc] init];
    [bgView addSubview:touzhuValueLabel];
    touzhuValueLabel.font = [UIFont systemFontOfSize:font];
    touzhuValueLabel.textAlignment = NSTextAlignmentLeft;
    touzhuValueLabel.text = @"加载中";
    self.touzhuValueLabel = touzhuValueLabel;
    touzhuValueLabel.textColor = RGB(46, 46, 46);
    [touzhuValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(touzhuLabel.mas_right).offset(vPadding);
        make.top.equalTo(touzhuLabel);
    }];
    
    UILabel *renshuLabel = [[UILabel alloc] init];
    [bgView addSubview:renshuLabel];
    renshuLabel.font = [UIFont systemFontOfSize:font];
    renshuLabel.textAlignment = NSTextAlignmentLeft;
    renshuLabel.text = @"投注人数:";
    renshuLabel.textColor = RGB(46, 46, 46);
    [renshuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(MC_REALVALUE(167));
        make.top.equalTo(touzhuLabel);
    }];
    
    UILabel *renshuValueLabel = [[UILabel alloc] init];
    [bgView addSubview:renshuValueLabel];
    renshuValueLabel.font = [UIFont systemFontOfSize:font];
    renshuValueLabel.textAlignment = NSTextAlignmentLeft;
    renshuValueLabel.text = @"加载中";
    self.renshuValueLabel = renshuValueLabel;
    renshuValueLabel.textColor = RGB(46, 46, 46);
    [renshuValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(renshuLabel.mas_right).offset(vPadding);
        make.top.equalTo(renshuLabel);
    }];
    
    UILabel *zhuceLabel = [[UILabel alloc] init];
    [bgView addSubview:zhuceLabel];
    zhuceLabel.font = [UIFont systemFontOfSize:font];
    zhuceLabel.textAlignment = NSTextAlignmentLeft;
    zhuceLabel.text = @"注册人数:";
    zhuceLabel.textColor = RGB(46, 46, 46);
    [zhuceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel);
        make.top.equalTo(touzhuLabel.mas_bottom).offset(topPadding);
    }];
    
    UILabel *zhuceValueLabel = [[UILabel alloc] init];
    [bgView addSubview:zhuceValueLabel];
    zhuceValueLabel.font = [UIFont systemFontOfSize:font];
    zhuceValueLabel.textAlignment = NSTextAlignmentLeft;
    zhuceValueLabel.text = @"加载中";
    self.zhuceValueLabel = zhuceValueLabel;
    zhuceValueLabel.textColor = RGB(46, 46, 46);
    [zhuceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zhuceLabel.mas_right).offset(vPadding);
        make.top.equalTo(zhuceLabel);
    }];
    
    UILabel *dengluLabel = [[UILabel alloc] init];
    [bgView addSubview:dengluLabel];
    dengluLabel.font = [UIFont systemFontOfSize:font];
    dengluLabel.textAlignment = NSTextAlignmentLeft;
    dengluLabel.text = @"登录人数:";
    dengluLabel.textColor = RGB(46, 46, 46);
    [dengluLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(MC_REALVALUE(167));
        make.top.equalTo(zhuceLabel);
    }];
    
    UILabel *dengluValueLabel = [[UILabel alloc] init];
    [bgView addSubview:dengluValueLabel];
    dengluValueLabel.font = [UIFont systemFontOfSize:font];
    dengluValueLabel.textAlignment = NSTextAlignmentLeft;
    dengluValueLabel.text = @"加载中";
    self.dengluValueLabel = dengluValueLabel;
    dengluValueLabel.textColor = RGB(46, 46, 46);
    [dengluValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dengluLabel.mas_right).offset(vPadding);
        make.top.equalTo(dengluLabel);
    }];
}

- (void)setDataSource:(MCOVerViewModel *)dataSource{
    _dataSource = dataSource;
    
    self.yueValueLabel.text = dataSource.TeamLotteryMoney;
    if (dataSource.TeamLotteryMoney.length > 12) {
        self.yueValueLabel.numberOfLines = 0;
        [self.yueValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yueLabel.mas_right).offset(0);
            make.top.equalTo(self.yueLabel).offset(-MC_REALVALUE(6));
            make.width.equalTo(@(MC_REALVALUE(85)));
            make.height.equalTo(@(MC_REALVALUE(40)));
        }];
    } else {
        [self.yueValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yueLabel.mas_right).offset(0);
            make.top.equalTo(self.yueLabel);
        }];
    }

    
    self.personValueLabel.text = [NSString stringWithFormat:@"%@",dataSource.TeamNum];
    self.chongzhiValueLabel.text = dataSource.TeamRechargeMoney;
    self.tixianValueLabel.text = dataSource.TeamDrawingsMoney;
    self.touzhuValueLabel.text = dataSource.TeamBetMoney;
    self.renshuValueLabel.text = [NSString stringWithFormat:@"%@",dataSource.TeamBetNum];
    self.zhuceValueLabel.text = [NSString stringWithFormat:@"%@",dataSource.TeamNewAddNum];
    self.dengluValueLabel.text = [NSString stringWithFormat:@"%@",dataSource.TeamLoginNum];
}

@end
