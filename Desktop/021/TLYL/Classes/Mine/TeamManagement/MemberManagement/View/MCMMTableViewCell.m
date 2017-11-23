//
//  MCMMTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMTableViewCell.h"
@interface MCMMTableViewCell()

@property (nonatomic,weak) UILabel *yueValueLabel;
@property (nonatomic,weak) UILabel *chongzhiValueLabel;
@property (nonatomic,weak) UILabel *tixianValueLabel;
@property (nonatomic,weak) UILabel *touzhuValueLabel;
@property (nonatomic,weak) UILabel *subTitleLabel;
@property (nonatomic,weak) UILabel *titleLabel;

@end

@implementation MCMMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = RGB(231, 231, 231);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), 0, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(205))];
    [self.contentView addSubview:bgView];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(20), MC_REALVALUE(49), G_SCREENWIDTH - MC_REALVALUE(26) - MC_REALVALUE(34), MC_REALVALUE(140))];
    [bgView addSubview:contView];
    contView.layer.cornerRadius = 5;
    contView.clipsToBounds = YES;
    contView.backgroundColor = RGB(246, 243, 248);

    CGFloat font = MC_REALVALUE(12);
    UIImageView *titleImageV = [[UIImageView alloc] init];
    [bgView addSubview:titleImageV];
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
    titleLabel.text = @"guest";
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleImageV.mas_right).offset(MC_REALVALUE(7));
        make.centerY.equalTo(titleImageV);
    }];
    UILabel *subTitleLabel = [[UILabel alloc] init];
    [bgView addSubview:subTitleLabel];
    subTitleLabel.font = [UIFont systemFontOfSize:font];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.text = @"加载中";
    self.subTitleLabel = subTitleLabel;
    self.subTitleLabel.textColor = RGB(102, 102, 102);
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(MC_REALVALUE(8));
        make.centerY.equalTo(titleImageV);
    }];

    CGFloat topPadding = MC_REALVALUE(12.5);
    CGFloat vPadding = MC_REALVALUE(5);
    UILabel *yueLabel = [[UILabel alloc] init];
    [contView addSubview:yueLabel];
    yueLabel.font = [UIFont systemFontOfSize:font];
    yueLabel.textAlignment = NSTextAlignmentLeft;
    yueLabel.text = @"账户余额：";
    yueLabel.textColor = RGB(46, 46, 46);
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView).offset(MC_REALVALUE(22));
        make.top.equalTo(contView).offset(MC_REALVALUE(19));
    }];
    
    UILabel *yueValueLabel = [[UILabel alloc] init];
    [contView addSubview:yueValueLabel];
    yueValueLabel.font = [UIFont systemFontOfSize:font];
    yueValueLabel.textAlignment = NSTextAlignmentLeft;
    self.yueValueLabel = yueValueLabel;
    yueValueLabel.text = @"加载中";
    yueValueLabel.textColor = RGB(249, 84, 83);
    [yueValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel.mas_right).offset(vPadding);
        make.top.equalTo(yueLabel);
    }];
    
    UILabel *chongzhiLabel = [[UILabel alloc] init];
    [contView addSubview:chongzhiLabel];
    chongzhiLabel.font = [UIFont systemFontOfSize:font];
    chongzhiLabel.textAlignment = NSTextAlignmentLeft;
    chongzhiLabel.text = @"账户返点：";
    chongzhiLabel.textColor = RGB(46, 46, 46);
    [chongzhiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel);
        make.top.equalTo(yueLabel.mas_bottom).offset(topPadding);
    }];
    
    UILabel *chongzhiValueLabel = [[UILabel alloc] init];
    [contView addSubview:chongzhiValueLabel];
    chongzhiValueLabel.font = [UIFont systemFontOfSize:font];
    chongzhiValueLabel.textAlignment = NSTextAlignmentLeft;
    chongzhiValueLabel.text = @"加载中";
    self.chongzhiValueLabel = chongzhiValueLabel;
    chongzhiValueLabel.textColor = RGB(102, 102, 102);
    [chongzhiValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chongzhiLabel.mas_right).offset(vPadding);
        make.top.equalTo(chongzhiLabel);
    }];
    
    UILabel *tixianLabel = [[UILabel alloc] init];
    [contView addSubview:tixianLabel];
    tixianLabel.font = [UIFont systemFontOfSize:font];
    tixianLabel.textAlignment = NSTextAlignmentLeft;
    tixianLabel.text = @"所属上级：";
    tixianLabel.textColor = RGB(46, 46, 46);
    [tixianLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel);
        make.top.equalTo(chongzhiLabel.mas_bottom).offset(topPadding);
    }];
    
    UILabel *tixianValueLabel = [[UILabel alloc] init];
    [contView addSubview:tixianValueLabel];
    tixianValueLabel.font = [UIFont systemFontOfSize:font];
    tixianValueLabel.textAlignment = NSTextAlignmentLeft;
    tixianValueLabel.text = @"加载中";
    self.tixianValueLabel = tixianValueLabel;
    tixianValueLabel.textColor = RGB(102, 102, 102);
    [tixianValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tixianLabel.mas_right).offset(vPadding);
        make.top.equalTo(tixianLabel);
    }];
    
    UILabel *touzhuLabel = [[UILabel alloc] init];
    [contView addSubview:touzhuLabel];
    touzhuLabel.font = [UIFont systemFontOfSize:font];
    touzhuLabel.textAlignment = NSTextAlignmentLeft;
    touzhuLabel.text = @"注册时间：";
    touzhuLabel.textColor = RGB(46, 46, 46);
    [touzhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel);
        make.top.equalTo(tixianLabel.mas_bottom).offset(topPadding);
    }];
    
    UILabel *touzhuValueLabel = [[UILabel alloc] init];
    [contView addSubview:touzhuValueLabel];
    touzhuValueLabel.font = [UIFont systemFontOfSize:font];
    touzhuValueLabel.textAlignment = NSTextAlignmentLeft;
    touzhuValueLabel.text = @"加载中";
    self.touzhuValueLabel = touzhuValueLabel;
    touzhuValueLabel.textColor = RGB(102, 102, 102);
    [touzhuValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(touzhuLabel.mas_right).offset(vPadding);
        make.top.equalTo(touzhuLabel);
    }];
    
    UIView *btnView = [[UIView alloc] init];
    [self.contentView insertSubview:btnView belowSubview:contView];
    btnView.backgroundColor = RGB(231, 231, 231);
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(MC_REALVALUE(0));
        make.top.equalTo(bgView.mas_bottom).offset(MC_REALVALUE(0));
        make.height.equalTo(@(MC_REALVALUE(30)));
    }];
    
    
    NSArray *btnTitleA =  @[@"个人资料",@"投注记录",@"账变记录",@"转账充值",@"返点设置"];
    for (NSInteger i = 0; i<btnTitleA.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        UIView *bgview1 = [[UIView alloc] init];
        [btnView addSubview:btn];
        [btnView addSubview:bgview1];
        bgview1.backgroundColor = RGB(255, 168, 0);
        btn.layer.cornerRadius = 4;
        btn.clipsToBounds = YES;
        [btn setTitle:btnTitleA[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateSelected];
        btn.backgroundColor = RGB(255, 168, 0);
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
        btn.frame = CGRectMake(i*MC_REALVALUE(60) + MC_REALVALUE(30) +i*MC_REALVALUE(4), 0, MC_REALVALUE(60), MC_REALVALUE(30));
        bgview1.frame = CGRectMake(i*MC_REALVALUE(60) + MC_REALVALUE(30) +i*MC_REALVALUE(4), 0, MC_REALVALUE(60), MC_REALVALUE(5));
        btn.tag = i+101;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (i == 4) {
            self.fandianBtn = btn;
            self.bgViewFandian =bgview1;
        }
    }
    
}

-(void)setDataSource:(MCMMlistModel *)dataSource{
    _dataSource = dataSource;
    NSString *str = ((dataSource.Category & 64) == 64) ? @"[会员]" : @"[代理]";
    self.subTitleLabel.text = str;
    NSString *str1 = [NSString stringWithFormat:@"%@",dataSource.LotteryMoney];
    NSArray *arr = [str1 componentsSeparatedByString:@"."];
    if (arr.count >=2) {
        NSString *str2 = arr[1];
        if (str2.length>=4) {
            str2 = [str1 substringWithRange:NSMakeRange(0, 4)];
            str1 = [NSString stringWithFormat:@"%@.%@",arr[0],str2];
        }
    }
    
    self.yueValueLabel.text = str1;
    NSNumber *min = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
    self.chongzhiValueLabel.text = [NSString stringWithFormat:@"%d~%.1f",dataSource.Rebate,(dataSource.Rebate - [min intValue])/20.0];
    self.tixianValueLabel.text = dataSource.ParentName;
    self.touzhuValueLabel.text = dataSource.CreateTime;
    self.titleLabel.text = dataSource.UserName;

}

- (void)btnClick:(UIButton *)btn{
    if (self.btnClickBlock) {
        self.btnClickBlock(btn.tag);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
