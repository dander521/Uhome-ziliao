//
//  MCZhuanRecordModel.h
//  TLYL
//
//  Created by miaocai on 2017/11/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCZhuanRecordModel : NSObject
{
@public
    NSString *_UserID;
    NSString *_InsertTimeMin;
    NSString *_InsertTimeMax;
    int _TransferType1;
    int _CurrentPageIndex;
    int _CurrentPageSize;
    BOOL _IsHistory;
}

@property (nonatomic,strong) NSString *UserName;
@property (nonatomic,strong) NSString *OrderId;
@property (nonatomic,strong) NSString *InsertTime;
@property (nonatomic,strong) NSString *DetailsSource;
@property (nonatomic,strong) NSString *TransferType;
@property (nonatomic,strong) NSString *Marks;
@property (nonatomic,strong) NSNumber *TransferMoney;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSDictionary *errorCode);

- (void)refreashDataAndShow;
@end
