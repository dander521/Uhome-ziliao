//
//  MCUserDefinedLotteryCategoriesModel.h
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCPullMenuModel.h"

@interface MCUserDefinedLotteryCategoriesModel : MCCZHelperModel
/*
 * 彩种ID
 */
@property (nonatomic,strong)NSString *LotteryID;
//玩法ID
@property (nonatomic,strong)NSString *playOnlyNum;
//玩法一级ID
@property (nonatomic,strong)NSString *typeId;
/*
 * 是否被选中  0-未选中  1-选中
 */
@property (nonatomic,assign)NSInteger isSelected;

@property (nonatomic,strong)NSString * isShowType;


@property (nonatomic,assign)BOOL isCZselected;
/*
 * 彩种logo
 */

    
//"12": {
//    "tag": "cqssc",
//    "type": "ssc",
//    "name": "重庆时时彩",
//    "logo": "images/cqssc.png"
//},

//"SaleState": 1,
//"MaxRebate": 1956,
//"LotteryID": 4,
//"BetRebate": 1956

//参数名	类型	说明
//SaleState	int	当前彩种是否开售（1：开售，0：未开售）
//MaxRebate	int	当前彩种的最大可投注返点
//LotteryID	int	当前彩种的 ID 值
//BetRebate	int	当前彩种的投注返点

@property (nonatomic,strong) NSString *SaleState;
@property (nonatomic,strong) NSString *MaxRebate;
//@property (nonatomic,strong) NSString *LotteryID;
@property (nonatomic,strong) NSString *BetRebate;


+(MCUserDefinedLotteryCategoriesModel *)GetMCUserDefinedLotteryCategoriesModelWithCZID:(NSString *)CZID;
@end
















