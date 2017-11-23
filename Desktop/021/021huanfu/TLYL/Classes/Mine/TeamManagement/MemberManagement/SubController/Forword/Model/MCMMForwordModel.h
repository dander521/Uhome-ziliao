//
//  MCMMForwordModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMMForwordModel : NSObject

@property (nonatomic,strong)NSString *TransferMoney;
@property (nonatomic,strong)NSString *TargetUserID;
@property (nonatomic,strong)NSString *TargetUserName;
@property (nonatomic,strong)NSString *Password;
@property (nonatomic,strong)NSString *Mark;



@property(nonatomic,strong) void(^callBackSuccessBlock)(ApiBaseManager *manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
