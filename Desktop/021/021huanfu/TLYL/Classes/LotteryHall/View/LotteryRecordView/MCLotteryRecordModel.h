//
//  MCLotteryRecordModel.h
//  TLYL
//
//  Created by MC on 2017/7/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
@interface MCLotteryRecordModel : NSObject

{
    @public
    int _LotteryCode;
    int _Size;
    int _Page;
    Type_MCBet _type;
}
@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

- (void)refreashDataAndShow;

@property(nonatomic,strong)NSMutableArray * dataSource;
//	String	开奖号码
@property(nonatomic,strong) NSString * CzNum;

//	String	开奖期号
@property(nonatomic,strong) NSString * CzPeriod;


@end



/*
{
    "code": 200,
    "message": "成功",
    "data": [
             {
                 "CzNum":"5,2,8,6,9",
                 "CzPeriod":"20170717026"
             },
             {
                 "CzNum":"6,3,7,4,8",
                 "CzPeriod":"20170717025"
             },
             {
                 "CzNum":"6,1,4,8,0",
                 "CzPeriod":"20170717024"
             }
             ]
}


*/















