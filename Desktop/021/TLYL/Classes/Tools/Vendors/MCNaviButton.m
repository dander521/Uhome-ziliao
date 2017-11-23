
//
//  MCNaviButton.m
//  TLYL
//
//  Created by miaocai on 2017/7/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNaviButton.h"

@implementation MCNaviButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.widht - 10, self.heiht);
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(10);
        make.centerY.equalTo(self);
        make.height.width.equalTo(@(15));
    }];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
}

@end
