//
//  MCBasePWFModel.m
//  TLYL
//
//  Created by miaocai on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBasePWFModel.h"
@implementation MCShowBetModel
@end
@implementation MCItemModel
@end
@implementation MCBaseSelectedModel
@end

@implementation MCBasePWFModel

- (CGFloat)lineH{
    // 一行球个数
    CGFloat lineCount = 6;
    //间隙
    CGFloat padding = MC_REALVALUE(8);
//    CGFloat w = (G_SCREENWIDTH-padding*4-5*15)/6;
    CGFloat bw = MC_REALVALUE(40);
    if ([self.ballCount intValue]<1||!self.ballCount) {
        self.ballCount=@"1";
    }
    CGFloat h = ceilf([self.ballCount floatValue]/lineCount);
    if ([self.filterCriteria  isEqualToString: @"0"]) {
        if ([self.isShowSelectedCard isEqualToString:@"1"]) {
            return  MC_REALVALUE(34)+  h *bw  + (h + 1) * padding + MC_REALVALUE(70);
        }
        return  MC_REALVALUE(34)+  h *bw  + (h + 1) * padding;
    } else if([self.filterCriteria  isEqualToString: @"1"]){
        if ([self.isShowSelectedCard isEqualToString:@"1"]) {
            return  MC_REALVALUE(10) + h *bw  + (h + 1) * padding + MC_REALVALUE(44) + MC_REALVALUE(70);
        }
        return  MC_REALVALUE(10) + h *bw  + (h + 1) * padding + MC_REALVALUE(44);
    }else{
        return G_SCREENHEIGHT - MC_REALVALUE(114);
    }
    
}

+ (NSDictionary *)objectClassInArray
{
    
    return @{@"item" : [MCItemModel class],
             @"baseSelectedModel":[MCBaseSelectedModel class]
             };
    
} 

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


- (id)valueForUndefinedKey:(NSString *)key{
    return @"";
}


@end









