//
//  MCButton.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCButton.h"

@implementation MCButton

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake((self.widht- MC_REALVALUE(25))*0.5, 5, MC_REALVALUE(25), MC_REALVALUE(25));
    self.titleLabel.frame = CGRectMake(0, MC_REALVALUE(35), self.widht, 10);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
