//
//  MCMCZhuihaoRecordDetailViewController.h
//  TLYL
//
//  Created by MC on 2017/10/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserChaseRecordModel.h"

@interface MCMCZhuihaoRecordDetailViewController : UIViewController

@property (nonatomic,strong)MCUserChaseRecordDataModel * model;
@property (nonatomic,assign)BOOL IsHistory;
//LotteryCode	是	Int	彩种编码
//IsHistory	是	Boolean	是否为历史记录
//InsertTime	是	String	订单时间（如：2017/07/31 08:54:00）
//ChaseOrderID	是	String	订单号
@end
