//
//  MCMMSaveModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMMSaveModel : NSObject
@property (nonatomic,assign)int ThisUserID;
@property (nonatomic,assign)int Rebate;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
