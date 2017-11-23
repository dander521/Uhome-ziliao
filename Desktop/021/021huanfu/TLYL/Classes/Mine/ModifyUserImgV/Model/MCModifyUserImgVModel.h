//
//  MCModifyUserImgVModel.h
//  TLYL
//
//  Created by MC on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
@interface MCModifyUserImgVModel : NSObject
singleton_h(MCModifyUserImgVModel)

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@property (nonatomic,strong) NSString * HeadPortrait;

@end


@interface MCUserImgVModel : NSObject

@property (nonatomic,strong) NSString * HeadPortrait;
@property (nonatomic,assign) BOOL isSelected;

@end
