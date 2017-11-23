//
//  MCGetIPAdress.h
//  TLYL
//
//  Created by miaocai on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCGetIPAdress : NSObject
+ (NSDictionary *)getIPAddresses;
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
@end
