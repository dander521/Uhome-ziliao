//
//  MCCloseReModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCloseReModel : NSObject
@property (nonatomic,assign) int ID;
@property (nonatomic,assign) int Status;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
