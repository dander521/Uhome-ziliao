//
//  MCPeiHuFirTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPeiHuFirTableViewCell.h"
@interface MCPeiHuFirTableViewCell()

//返点
@property (nonatomic,weak) UILabel *numLabeF;
//人数限制
@property (nonatomic,weak) UILabel *numLabeR;
//已注册人数
@property (nonatomic,weak) UILabel *numLabeY;

@end
@implementation MCPeiHuFirTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self==[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *numLabel = [[UILabel alloc] init];
    [self.contentView addSubview:numLabel];
    numLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.numLabel = numLabel;
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = RGB(46, 46, 46);
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MC_REALVALUE(10));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(17));
        make.width.equalTo(@(MC_REALVALUE(50)));
    }];
    
    UILabel *numLabelF = [[UILabel alloc] init];
    [self.contentView addSubview:numLabelF];
    numLabelF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.numLabeF = numLabelF;
    numLabelF.textAlignment = NSTextAlignmentCenter;
    numLabelF.textColor = RGB(46, 46, 46);
    [numLabelF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabel.mas_right).offset(MC_REALVALUE(0));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(17));
        make.width.equalTo(@(MC_REALVALUE(95)));
        
    }];
    UILabel *numLabelR = [[UILabel alloc] init];
    [self.contentView addSubview:numLabelR];
    numLabelR.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.numLabeR = numLabelR;
    numLabelR.textAlignment = NSTextAlignmentCenter;
    numLabelR.textColor = RGB(46, 46, 46);
    [numLabelR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabelF.mas_right).offset(MC_REALVALUE(0));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(17));
        make.width.equalTo(@(MC_REALVALUE(100)));
        
    }];
    UILabel *numLabelY = [[UILabel alloc] init];
    [self.contentView addSubview:numLabelY];
    numLabelY.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.numLabeY = numLabelY;
    numLabelY.textAlignment = NSTextAlignmentCenter;
    numLabelY.textColor = RGB(144, 8, 215);
    [numLabelY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabelR.mas_right).offset(MC_REALVALUE(0));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(17));
        make.width.equalTo(@(G_SCREENWIDTH - (MC_REALVALUE(100 + 95 + 60 - 26))));
    }];
}

- (void)setDataSource:(MCPeiEFModel *)dataSource{
    _dataSource = dataSource;
    self.numLabeF.text = [NSString stringWithFormat:@"%d",dataSource.Rebate];
    if (dataSource.Capacity == -1) {
        self.numLabeR.text = @"无限制";
    } else {
        self.numLabeR.text = [NSString stringWithFormat:@"%d",dataSource.Capacity];
    }
    
    self.numLabeY.text = [NSString stringWithFormat:@"%d",dataSource.RegisNum];
}
@end
