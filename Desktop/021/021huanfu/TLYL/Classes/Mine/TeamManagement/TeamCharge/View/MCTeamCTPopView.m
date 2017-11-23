//
//  MCTeamCTPopView.m
//  TLYL
//
//  Created by miaocai on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTeamCTPopView.h"

@implementation MCTeamCTPopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLab.text = @"用户名称";
        self.statusLabDetail.text = @"全部";
        self.statusLab.text = @"下级类型";
        self.statusLabDetail.text = @"全部";
        self.stValueLabel.text = @"当天记录";
        self.stLabel.text = @"记录选择";
    }
    return self;
}

@end
