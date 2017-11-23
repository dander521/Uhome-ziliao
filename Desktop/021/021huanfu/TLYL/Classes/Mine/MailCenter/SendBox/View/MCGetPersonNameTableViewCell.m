//
//  MCGetPersonNameTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGetPersonNameTableViewCell.h"
@interface MCGetPersonNameTableViewCell()
@property (nonatomic,weak) UILabel *titleLabel;
@property (nonatomic,weak) UILabel *statusLabel;
@end
@implementation MCGetPersonNameTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    titleLabel.textColor = RGB(46, 46, 46);
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(MC_REALVALUE(20)));
        make.centerY.equalTo(self);
    }];
    
    
    UILabel *statusLabel = [[UILabel alloc] init];
    [self addSubview:statusLabel];
    statusLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    statusLabel.textColor = RGB(46, 46, 46);
    self.statusLabel = statusLabel;
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(MC_REALVALUE(-20)));
        make.centerY.equalTo(self);
    }];
}
- (void)setDataSource:(MCEmailReceiverModel *)dataSource{
    _dataSource = dataSource;
    self.titleLabel.text = dataSource.ReceivePerson;
    if (dataSource.EmailState == 1) {
        self.statusLabel.text = @"已读";
        self.statusLabel.textColor = RGB(144, 8, 215);
    } else {
         self.statusLabel.text = @"未读";
        self.statusLabel.textColor = RGB(255, 168, 0);
    }
   
}
@end
