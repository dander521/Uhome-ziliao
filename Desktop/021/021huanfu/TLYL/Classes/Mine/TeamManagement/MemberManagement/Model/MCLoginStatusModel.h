//
//  MCLoginStatusModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCLoginStatusModel : NSObject
{
    NSArray *_UserIDList;//用户id数组

    
}
@property (nonatomic,strong) NSString *Num;
@property (nonatomic,strong) NSString *DateTime;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;
@end
