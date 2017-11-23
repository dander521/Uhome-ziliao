//
//  MCGetMerchantInfoModel.h
//  TLYL
//
//  Created by miaocai on 2017/7/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"



@interface MCGetMerchantInfoModel : NSObject

singleton_h(MCGetMerchantInfoModel)

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;
-(void)clearData;
@end
