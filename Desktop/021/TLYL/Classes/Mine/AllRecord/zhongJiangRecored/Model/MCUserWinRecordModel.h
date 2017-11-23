//
//  MCUserWinRecordModel.h
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUserWinRecordModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end

@interface MCUserWinRecordDataModel : NSObject
@property(nonatomic,strong) NSString * AwardMoney2;// = 2000;
@property(nonatomic,strong) NSString * BetsSumMoney;// = 2000;
@property(nonatomic,strong) NSArray * BtInfo;
@property(nonatomic,strong) NSString * DataCount;// 1;
@property(nonatomic,strong) NSString * FwinningSumMoney;// = 0;
@property(nonatomic,strong) NSString * Fwinningticket;// = 0;
@property(nonatomic,strong) NSString * PageCount;// = 1;
@property(nonatomic,strong) NSString * SettledNum;// = 1;
@property(nonatomic,strong) NSString * Tunbilled;// = 0;
@property(nonatomic,strong) NSString * TunbilledMoney ;//= 0;
@property(nonatomic,strong) NSString * Unbilled ;//= 0;
@property(nonatomic,strong) NSString * UnbilledMoney ;//= 0;
@property(nonatomic,strong) NSString * WinningSumMoney;// = 100;
@property(nonatomic,strong) NSString * Winningticket;// = 1;


@end
@interface MCUserWinRecordDetailDataModel : NSObject
@property(nonatomic,strong) NSString * AwardMoney;// = 100;
@property(nonatomic,strong) NSString * BetContent;// = "<null>";
@property(nonatomic,strong) NSString * BetInfo_ID;// = 54557;
@property(nonatomic,strong) NSString * BetMode;// = 32;
@property(nonatomic,strong) NSString * BetMoney;// = 2000;
@property(nonatomic,strong) NSString * BetMultiple;// = 1;
@property(nonatomic,strong) NSString * BetTb;// = 50;
@property(nonatomic,strong) NSString * CdrawTime;// = "2017-10-20 16:10:52";
@property(nonatomic,strong) NSString * ChaseOrderID;// = BGIv77E4OGbh16k;
@property(nonatomic,strong) NSString * DrawTime;// = "2017-10-20 16:10:52";
@property(nonatomic,strong) NSString * InsertTime ;//= "2017-10-20 16:10:52";
@property(nonatomic,strong) NSString * IssueNumber;// = 20171020161049690;
@property(nonatomic,strong) NSString * OrderID;// = BET154G10B8F8EV;
@property(nonatomic,strong) NSString * OrderState ;//= 17829888;
@property(nonatomic,strong) NSString * PlayCode;// = 5003;
@property(nonatomic,strong) NSString * UserName;// = canny;
@property(nonatomic,strong) NSString * User_ID;//" = 17225;

@end



















