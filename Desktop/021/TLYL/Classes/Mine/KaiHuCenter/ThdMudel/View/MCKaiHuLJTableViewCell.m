//
//  MCKaiHuLJTableViewCell.m
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKaiHuLJTableViewCell.h"

@interface MCKaiHuLJTableViewCell()

@property (nonatomic,weak) UILabel *urlLabel;
@end

@implementation MCKaiHuLJTableViewCell

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
    numLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    numLabel.backgroundColor = [UIColor orangeColor];
    numLabel.layer.cornerRadius = MC_REALVALUE(13.5);
    numLabel.clipsToBounds = YES;
    self.numLabel = numLabel;
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.textColor = [UIColor whiteColor];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(MC_REALVALUE(22));
        make.top.equalTo(self.contentView).offset(MC_REALVALUE(0));
        make.width.height.equalTo(@(MC_REALVALUE(27)));
    }];
    
    UIButton *btnCopy = [[UIButton alloc] init];
    [self.contentView addSubview:btnCopy];
    [btnCopy setTitle:@"复制" forState:UIControlStateNormal];
    [btnCopy setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btnCopy.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [btnCopy addTarget:self action:@selector(btnCopyClick) forControlEvents:UIControlEventTouchUpInside];
    [btnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(MC_REALVALUE(-21));
        make.centerY.equalTo(numLabel);
        make.width.equalTo(@(MC_REALVALUE(30)));
        
    }];
    
    UILabel *urlLabel = [[UILabel alloc] init];
    [self.contentView addSubview:urlLabel];
    urlLabel.textColor = RGB(46, 46, 46);
    self.urlLabel = urlLabel;
    urlLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(numLabel.mas_right).offset(MC_REALVALUE(20));
        make.centerY.equalTo(numLabel);
        make.right.equalTo(btnCopy.mas_left).offset(MC_REALVALUE(22));
        
    }];
    
 
}
-(void)setDataSource:(MCRegisteredLinksModel *)dataSource{
    _dataSource = dataSource;
    self.urlLabel.text = dataSource.RegistUrl;
    if (dataSource.Status == 1) {
        self.numLabel.backgroundColor = [UIColor orangeColor];
    } else {
        self.numLabel.backgroundColor = RGB(181, 181, 181);
    }

}
- (void)btnCopyClick{
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.urlLabel.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
    }
}

@end
