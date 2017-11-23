//
//  MCLotteryHallModel.h
//  TLYL
//
//  Created by miaocai on 2017/7/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCMineHeader.h"
#define MCNickName @"MCNickName"
@interface MCMineInfoModel : NSObject
singleton_h(MCMineInfoModel)

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);
@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);
- (void)refreashDataAndShow;


/**UserName	string	用户名 / 登录名*/
@property (nonatomic,strong) NSString *UserName;
/**UserID	int	登录用户ID*/
@property (nonatomic,strong) NSString *UserID;
/**UserRealName	string	用户真实姓名*/
@property (nonatomic,strong) NSString *UserRealName;
/**UserNickName	string	用户昵称*/
@property (nonatomic,strong) NSString *UserNickName;
/**UserType	int	0为正式账户，1为试玩账户*/
@property (nonatomic,strong) NSString *UserType;
/**HeadPortrait	string	用户头像*/
@property (nonatomic,strong) NSString *HeadPortrait;
/**EMail	string	用户邮箱*/
@property (nonatomic,strong) NSString *EMail;
/**QQ	string	用户QQ*/
@property (nonatomic,strong) NSString *QQ;
/**Mobile	string	用户手机号码*/
@property (nonatomic,strong) NSString *Mobile;
/**BankCode	string	用户默认银行代号*/
@property (nonatomic,strong) NSString *BankCode;
/**BankCardNumber	string	用户默认银行卡号*/
@property (nonatomic,strong) NSString *BankCardNumber;
/**IsAgent	boolean	是否为代理*/
@property (nonatomic,assign) BOOL IsAgent;
/**IsDividend	boolean	是否签约分红*/
@property (nonatomic,assign) BOOL IsDividend;
/**IsDayWages	boolean	是否签约日工资*/
@property (nonatomic,assign) BOOL IsDayWages;
/**IsShowTran	int	是否有权限给下级转账，1有，0无*/
@property (nonatomic,strong) NSString *IsShowTran;
/**DrawBeginTime	string	提款开始时间*/
@property (nonatomic,strong) NSString *DrawBeginTime;
/**DrawEndTime	string	提款结束时间*/
@property (nonatomic,strong) NSString *DrawEndTime;
/**DrawMaxMoney	int	提款金额上限*/
@property (nonatomic,strong) NSString *DrawMaxMoney;
/**DrawMinMoney	int	提款金额下限*/
@property (nonatomic,strong) NSString *DrawMinMoney;
/**MyRebate	int	我（当前登录用户）的返点*/
@property (nonatomic,strong) NSString *MyRebate;
/**HuiRebate	int	会员返点（注册下级时）*/
@property (nonatomic,strong) NSString *HuiRebate;
/**AgentRebate	int	代理返点（注册下级时）*/
@property (nonatomic,strong) NSString *AgentRebate;
/**MaxAllowRebate	int	前台开户，允许返点最大值*/
@property (nonatomic,strong) NSString *MaxAllowRebate;
/**GapRebate	int	相邻返点差值*/
@property (nonatomic,strong) NSString *GapRebate;
/**MyRebateDifference	int	返点差值*/
@property (nonatomic,strong) NSString *MyRebateDifference;
/**UserLevel	int	站内信收件判断是否有上级，1无上级，其他有上级*/
@property (nonatomic,strong) NSString *UserLevel;
/**ChildCount	int	直属下级个数*/
@property (nonatomic,strong) NSString *ChildCount;
/**TeamMemberCount	int	团队个数*/
@property (nonatomic,strong) NSString *TeamMemberCount;

@property (nonatomic,strong)NSString *LotteryMoney;//	String	用户余额
@property (nonatomic,strong)NSString *FreezeMoney	;//String	冻结金额

@end
/*
{
    code = 200;
    data =     {
        AgentRebate = 1956;
        BankCardNumber = 12345678945621023;
        BankCode = comm;
        ChildCount = 21;
        CommonFlag = 11;
        DrawBeginTime = 0;
        DrawEndTime = 0;
        DrawMaxMoney = 6000;
        DrawMinMoney = 1;
        EMail = "";
        GapRebate = 2;
        HeadPortrait = 6;
        HuiRebate = 1956;
        IsAgent = 1;
        IsDayWages = 0;
        IsDividend = 0;
        IsShowTran = 1;
        IsVerified = 0;
        MaxAllowRebate = 1956;
        Mobile = 12345679855;
        MyRebate = 1956;
        MyRebateDifference = 156;
        MyUserID = 16731;
        QQ = "";
        StopAddChild = 0;
        StopTran = 0;
        StopWithdrawals = 0;
        TeamMemberCount = 25;
        UserLevel = 1;
        UserNickName = kakaNick;
        UserRealName = kaka;
        UserType = 0;
    };
    message = "\U67e5\U8be2\U6210\U529f";
}
*/
