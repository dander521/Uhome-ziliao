//
//  MCRandomUntits.h
//  TLYL
//
//  Created by MC on 2017/6/28.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBasePWFModel.h"

#define MCRandomKl8(WFmodel,type) [MCRandomUntits Get_Kl8RandomArrWithModel:WFmodel andType:type]
@interface MCRandomUntits : NSObject
typedef NS_ENUM(NSInteger, Type_WF) {
    DaXiaoDanShuang=0,//大小单双@[@"大",@"小"@"单",@"双"]
    DanShuang,//单双 @[@"单",@"双"]
    HeZhiDaXiao,//和值大小@[@"大",@"小",@"和"];
    HeZhiDaXiaoDanShuang,//和值大小单双@[@"大单",@"大双",@"小单",@"小双"]
    WuXing,//五行@[@"金",@"木",@"水",@"火",@"土"]
    JiOuPan,//奇偶盘@[@"奇",@"偶",@"和"]
    ShangXiaPan,//上下盘@[@"上",@"下",@"中"]
    SanTongHaoDanXuan,//三同号单选@[@"111",@"222",@"333",@"444",@"555",@"666"]
    ERTongHaoFuXuan,//二同号复选@[@"11*",@"22*",@"33*",@"44*",@"55*",@"66*"]
    DaXiao,//@[@"大",@"小"];
    LongHu,//@[@"龙",@"虎"];
    TeShuHao1,//@[@"豹子",@"顺子",@"对子",@"半顺",@"杂六"]
    LongHu2,//@[@[ @"1V2"],@[@"1V3" ],@[ @"1V4"],@[@"1V5" ],@[ @"1V6"],@[@"1V7"],@[@"1V8"],@[@"2V3"],@[@"2V4"],@[@"2V5"],@[@"2V6"],@[@"2V7"],@[@"2V8"],@[@"3V4"],@[@"3V5"],@[@"3V6"],@[@"3V7"],@[@"3V8"],@[@"4V5"],@[@"4V6"],@[@"4V7"],@[@"4V8"],@[@"5V6"],@[@"5V7"],@[@"5V8"],@[@"6V7"],@[@"6V8"],@[@"7V8"]]
    DaXiaoDanShuang2,//@[@[@"大" ],@[@"小" ],@[@"单" ],@[ @"双"],@[@"尾大" ],@[@"尾小" ],@[@"和单" ],@[ @"和双"]]
    ChunXiaQiuDongSiJiFangWei,//@[@[@"春" ],@[@"夏" ],@[@"秋" ],@[ @"冬"],@[@"东" ],@[@"南" ],@[@"西" ],@[ @"北"]]
    
};
/*
 * 返回格式： @[@[@"1"],@[@"2",@"3"]]
 * 数组里的顺序  对应  UI的上下顺序
 */
+(NSMutableArray * )Get_RandomArrWithModel:(MCBasePWFModel *)WFmodel;

/*
 * 传入 【行数】 【每一行选的个数】  返回一个数组
 */
+(NSMutableArray *)Get_MarrWithLinCount:(int)lineCount andBallCount:(int)ballCount andMin:(int)min andMax:(int)max  andModel:(MCBasePWFModel *)WFmodel;

+(NSMutableArray *)Get_MarrWithLinCount:(int)lineCount andBallCount:(int)ballCount andMin:(int)min andMax:(int)max andJIOU:(int)isJorOu  andModel:(MCBasePWFModel *)WFmodel;
/*
 * 快乐8   专用
 */
+(NSMutableArray * )Get_Kl8RandomArrWithModel:(MCBasePWFModel *)WFmodel andType:(NSString *)type;
    
@end


















