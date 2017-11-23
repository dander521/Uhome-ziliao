
//
//  MCWaterRippleButton.m
//  TLYL
//
//  Created by miaocai on 2017/6/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCWaterRippleButton.h"

@implementation MCWaterRippleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    [super sendAction:action to:target forEvent:event];
    
    for (int i = 0; i<3; i++) {
        
        UIView * cornerView = [[UIView alloc]initWithFrame:CGRectMake(G_SCREENWIDTH * 0.5 - self.bounds.size.height,0,self.bounds.size.height, self.bounds.size.height)];
        
        [cornerView setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5]];
        
        cornerView.layer.cornerRadius = self.bounds.size.height/2;
        
        [self addSubview:cornerView];
        
        cornerView.transform =CGAffineTransformMakeScale(0.5, 0.5);
        
        [UIView animateWithDuration:1
         
                              delay:0.1 * i
         
                            options:0
         
                         animations:^{
                             
                             cornerView.transform =CGAffineTransformMakeScale(2, 2);
                             
                             cornerView.alpha = 0;
                             
                         } completion:^(BOOL finished) {
                             
                             [cornerView removeFromSuperview];
                             
                         }];
        
        
    }
    

}



@end
