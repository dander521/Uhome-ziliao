//
//  MCBetModel.h
//  TLYL
//
//  Created by MC on 2017/7/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
static BOOL _firstResbanderZhuiHaoView;
@interface MCBetModel : NSObject

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,id errorCode);

- (void)refreashDataAndShow;

- (instancetype)initWithDic:(NSDictionary *)dic;

@end
//========================MMC======================
//LotteryCode	是	Int	彩种编码
//Bet	是	Array	投注实体，一个Object代表一单
//BetContent	是	String	投注内容
//BetCount	是	String	投注注数
//PlayCode	是	String	玩法编码
//IssueNumber	是	String	投注期号（传空字符串）
//BetRebate	是	String	投注返点
//BetMoney	是	String	投注金额
//BetMultiple	是	String	投注倍数
//BetMode	是	Int	投注模式（见备注 1）
/*
{
    "LotteryCode" : "50",
    "Bet" : [
             {
                 "BetContent" : "2|7|7",
                 "BetCount" : "1",
                 "PlayCode" : "5003",
                 "IssueNumber" : "",
                 "BetRebate" : "1956",
                 "BetMoney" : "2",
                 "BetMultiple" : "1",
                 "BetMode" : 0
             }
             ]
}
*/

//========================Other======================
//LotteryCode	是	Int	彩种编码
//IssueList	追号时必传，非追号不传	Object	期号列表｛key:期号，value：投注倍数｝
//UserBetInfo	是	Object	投注信息
//Bet	是	Array	投注实体，一个Object代表一单
//BetContent	是	String	投注内容
//BetCount	是	String	投注注数
//PlayCode	是	String	玩法编码
//IssueNumber	是	String	投注期号
//BetRebate	是	String	投注返点
//BetMoney	是	String	投注金额
//BetMultiple	是	String	投注倍数
//BetMode	是	Int	玩法模式（见备注1）
/*
"params":{
    "UserBetInfo":{
        "LotteryCode":12,
        "Bet":[
               {
                   "BetContent":"5|9|1",
                   "BetCount":"1",
                   "PlayCode":"1203",
                   "IssueNumber":"20170720061",
                   "BetRebate":"1956",
                   "BetMoney":"2",
                   "BetMultiple":"1",
                   "BetMode":0
               }
               ]
    }
}
*/
















