//
//  BKIndicationView.m
//  TLYL
//
//  Created by MC on 2017/10/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//


#import "BKIndicationView.h"

@implementation BKIndicationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = RGB(143, 0, 210);
        self.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
        
    }
    return self;
}

+ (instancetype)sharedView
{
    static BKIndicationView *indicationView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicationView = [[self alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT)];
        indicationView.center = CGPointMake(G_SCREENWIDTH/2, G_SCREENHEIGHT/2-32);
    });
    return indicationView;
}


+(void)showInView:(UIView *)view{
    
    [[BKIndicationView sharedView] startAnimating];
    [view addSubview:[BKIndicationView sharedView]];
}

+(instancetype)sharedViewWithCenter:(CGPoint)point{
    static BKIndicationView *indicationView;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        indicationView = [[self alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT)];
        indicationView.center = point;
    });
    return indicationView;
}
+(void)showInView:(UIView *)view Point:(CGPoint)point{
    
    [[BKIndicationView sharedViewWithCenter:point] startAnimating];
    [view addSubview:[BKIndicationView sharedViewWithCenter:point]];
}
+(void)dismissWithCenter:(CGPoint)point{
    [[BKIndicationView sharedViewWithCenter:point] stopAnimating];
    [[BKIndicationView sharedViewWithCenter:point] removeFromSuperview];
}

+(void)dismiss{
    
    [[BKIndicationView sharedView] stopAnimating];
    [[BKIndicationView sharedView] removeFromSuperview];
    
}

@end
