//
//  MCLoginModel.h
//  TLYL
//
//  Created by miaocai on 2017/7/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MCLoginModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
@property (nonatomic,strong) NSString *authCode;
@property (nonatomic,strong) NSString *GACode;
@property (nonatomic,strong) NSString *GAKey;
- (void)refreashDataAndShow;
- (instancetype)initWithUserName:(NSString *)userName passWord:(NSString *)passWord;

@end
