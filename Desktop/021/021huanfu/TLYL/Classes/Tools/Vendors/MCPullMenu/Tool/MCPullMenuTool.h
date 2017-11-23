//
//  MCPullMenuTool.h
//  TLYL
//
//  Created by MC on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCPullMenuTool : NSObject

+(NSMutableArray *)GetSelectedWFMarrayWithCZID:(NSString *)LotteryID;

+(void)SaveSelectedWFMarrayWithCZID:(NSString *)LotteryID andMarray:(NSMutableArray *)marray;

@end
