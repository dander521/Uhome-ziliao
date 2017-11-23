//
//  MCFirstKaiHuModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCFirstKaiHuModel : NSObject

@property (nonatomic,strong) NSString *subUserName;
@property (nonatomic,strong) NSString *Password;
@property (nonatomic,assign) int Rebate;
@property (nonatomic,assign) BOOL IsAgent;
@property (nonatomic,assign) BOOL RegistChild;


@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);
- (void)refreashDataAndShow;
@end
