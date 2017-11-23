//
//  MCInBoxTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCInBoxTableViewCell.h"

@interface MCInBoxTableViewCell()
//*icon/
@property (nonatomic,weak) UIImageView *imgV;
//*主题/
@property (nonatomic,weak) UILabel *titleLabel;
//*日期/
@property (nonatomic,weak) UILabel *dateLabel;
//*内容/
@property (nonatomic,weak) UILabel *contentLabel;

@end

@implementation MCInBoxTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    UIImageView *imgV = [[UIImageView alloc] init];
    [self.contentView addSubview:imgV];
//    xx-wdxxx
    imgV.image = [UIImage imageNamed:@"xx-ydxx"];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MC_REALVALUE(20));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(18));
        make.height.width.equalTo(@(MC_REALVALUE(30)));
        
    }];
    self.imgV = imgV;
    UILabel *titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:titleLabel];
    titleLabel.text = @"加载中";
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    titleLabel.textColor = RGB(46, 46, 46);
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).offset(MC_REALVALUE(8));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(17));
        make.right.equalTo(self.contentView).offset(MC_REALVALUE(-8));
    }];
    self.titleLabel = titleLabel;

    UILabel *contentLabel = [[UILabel alloc] init];
    [self.contentView addSubview:contentLabel];
    contentLabel.text = @"加载中";
    contentLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
    contentLabel.textColor = RGB(136, 136, 136);
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(MC_REALVALUE(-20));
        make.left.equalTo(imgV.mas_right).offset(MC_REALVALUE(8));
        make.top.equalTo(titleLabel.mas_bottom).offset(MC_REALVALUE(8));
        
    }];
    self.contentLabel = contentLabel;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    [self.contentView addSubview:dateLabel];
    dateLabel.text = @"加载中";
    dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
    dateLabel.textColor = RGB(136, 136, 136);
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(MC_REALVALUE(-20));
        make.centerY.equalTo(contentLabel);
        
    }];
     self.dateLabel = dateLabel;
}
#pragma mark 
- (void)setDataSource:(MCEmailListModel *)dataSource{
    
    _dataSource = dataSource;
    self.titleLabel.text = dataSource.Title;
    self.dateLabel.text = dataSource.SendDateTime;
    NSString *str = @"";
    if (dataSource.SendPersonLevel == 3){
        str = @"系统消息";
    } else if (dataSource.SendPersonLevel == 2){
        str = @"上级";
    } else{
        str = dataSource.SendPerson;
    }
    self.contentLabel.text = [NSString stringWithFormat:@"发件人：%@",str];
    if (dataSource.EmailState == 1) {
        self.imgV.image = [UIImage imageNamed:@"xx-wdxxx"];
    } else {
        self.imgV.image = [UIImage imageNamed:@"xx-ydxx"];
        
    }
    
}

- (void)setDataSourceSend:(MCSendListModel *)dataSourceSend{
    _dataSourceSend = dataSourceSend;
    self.titleLabel.text = dataSourceSend.Title;
    self.dateLabel.text = dataSourceSend.SendDateTime;
    NSString *str = @"";
    if (dataSourceSend.SendPersonLevel == 1){
        str = @"上级";
    } else{
        str = @"下级";
    }
    self.contentLabel.text = [NSString stringWithFormat:@"收件人：%@",str];
    self.imgV.image = [UIImage imageNamed:@"xx-wdxxx"];
}
@end
