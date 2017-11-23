//
//  MCKefuModel.h
//  TLYL
//
//  Created by miaocai on 2017/8/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCKefuModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;


@end
