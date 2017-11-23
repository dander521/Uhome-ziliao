//
//  MCMMChargeTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMChargeTableViewCell.h"
@interface MCMMChargeTableViewCell()
/** xingming*/
@property (nonatomic,weak) UILabel *nameLabel;
/** tuandui*/
@property (nonatomic,weak) UILabel *titlesubLabel;
/** 类型*/
@property (nonatomic,weak) UILabel *typeLabel;
/** 充值*/
@property (nonatomic,weak) UILabel *chongzhiLabel;
/** 提款*/
@property (nonatomic,weak) UILabel *tikuanLabel;
/** 购彩*/
@property (nonatomic,weak) UILabel *goucaiLabel;
/** 返点*/
@property (nonatomic,weak) UILabel *fandianLabel;
/** 中奖*/
@property (nonatomic,weak) UILabel *zhongjiangLabel;
/** 其它*/
@property (nonatomic,weak) UILabel *qitaLabel;
/** 盈亏*/
@property (nonatomic,weak) UILabel *yingkuiLabel;

@end

@implementation MCMMChargeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    UIView *bgView1 = [[UIView alloc] init];
    [self addSubview:bgView1];
    bgView1.layer.cornerRadius = 6;
    bgView1.clipsToBounds = YES;
    [bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MC_REALVALUE(13));
        make.right.equalTo(self).offset(MC_REALVALUE(-13));
        make.top.equalTo(self).offset(MC_REALVALUE(10));
        make.bottom.equalTo(self).offset(MC_REALVALUE(0));
    }];
    bgView1.backgroundColor = [UIColor whiteColor];
    
    self.backgroundColor = RGB(231, 231, 231);
    CGFloat font = MC_REALVALUE(12);
    UIImageView *titleImageV = [[UIImageView alloc] init];
    [bgView1 addSubview:titleImageV];
    titleImageV.image = [UIImage imageNamed:@"dlgl-tdbb-xz"];
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView1).offset(MC_REALVALUE(22));
        make.top.equalTo(bgView1).offset(MC_REALVALUE(16));
        make.height.width.equalTo(@(MC_REALVALUE(22)));
    }];
    UILabel *titleLabel = [[UILabel alloc] init];
    [bgView1 addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"gurser";
    self.nameLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV.mas_right).offset(MC_REALVALUE(7));
        make.centerY.equalTo(titleImageV);
    }];
    UILabel *subTitleLabel = [[UILabel alloc] init];
    [bgView1 addSubview:subTitleLabel];
    subTitleLabel.font = [UIFont systemFontOfSize:font];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.textColor = RGB(102, 102, 102);
    subTitleLabel.text = @"直属：1，团队：6";
    self.titlesubLabel = subTitleLabel;
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(MC_REALVALUE(8));
        make.centerY.equalTo(titleImageV);
    }];

    UIView *bgView = [[UIView alloc] init];
    [bgView1 addSubview:bgView];
    bgView.layer.cornerRadius = 5;
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = RGB(246, 243, 248);
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV);
        make.top.equalTo(titleImageV.mas_bottom).offset(MC_REALVALUE(11));
        make.right.equalTo(self).offset(MC_REALVALUE(-27));
        make.height.equalTo(@(MC_REALVALUE(140)));
    }];
    
    CGFloat topPadding = MC_REALVALUE(12.5);
    CGFloat vPadding = MC_REALVALUE(5);
    
    UILabel *yueLabel = [[UILabel alloc] init];
    [bgView addSubview:yueLabel];
    yueLabel.font = [UIFont systemFontOfSize:font];
    yueLabel.textAlignment = NSTextAlignmentLeft;
    yueLabel.text = @"会员类型：";
    yueLabel.textColor = RGB(46, 46, 46);
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(MC_REALVALUE(22));
        make.top.equalTo(bgView).offset(MC_REALVALUE(19));
    }];
    
    UILabel *yueValueLabel = [[UILabel alloc] init];
    [bgView addSubview:yueValueLabel];
    yueValueLabel.font = [UIFont systemFontOfSize:font];
    yueValueLabel.textAlignment = NSTextAlignmentLeft;
    yueValueLabel.text = @"加载中";
    self.typeLabel = yueValueLabel;
    yueValueLabel.textColor = RGB(102, 102, 102);
    [yueValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel.mas_right).offset(vPadding);
        make.top.equalTo(yueLabel);
    }];
    
    UILabel *personLabel = [[UILabel alloc] init];
    [bgView addSubview:personLabel];
    personLabel.font = [UIFont systemFontOfSize:font];
    personLabel.textAlignment = NSTextAlignmentLeft;
    personLabel.text = @"充值金额：";
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
    self.chongzhiLabel = personValueLabel;
    personValueLabel.textColor = RGB(102, 102, 102);
    [personValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personLabel.mas_right).offset(vPadding);
        make.top.equalTo(yueLabel);
    }];
    
    
    
    UILabel *chongzhiLabel = [[UILabel alloc] init];
    [bgView addSubview:chongzhiLabel];
    chongzhiLabel.font = [UIFont systemFontOfSize:font];
    chongzhiLabel.textAlignment = NSTextAlignmentLeft;
    chongzhiLabel.text = @"提款金额：";
    chongzhiLabel.textColor = RGB(46, 46, 46);
    [chongzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel);
        make.top.equalTo(yueLabel.mas_bottom).offset(topPadding);
    }];
    
    UILabel *chongzhiValueLabel = [[UILabel alloc] init];
    [bgView addSubview:chongzhiValueLabel];
    chongzhiValueLabel.font = [UIFont systemFontOfSize:font];
    chongzhiValueLabel.textAlignment = NSTextAlignmentLeft;
    self.tikuanLabel = chongzhiValueLabel;
    chongzhiValueLabel.text = @"加载中";
    chongzhiValueLabel.textColor = RGB(102, 102, 102);
    [chongzhiValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chongzhiLabel.mas_right).offset(vPadding);
        make.top.equalTo(chongzhiLabel);
    }];
    
    UILabel *tixianLabel = [[UILabel alloc] init];
    [bgView addSubview:tixianLabel];
    tixianLabel.font = [UIFont systemFontOfSize:font];
    tixianLabel.textAlignment = NSTextAlignmentLeft;
    tixianLabel.text = @"购彩金额：";
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
    self.goucaiLabel = tixianValueLabel;
    tixianValueLabel.textColor = RGB(102, 102, 102);
    [tixianValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tixianLabel.mas_right).offset(vPadding);
        make.top.equalTo(chongzhiLabel);
    }];
    
    
    UILabel *touzhuLabel = [[UILabel alloc] init];
    [bgView addSubview:touzhuLabel];
    touzhuLabel.font = [UIFont systemFontOfSize:font];
    touzhuLabel.textAlignment = NSTextAlignmentLeft;
    touzhuLabel.text = @"返点金额：";
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
    self.fandianLabel = touzhuValueLabel;
    touzhuValueLabel.textColor = RGB(102, 102, 102);
    [touzhuValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(touzhuLabel.mas_right).offset(vPadding);
        make.top.equalTo(touzhuLabel);
    }];
    
    UILabel *renshuLabel = [[UILabel alloc] init];
    [bgView addSubview:renshuLabel];
    renshuLabel.font = [UIFont systemFontOfSize:font];
    renshuLabel.textAlignment = NSTextAlignmentLeft;
    renshuLabel.text = @"中奖金额：";
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
    self.zhongjiangLabel = renshuValueLabel;
    renshuValueLabel.textColor = RGB(102, 102, 102);
    [renshuValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(renshuLabel.mas_right).offset(vPadding);
        make.top.equalTo(renshuLabel);
    }];
    
    UILabel *zhuceLabel = [[UILabel alloc] init];
    [bgView addSubview:zhuceLabel];
    zhuceLabel.font = [UIFont systemFontOfSize:font];
    zhuceLabel.textAlignment = NSTextAlignmentLeft;
    zhuceLabel.text = @"其他收入：";
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
    self.qitaLabel = zhuceValueLabel;
    zhuceValueLabel.textColor = RGB(102, 102, 102);
    [zhuceValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zhuceLabel.mas_right).offset(vPadding);
        make.top.equalTo(zhuceLabel);
    }];
    
    UILabel *dengluLabel = [[UILabel alloc] init];
    [bgView addSubview:dengluLabel];
    dengluLabel.font = [UIFont systemFontOfSize:font];
    dengluLabel.textAlignment = NSTextAlignmentLeft;
    dengluLabel.text = @"盈亏金额：";
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
    self.yingkuiLabel = dengluValueLabel;
    dengluValueLabel.textColor = RGB(249, 84, 83);
    [dengluValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dengluLabel.mas_right).offset(vPadding);
        make.top.equalTo(dengluLabel);
    }];
}


-(void)setDataSource:(MCTCReportSubModel *)dataSource{
    _dataSource = dataSource;
    self.nameLabel.text = dataSource.UserName;
    self.titlesubLabel.text = [NSString stringWithFormat:@"直属：%d，团队:%d",dataSource.ChildNum,dataSource.TeamNum];
    NSString *str = ((dataSource.Category & 64) == 64) ? @"会员" : @"代理";
    self.typeLabel.text = str;
    self.chongzhiLabel.text = [NSString stringWithFormat:@"%@",dataSource.RechargeTotal];
    self.tikuanLabel.text = [NSString stringWithFormat:@"%@",dataSource.DrawingsTotal];
    self.goucaiLabel.text = [NSString stringWithFormat:@"%@",dataSource.BuyTotal];
    self.fandianLabel.text = [NSString stringWithFormat:@"%@",dataSource.RebateTotal];
    self.zhongjiangLabel.text = [NSString stringWithFormat:@"%@",dataSource.WinningTotal];
    self.qitaLabel.text = [NSString stringWithFormat:@"%@",dataSource.OtherTotal];
    self.yingkuiLabel.text = [NSString stringWithFormat:@"%@",dataSource.GainTotal];
    
}

@end
