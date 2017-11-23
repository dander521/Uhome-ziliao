//
//  MCTeamVpopView.m
//  TLYL
//
//  Created by miaocai on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTeamVpopView.h"

@implementation MCTeamVpopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLab.text = @"用户名称";
        self.statusLab.text = @"账变类型";
        self.statusLabDetail.text = @"全部类型";
        self.stValueLabel.text = @"当前记录";
        self.stLabel.text = @"记录选择";
    }
    return self;
}


@end
