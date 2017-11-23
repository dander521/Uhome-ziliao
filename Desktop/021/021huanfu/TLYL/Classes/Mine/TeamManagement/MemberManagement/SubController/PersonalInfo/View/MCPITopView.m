//
//  MCPITopView.m
//  TLYL
//
//  Created by miaocai on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPITopView.h"

@interface MCPITopView()
//时间
@property (nonatomic,weak) UILabel *subTitleLabel;
//状态
@property (nonatomic,weak) UILabel *statusTitleLabel;
// 点
@property (nonatomic,weak) UILabel *statusSSTitleLabel;
//用户名
@property (nonatomic,weak) UILabel *yueValueLabel;
//IP
@property (nonatomic,weak) UILabel *chongzhiValueLabel;

@end

@implementation MCPITopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = RGB(231, 231, 231);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), 0, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(96))];
    [self addSubview:bgView];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(20), MC_REALVALUE(38), G_SCREENWIDTH - MC_REALVALUE(26) - MC_REALVALUE(34), MC_REALVALUE(45))];
    [bgView addSubview:contView];
    contView.layer.cornerRadius = 5;
    contView.clipsToBounds = YES;
    contView.backgroundColor = RGB(246, 243, 248);
    
    CGFloat font = MC_REALVALUE(12);
    UIImageView *titleImageV = [[UIImageView alloc] init];
    [bgView addSubview:titleImageV];
    titleImageV.image = [UIImage imageNamed:@"dlgl-tdzl"];
    [titleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(MC_REALVALUE(18));
        make.top.equalTo(self).offset(MC_REALVALUE(9));
        make.height.width.equalTo(@(MC_REALVALUE(22)));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGB(46, 46, 46);
    titleLabel.text = @"最后登录时间：";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV.mas_right).offset(MC_REALVALUE(5));
        make.centerY.equalTo(titleImageV);
    }];
    UILabel *subTitleLabel = [[UILabel alloc] init];
    [self addSubview:subTitleLabel];
    subTitleLabel.font = [UIFont systemFontOfSize:font];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.text = @"加载中";
    self.subTitleLabel = subTitleLabel;
    
    subTitleLabel.textColor = RGB(102, 102, 102);
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(MC_REALVALUE(5));
        make.centerY.equalTo(titleImageV);
    }];
    UILabel *statusTitleLabel = [[UILabel alloc] init];
    [self addSubview:statusTitleLabel];
    statusTitleLabel.font = [UIFont systemFontOfSize:font];
    statusTitleLabel.textAlignment = NSTextAlignmentLeft;
    statusTitleLabel.text = @"在线";
    self.statusTitleLabel = statusTitleLabel;
    statusTitleLabel.textColor = RGB(30, 212, 17);
    [statusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgView.mas_right).offset(MC_REALVALUE(-16));
        make.centerY.equalTo(titleImageV);
    }];
    UILabel *statusSSTitleLabel = [[UILabel alloc] init];
    [self addSubview:statusSSTitleLabel];
    statusSSTitleLabel.backgroundColor = RGB(30, 212, 17);
    statusSSTitleLabel.layer.cornerRadius = 4;
    self.statusSSTitleLabel = statusSSTitleLabel;
    statusSSTitleLabel.clipsToBounds = YES;
    [statusSSTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleImageV);
        make.height.width.equalTo(@(8));
        make.right.equalTo(statusTitleLabel.mas_left).offset(-5);
    }];
    
    
    CGFloat topPadding = MC_REALVALUE(12.5);
    CGFloat vPadding = MC_REALVALUE(5);
    
    UILabel *yueLabel = [[UILabel alloc] init];
    [contView addSubview:yueLabel];
    yueLabel.font = [UIFont systemFontOfSize:font];
    yueLabel.textAlignment = NSTextAlignmentLeft;
    yueLabel.text = @"用户名：";
    yueLabel.textColor = RGB(46, 46, 46);
    
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView).offset(MC_REALVALUE(22));
        make.centerY.equalTo(contView);
    }];
    
    UILabel *yueValueLabel = [[UILabel alloc] init];
    [contView addSubview:yueValueLabel];
    yueValueLabel.font = [UIFont systemFontOfSize:font];
    yueValueLabel.textAlignment = NSTextAlignmentLeft;
    self.yueValueLabel = yueValueLabel;
    yueValueLabel.text = @"加载中";
    yueValueLabel.textColor = RGB(102, 102, 102);
    [yueValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel.mas_right).offset(vPadding);
        make.centerY.equalTo(contView);
    }];
    
    UILabel *chongzhiLabel = [[UILabel alloc] init];
    [contView addSubview:chongzhiLabel];
    chongzhiLabel.font = [UIFont systemFontOfSize:font];
    chongzhiLabel.textAlignment = NSTextAlignmentLeft;
    chongzhiLabel.text = @"IP：";
    chongzhiLabel.textColor = RGB(46, 46, 46);
    [chongzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView).offset(MC_REALVALUE(168));
        make.centerY.equalTo(contView);
    }];
    UILabel *chongzhiValueLabel = [[UILabel alloc] init];
    [contView addSubview:chongzhiValueLabel];
    chongzhiValueLabel.font = [UIFont systemFontOfSize:font];
    chongzhiValueLabel.textAlignment = NSTextAlignmentLeft;
    chongzhiValueLabel.text = @"加载中";
    self.chongzhiValueLabel = chongzhiValueLabel;
    chongzhiValueLabel.textColor = RGB(144, 8, 215);
    [chongzhiValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chongzhiLabel.mas_right).offset(vPadding);
        make.top.equalTo(chongzhiLabel);
    }];
    
}

- (void)setDataSource:(MCUrStatusModel *)dataSource{
    _dataSource = dataSource;
    self.subTitleLabel.text = dataSource.LoginTime;
    if (dataSource.OperationTypeEnum == 0) {//在线
        self.statusTitleLabel.text = @"在线";
        self.statusTitleLabel.textColor = RGB(30, 212, 17);
        self.statusSSTitleLabel.backgroundColor = RGB(30, 212, 17);
    } else {
        self.statusTitleLabel.text = @"离线";
        self.statusTitleLabel.textColor = RGB(153, 153, 153);
        self.statusSSTitleLabel.backgroundColor = RGB(153, 153, 153);
    }
    self.yueValueLabel.text = self.userName;
    self.chongzhiValueLabel.text = dataSource.LoginIP;
    
}
@end
