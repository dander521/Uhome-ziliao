//
//  MCPeiESubTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPeiESubTableViewCell.h"
@interface MCPeiESubTableViewCell()
@property (nonatomic,weak) UILabel *numLabel;

@end
@implementation MCPeiESubTableViewCell

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
        make.left.equalTo(self.contentView).offset(MC_REALVALUE(20));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(23));
    }];
    UILabel *numLabelF = [[UILabel alloc] init];
    [self.contentView addSubview:numLabelF];
    numLabelF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    self.numLabeF = numLabelF;
    numLabelF.textAlignment = NSTextAlignmentCenter;
    numLabelF.textColor = RGB(153, 153, 153);
    [numLabelF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(MC_REALVALUE(-16));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(23));
    }];
}

- (void)setDataSource:(NSString *)dataSource{
    _dataSource = dataSource;
    self.numLabel.text = dataSource;
}
@end
