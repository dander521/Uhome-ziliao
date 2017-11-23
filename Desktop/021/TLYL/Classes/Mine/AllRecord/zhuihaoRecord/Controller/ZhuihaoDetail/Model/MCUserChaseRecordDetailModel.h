//
//  MCUserChaseRecordDetailModel.h
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUserChaseRecordDetailModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;


@end

//LotteryCode	是	Int	彩种编码
//IsHistory	是	Boolean	是否为历史记录
//InsertTime	是	String	订单时间（如：2017/07/31 08:54:00）
//ChaseOrderID	是	String	订单号
@interface MCUserChaseRecordDetailDataModel : NSObject

@property (nonatomic,strong) NSArray * Bet;
@property (nonatomic,strong) NSString * BetRebate;// = 1956;
@property (nonatomic,strong) NSString * LotteryCode;// = 66;
@property (nonatomic,strong) NSString * SumBetMoney;// = 20;

//{
//    Bet =     (
//               {
//                   AwContent = "";
//                   AwMoney = "0.0000";
//                   AwTime = "";
//                   AwardTime = "";
//                   BetContent = "2|3|0";
//                   BetCount = 1;
//                   BetEndTime = "2017-10-18 10:06:00";
//                   BetMode = 34;
//                   BetMoney = "2.0000";
//                   BetMultiple = 1;
//                   BetOrderState = 1048577;
//                   BetRebate = 0;
//                   BetTime = "2017-10-18 10:05:03";
//                   ChaseOrderID = BGIojp0dle6TX2M;
//                   DrawContent = "";
//                   InsertTime = "2017-10-18 10:05:03";
//                   IssueNumber = 20171018404;
//                   OrderID = BETHAX5HNL4C603;
//                   PlayCode = 6603;
//                   Remark = "";
//               }
//               );
//    BetRebate = 1956;
//    LotteryCode = 66;
//    SumBetMoney = 20;
//}

@end

@interface MCUserChaseRecordDetailSubDataModel : NSObject

@property (nonatomic,strong)NSString *AwContent;// = "";
@property (nonatomic,strong)NSString *AwMoney ;//= "0.0000";
@property (nonatomic,strong)NSString *AwTime ;//= "";
@property (nonatomic,strong)NSString *AwardTime;// = "";
@property (nonatomic,strong)NSString *BetContent ;//= "2|3|0";
@property (nonatomic,strong)NSString *BetCount ;//= 1;//注数
@property (nonatomic,strong)NSString *BetEndTime ;//= "2017-10-18 10:06:00";
@property (nonatomic,strong)NSString *BetMode ;//= 34;
@property (nonatomic,strong)NSString *BetMoney ;//= "2.0000";
@property (nonatomic,strong)NSString *BetMultiple;// = 1;
@property (nonatomic,strong)NSString *BetOrderState ;//= 1048577;
@property (nonatomic,strong)NSString *BetRebate ;//= 0;
@property (nonatomic,strong)NSString *BetTime ;//= "2017-10-18 10:05:03";
@property (nonatomic,strong)NSString *ChaseOrderID ;//= BGIojp0dle6TX2M;
@property (nonatomic,strong)NSString *DrawContent ;//= "";开奖号码
@property (nonatomic,strong)NSString *InsertTime ;//= "2017-10-18 10:05:03";
@property (nonatomic,strong)NSString *IssueNumber ;//= 20171018404;
@property (nonatomic,strong)NSString *OrderID ;//= BETHAX5HNL4C603;
@property (nonatomic,strong)NSString *PlayCode ;//= 6603;
@property (nonatomic,strong)NSString *Remark ;//= "";

@end


//DrawContent    String    开奖号码
//OrderID    String    流水号
//BetOrderState    Int    订单状态 见投注详情-备注1
//AwMoney    Number    中奖奖金
//AwContent    String    中奖注数
//AwTime    String    中奖时间
//BetTime    String    投注时间
//ChaseOrderID    String    订单号
//PlayCode    Int    玩法ID
//BetContent    String    投注内容
//BetCount    Int    投注注数
//IssueNumber    String    投注期号
//BetMultiple    Int    投注倍数
//BetMoney    Number    投注金额
//BetMode    Int    投注模式 见备注1











