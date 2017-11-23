//
//  MCChartModel.h
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCChartModel : NSObject

@property (nonatomic,strong) NSString *UserID;
@property (nonatomic,strong) NSString *BeginTime;
@property (nonatomic,strong) NSString *EndTime;
@property (nonatomic,assign) int DataType;
@property (nonatomic,strong) NSString *Num;
@property (nonatomic,strong) NSString *DateTime;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

@end
