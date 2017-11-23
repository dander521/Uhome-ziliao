//
//  MCMesSendPersonTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMesSendPersonTableViewCell.h"

@interface MCMesSendPersonTableViewCell()

@property (nonatomic,weak) UIButton *btn;

@property (nonatomic,weak) UILabel *titleLabel;

@property (nonatomic,weak) UIImageView *imgV;

@end

@implementation MCMesSendPersonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{

    UIButton *btn = [[UIButton alloc] init];
    [self addSubview:btn];
    self.btn = btn;
    btn.frame = self.bounds;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    titleLabel.textColor = RGB(46, 46, 46);
    self.titleLabel = titleLabel;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(MC_REALVALUE(20)));
        make.centerY.equalTo(self);
    }];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [btn addSubview:imgV];
    self.imgV = imgV;
    imgV.image = [UIImage imageNamed:@"zhwxz"];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-MC_REALVALUE(23));
        make.centerY.equalTo(self);
        make.height.width.equalTo(@(MC_REALVALUE(15)));
    }];
    btn.selected = NO;
    [btn addTarget:self action:@selector(upBtnClick:) forControlEvents:UIControlEventTouchDown];
}

- (void)upBtnClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected == YES) {
        self.imgV.image = [UIImage imageNamed:@"zhxz"];
    } else {
        self.imgV.image = [UIImage imageNamed:@"zhwxz"];
    }
    self.dataSource.selected = btn.selected;
    if ([self.titleLabel.text isEqualToString:@"选择全部下级"] ) {
        if (self.selectedAllSubBlock) {
            self.selectedAllSubBlock(btn.selected);
        }
    } else {
        if (self.selectedSubBlock) {
            self.selectedSubBlock();
        }
    }
}

- (void)setDataSource:(MCEmailAllModel *)dataSource{
     _dataSource = dataSource;
    if ([dataSource.ChildUserName isEqualToString:@"选择全部下级"]) {
        self.titleLabel.textColor =RGB(144, 8, 215);
   
    } else {
       self.titleLabel.textColor = RGB(46, 46, 46);

    }
    self.titleLabel.text = dataSource.ChildUserName;
    self.btn.selected = dataSource.selected;
    if (dataSource.selected == YES) {
        self.imgV.image = [UIImage imageNamed:@"zhxz"];
    } else {
        self.imgV.image = [UIImage imageNamed:@"zhwxz"];
    }
 
}
- (void)setSelected:(BOOL)selected{}
- (void)setHighlighted:(BOOL)highlighted{}
@end
