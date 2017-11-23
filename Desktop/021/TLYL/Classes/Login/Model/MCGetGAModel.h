//
//  MCGetGAModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCGetGAModel : NSObject
@property (nonatomic,strong) NSString *UserName;
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;
@property (nonatomic,strong) NSString *VerificationKey;
@property (nonatomic,strong) NSString *VerificationMode;
@end
