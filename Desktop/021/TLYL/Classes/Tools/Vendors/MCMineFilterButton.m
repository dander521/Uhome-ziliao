//
//  MCMineFilterButton.m
//  TLYL
//
//  Created by miaocai on 2017/7/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineFilterButton.h"

@implementation MCMineFilterButton

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.centerY.equalTo(self);
        make.height.width.equalTo(@(14));
    }];

}

@end
