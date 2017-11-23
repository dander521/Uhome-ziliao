//
//  MCPISubTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/10/23.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPISubTableViewCell.h"
#import "MCLotteryID.h"
#import "MCUserDefinedLotteryCategoriesModel.h"
@interface MCPISubTableViewCell()
//彩种
@property (nonatomic,weak) UILabel *subTitleLabel;
// 我的最大返奖
@property (nonatomic,weak) UILabel *statusSSTitleLabel;
//fandian
@property (nonatomic,weak) UILabel *yueValueLabel;
//IP
@property (nonatomic,weak) UILabel *yueLabel;

@end

@implementation MCPISubTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = RGB(231, 231, 231);
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13), G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(120))];
    [self.contentView addSubview:bgView];
    bgView.layer.cornerRadius = 6;
    bgView.clipsToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(20), MC_REALVALUE(20), G_SCREENWIDTH - MC_REALVALUE(26) - MC_REALVALUE(34), MC_REALVALUE(80))];
    [bgView addSubview:contView];
    contView.layer.cornerRadius = 5;
    contView.clipsToBounds = YES;
    contView.backgroundColor = RGB(246, 243, 248);
    
    CGFloat font = MC_REALVALUE(12);

    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = RGB(46, 46, 46);
    titleLabel.text = @"彩种：";
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView).offset(MC_REALVALUE(22));
        make.top.equalTo(contView).offset(MC_REALVALUE(20));
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    [self addSubview:subTitleLabel];
    subTitleLabel.font = [UIFont systemFontOfSize:font];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    subTitleLabel.text = @"加载中";
    self.subTitleLabel = subTitleLabel;
    
    subTitleLabel.textColor = RGB(102, 102, 102);
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(MC_REALVALUE(0));
        make.centerY.equalTo(titleLabel);
    }];
    UILabel *statusTitleLabel = [[UILabel alloc] init];
    [self addSubview:statusTitleLabel];
    statusTitleLabel.font = [UIFont systemFontOfSize:font];
    statusTitleLabel.textAlignment = NSTextAlignmentLeft;
    statusTitleLabel.text = @"我的最大返奖：";
    statusTitleLabel.textColor = RGB(46, 46, 46);
    [statusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView).offset(MC_REALVALUE(167));
        make.centerY.equalTo(titleLabel);
    }];
    UILabel *statusSSTitleLabel = [[UILabel alloc] init];
    [self addSubview:statusSSTitleLabel];
     statusSSTitleLabel.font = [UIFont systemFontOfSize:font];
    statusSSTitleLabel.text = @"加载中";
    statusSSTitleLabel.textColor = RGB(249, 84, 83);
    self.statusSSTitleLabel = statusSSTitleLabel;
    [statusSSTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel);
        make.left.equalTo(statusTitleLabel.mas_right);
    }];
    
    
    CGFloat topPadding = MC_REALVALUE(12.5);
    CGFloat vPadding = MC_REALVALUE(5);
    
    UILabel *yueLabel = [[UILabel alloc] init];
    [contView addSubview:yueLabel];
    yueLabel.font = [UIFont systemFontOfSize:font];
    yueLabel.textAlignment = NSTextAlignmentLeft;
    yueLabel.text = @"加载中：";
    self.yueLabel=yueLabel;
    yueLabel.textColor = RGB(46, 46, 46);
    
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView).offset(MC_REALVALUE(22));
        make.top.equalTo(titleLabel.mas_bottom).offset(MC_REALVALUE(20));
    }];
    
    UILabel *yueValueLabel = [[UILabel alloc] init];
    [contView addSubview:yueValueLabel];
    yueValueLabel.font = [UIFont systemFontOfSize:font];
    yueValueLabel.textAlignment = NSTextAlignmentLeft;
    self.yueValueLabel = yueValueLabel;
    yueValueLabel.text = @"加载中";
    yueValueLabel.textColor = RGB(249, 84, 83);
    [yueValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel.mas_right).offset(0);
        make.centerY.equalTo(yueLabel);
    }];
}
- (void)setName:(NSString *)name{
    _name = name;
    self.yueLabel.text = [NSString stringWithFormat:@"%@的最大返奖：",name];
}
- (void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
   NSNumber *myRebate = [[NSUserDefaults standardUserDefaults] objectForKey:@"MyRebate"];
   NSNumber *maxRebate =  [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMaxRebate];
   NSNumber *minRebate =  [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
    MCUserDefinedLotteryCategoriesModel *model = [MCUserDefinedLotteryCategoriesModel GetMCUserDefinedLotteryCategoriesModelWithCZID:[NSString stringWithFormat:@"%@",dataSource[@"LotteryCode"]]];
  int myMaxRebate = 0;
  int myLowerMaxRebate = 0;
  int maxV = [myRebate intValue] - ([maxRebate intValue] - [model.MaxRebate intValue]);
  int minV = self.rebateId - ([maxRebate intValue] - [model.MaxRebate intValue]);
    if ([minRebate intValue]>=maxV) {
        myMaxRebate = [minRebate intValue];
    } else {
        myMaxRebate = maxV;
    }
    if ([minRebate intValue]>=minV) {
        myLowerMaxRebate = [minRebate intValue];
    } else {
        myLowerMaxRebate = minV;
    }
    NSLog(@"%@",dataSource[@"LotteryCode"]);
    self.subTitleLabel.text = [MCLotteryID getLotteryCategoriesNameByID:[NSString stringWithFormat:@"%@",dataSource[@"LotteryCode"]]];
    self.statusSSTitleLabel.text = [NSString stringWithFormat:@"%d",myMaxRebate];
    self.yueValueLabel.text = [NSString stringWithFormat:@"%d",myLowerMaxRebate];
    
    
}
@end
