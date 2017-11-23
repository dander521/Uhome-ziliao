//
//  MCFindPasswordHeaderView.m
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCFindPasswordHeaderView.h"

@implementation MCFindPasswordHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    
    self.backgroundColor = [UIColor clearColor];
    
    
}

+(CGFloat)computeHeight:(id)info{
    return 250;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
