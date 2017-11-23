//
//  MCPickBottomButton.m
//  TLYL
//
//  Created by miaocai on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPickBottomButton.h"

@implementation MCPickBottomButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    if (_img_Width&&_img_Height) {
        
        self.imageView.frame = CGRectMake(self.widht * 0.5- MC_REALVALUE(10), MC_REALVALUE(5), MC_REALVALUE(_img_Width), MC_REALVALUE(_img_Height));
        self.titleLabel.frame = CGRectMake(0, self.imageView.heiht + MC_REALVALUE(9), self.widht, MC_REALVALUE(14));
    }else{
        
        self.imageView.frame = CGRectMake(self.widht * 0.5- MC_REALVALUE(10), MC_REALVALUE(5), MC_REALVALUE(20), MC_REALVALUE(20));
        self.titleLabel.frame = CGRectMake(0, self.imageView.heiht + MC_REALVALUE(9), self.widht, MC_REALVALUE(14));
    }
    
}

@end
