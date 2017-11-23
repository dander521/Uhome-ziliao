//
//  MCRandomUntits.m
//  TLYL
//
//  Created by MC on 2017/6/28.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRandomUntits.h"

#define DifMCRandomC(first,second,min,max,WFmodel) [MCRandomUntits Get_MarrWithFirst:first andSecond:second andMin:min andMax:max andModel:WFmodel]

#define MCRandomWF(type) [MCRandomUntits Get_RondomMarrWithType:type]

#define MCRandomC(lineCount,ballCount,min,max,WFmodel)  [MCRandomUntits Get_MarrWithLinCount:lineCount andBallCount:ballCount andMin:min andMax:max andModel:WFmodel]
@implementation MCRandomUntits
/*
 * 返回格式： @[@[@"1"],@[@"2",@"3"]]
 *
 */
+(NSMutableArray * )Get_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr=[[NSMutableArray alloc]init];

    NSDictionary * dic_CZ=@{
                            @"esf":@"1",@"ssc":@"2",@"k3":@"3",@"kl8":@"4",@"sd":@"5",@"pks":@"6",@"ssl":@"7",@"pls":@"8",@"plw":@"9",@"klsf":@"10"
                            };
    NSInteger  cZNumber= [[dic_CZ  objectForKey:WFmodel.lotteryCategories] integerValue];
    switch (cZNumber) {
#pragma-mark 11选5
        case  1:
            marr= [MCRandomUntits Get_esf_RandomArrWithModel:WFmodel];
            break;
#pragma-mark 时时彩
        case  2:
            marr= [MCRandomUntits Get_ssc_RandomArrWithModel:WFmodel];
            break;
#pragma-mark 快3
        case  3:

            marr= [MCRandomUntits Get_k3_RandomArrWithModel:WFmodel];
            break;
#pragma mark-快乐8
        case  4:

            marr= [MCRandomUntits Get_kl8_RandomArrWithModel:WFmodel];
            break;
#pragma-mark 3D
        case  5:

            marr= [MCRandomUntits Get_sd_RandomArrWithModel:WFmodel];
            break;
#pragma-mark PK拾
        case  6:

            marr= [MCRandomUntits Get_pks_RandomArrWithModel:WFmodel];
            break;
#pragma-mark 时时乐
        case  7:

            marr= [MCRandomUntits Get_ssl_RandomArrWithModel:WFmodel];
            break;
#pragma-mark 排列三
        case  8:

            marr= [MCRandomUntits Get_pl3_RandomArrWithModel:WFmodel];
            break;
#pragma-mark 排列五
        case  9:

            marr= [MCRandomUntits Get_pl5_RandomArrWithModel:WFmodel];
            break;
#pragma-mark 快乐十分
        case  10:
        marr= [MCRandomUntits Get_klsf_RandomArrWithModel:WFmodel];
        break;
        default:
            break;
    }


    return marr;
}

#pragma mark-11选5
+(NSMutableArray *)Get_esf_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    int min=1,max=11;
    NSMutableArray * marr=[[NSMutableArray alloc]init];

    if ([WFmodel.playOnlyNum integerValue]==10001) {
        
        marr= MCRandomC(3, 1, min, max,WFmodel);
        
    }else if([WFmodel.playOnlyNum integerValue]==12001||[WFmodel.playOnlyNum integerValue]==14001){
        
        marr= MCRandomC(1, 3, min, max,WFmodel);
        
    }else if([WFmodel.playOnlyNum integerValue]==17001){
        
        marr= MCRandomC(2, 1, min, max,WFmodel);
        
    }else if([WFmodel.playOnlyNum integerValue]==19001||[WFmodel.playOnlyNum integerValue]==21001){
        
        marr= MCRandomC(1, 2, min, max,WFmodel);
        
    }else if([WFmodel.playOnlyNum integerValue]==24001||[WFmodel.playOnlyNum integerValue]==26001){
        
        marr= MCRandomC(1, 1, min, max,WFmodel);
        
    }else if([WFmodel.typeId integerValue]==6){//任选复式
        int n=([WFmodel.playOnlyNum intValue]-28000)/1000;
        marr= MCRandomC(1, n, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==25001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:3 andBallCount:1 andMin:min andMax:max andWei:1 andModel:WFmodel];
    }
    return marr;
    
}
#pragma mark-时时彩
+(NSMutableArray *)Get_ssc_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    int min=0,max=9;
    NSMutableArray * marr=[[NSMutableArray alloc]init];

    if ([WFmodel.playOnlyNum integerValue]==10001) {
        
        marr= MCRandomC(5, 1, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        
        marr= MCRandomC(1, 5, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==13001){
        
        marr=DifMCRandomC(1, 3, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        
        marr=DifMCRandomC(2, 1, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==15001||[WFmodel.playOnlyNum integerValue]==22001||[WFmodel.playOnlyNum integerValue]==107001){
        
        marr=DifMCRandomC(1, 2, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==27001||[WFmodel.playOnlyNum integerValue]==38001||[WFmodel.playOnlyNum integerValue]==49001||[WFmodel.playOnlyNum integerValue]==96001){
        
        marr= MCRandomC(1, 1, 0, 27,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==28001||[WFmodel.playOnlyNum integerValue]==39001||[WFmodel.playOnlyNum integerValue]==50001||[WFmodel.playOnlyNum integerValue]==32001||[WFmodel.playOnlyNum integerValue]==34001||[WFmodel.playOnlyNum integerValue]==43001||[WFmodel.playOnlyNum integerValue]==45001||[WFmodel.playOnlyNum integerValue]==54001||[WFmodel.playOnlyNum integerValue]==56001||[WFmodel.playOnlyNum integerValue]==61001||[WFmodel.playOnlyNum integerValue]==68001||[WFmodel.playOnlyNum integerValue]==71001||[WFmodel.playOnlyNum integerValue]==64001||[WFmodel.playOnlyNum integerValue]==73001||[WFmodel.playOnlyNum integerValue]==75001||[WFmodel.playOnlyNum integerValue]==77001||[WFmodel.playOnlyNum integerValue]==79001||[WFmodel.playOnlyNum integerValue]==81001||[WFmodel.typeId integerValue]==13){
        
        marr= MCRandomC(1, 1, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==74001||[WFmodel.playOnlyNum integerValue]==76001||[WFmodel.playOnlyNum integerValue]==78001||[WFmodel.playOnlyNum integerValue]==80001||[WFmodel.playOnlyNum integerValue]==82001||[WFmodel.playOnlyNum integerValue]==23001||[WFmodel.playOnlyNum integerValue]==29001||[WFmodel.playOnlyNum integerValue]==40001||[WFmodel.playOnlyNum integerValue]==51001||[WFmodel.playOnlyNum integerValue]==97001 ||[WFmodel.playOnlyNum integerValue]==33001 ||[WFmodel.playOnlyNum integerValue]==91001 ||[WFmodel.playOnlyNum integerValue]==108001||[WFmodel.playOnlyNum integerValue]==62001||[WFmodel.playOnlyNum integerValue]==69001){
        
        marr= MCRandomC(1, 2, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==53001||[WFmodel.playOnlyNum integerValue]==31001||[WFmodel.playOnlyNum integerValue]==42001||[WFmodel.playOnlyNum integerValue]==103001){
        
        marr= MCRandomC(1, 1, 1, 26,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==60001||[WFmodel.playOnlyNum integerValue]==67001||[WFmodel.playOnlyNum integerValue]==90001){
        
        marr= MCRandomC(1, 1, 0, 18,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==83001||[WFmodel.playOnlyNum integerValue]==52001||[WFmodel.playOnlyNum integerValue]==99001||[WFmodel.playOnlyNum integerValue]==30001||[WFmodel.playOnlyNum integerValue]==41001){
        
        marr= MCRandomC(1, 3, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==63001||[WFmodel.playOnlyNum integerValue]==70001||[WFmodel.playOnlyNum integerValue]==93001){
        
        marr= MCRandomC(1, 1, 1, 17,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==21001||[WFmodel.playOnlyNum integerValue]==106001){
        
        marr= MCRandomC(1, 4, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==109001||[WFmodel.playOnlyNum integerValue]==24001||[WFmodel.playOnlyNum integerValue]==17001||[WFmodel.playOnlyNum integerValue]==16001||[WFmodel.playOnlyNum integerValue]==65001||[WFmodel.playOnlyNum integerValue]==58001){
    
        marr= MCRandomC(2, 1, min, max,WFmodel);
        
        //三星直选复式
    }else if ([WFmodel.playOnlyNum integerValue]==25001||[WFmodel.playOnlyNum integerValue]==36001||[WFmodel.playOnlyNum integerValue]==47001){
        
        marr= MCRandomC(3, 1, min, max,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==19001){
        marr= MCRandomC(4, 1, min, max,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==84001||[WFmodel.playOnlyNum integerValue]==86001){
        
        marr=[MCRandomUntits Get_Marr_DaXiaoDanShuang:2];
        
    }else if ([WFmodel.playOnlyNum integerValue]==85001||[WFmodel.playOnlyNum integerValue]==87001){
        
        marr=[MCRandomUntits Get_Marr_DaXiaoDanShuang:3];
        
    }else if([WFmodel.typeId integerValue]==14||[WFmodel.typeId integerValue]==15){
        
        marr=[MCRandomUntits Get_Marr_LongHuHe];
        
    }else if ([WFmodel.playOnlyNum integerValue]==18001){
        marr= MCRandomWF(DaXiaoDanShuang);
        //三星  特殊号
    }else if ([WFmodel.playOnlyNum integerValue]==35001||[WFmodel.playOnlyNum integerValue]==46001||[WFmodel.playOnlyNum integerValue]==57001){
        marr= MCRandomWF(TeShuHao1);
        //定位胆
    }else if ([WFmodel.playOnlyNum integerValue]==72001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:5 andBallCount:1 andMin:0 andMax:9 andWei:1 andModel:WFmodel];
//        marr= MCRandomC(5, 1, min, max);
    }else if ([WFmodel.playOnlyNum integerValue]==88001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:5 andBallCount:1 andMin:0 andMax:9 andWei:2 andModel:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==94001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:5 andBallCount:1 andMin:0 andMax:9 andWei:3 andModel:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==104001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:5 andBallCount:1 andMin:0 andMax:9 andWei:4 andModel:WFmodel];
    }

    return marr;
}

#pragma-mark 快3
+(NSMutableArray *)Get_k3_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr=[[NSMutableArray alloc]init];

    if ([WFmodel.playOnlyNum integerValue]==10001) {
        marr=MCRandomC(1, 1, 3, 18,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==11001){
        marr=MCRandomWF(DaXiaoDanShuang);
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        marr=MCRandomWF(SanTongHaoDanXuan);
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        marr=MCRandomC(1, 3, 1, 6,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==18001){
        marr=MCRandomWF(ERTongHaoFuXuan);
    }else if ([WFmodel.playOnlyNum integerValue]==19001){
        marr=MCRandomC(1, 2, 1, 6,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==21001){
        marr=MCRandomC(1, 1, 1, 6,WFmodel);
    }
    return marr;
}

#pragma mark-快乐8
+(NSMutableArray *)Get_kl8_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    if ([WFmodel.typeId integerValue]==0) {
        int n=([WFmodel.playOnlyNum intValue]-9001)/1000;
        marr= MCRandomC(1, n, 1, 80,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==17001){
        marr= MCRandomWF(ShangXiaPan);
    }else if ([WFmodel.playOnlyNum integerValue]==18001){
        marr= MCRandomWF(JiOuPan);
    }else if ([WFmodel.playOnlyNum integerValue]==19001){
        marr= MCRandomWF(HeZhiDaXiao);
    }else if ([WFmodel.playOnlyNum integerValue]==20001){
        marr= MCRandomWF(DanShuang);
    }else if ([WFmodel.playOnlyNum integerValue]==21001){
        marr= MCRandomWF(HeZhiDaXiaoDanShuang);
    }else if ([WFmodel.playOnlyNum integerValue]==22001){
        marr= MCRandomWF(WuXing);
    }
    return marr;
}

#pragma-mark 3D
+(NSMutableArray *)Get_sd_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    if ([WFmodel.playOnlyNum integerValue]==10001) {
        marr= MCRandomC(3,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        marr= MCRandomC(1,1 , 0, 27,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        marr= MCRandomC(1,2 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==15001){
        marr= MCRandomC(1,3 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==21001||[WFmodel.playOnlyNum integerValue]==29001){
        marr= MCRandomC(2,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==37001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:3 andBallCount:1 andMin:0 andMax:9 andWei:1 andModel:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==38001){
        marr= MCRandomC(1,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==39001){
        marr= MCRandomC(1,2 , 0, 9,WFmodel);
    }
    return marr;
}

#pragma-mark PK拾
+(NSMutableArray *)Get_pks_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    if ([WFmodel.playOnlyNum integerValue]==10001) {
        marr= MCRandomC(1,1 , 1, 10,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==11001){
        marr= MCRandomC(2,1 , 1, 10,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==13001){
        marr= MCRandomC(3,1 , 1, 10,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==15001||[WFmodel.playOnlyNum integerValue]==16001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:5 andBallCount:1 andMin:1 andMax:10 andWei:1 andModel:WFmodel];
    }else if ([WFmodel.typeId integerValue]==4){
        marr= MCRandomWF(DaXiao);
    }else if ([WFmodel.typeId integerValue]==5){
        marr= MCRandomWF(DanShuang);
    }else if ([WFmodel.typeId integerValue]==6){
        marr= MCRandomWF(LongHu);
    }
    return marr;
}

#pragma-mark 时时乐
+(NSMutableArray *)Get_ssl_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr=[[NSMutableArray alloc]init];

    if ([WFmodel.playOnlyNum integerValue]==10001) {
        marr= MCRandomC(3,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        marr= MCRandomC(1,1 , 0, 27,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==13001){
        marr= MCRandomC(1,2 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        marr= MCRandomC(1,3 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==15001||[WFmodel.playOnlyNum integerValue]==20001){
        marr= MCRandomC(2,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==17001||[WFmodel.playOnlyNum integerValue]==22001){
        marr= MCRandomC(1,1 , 0, 18,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==18001||[WFmodel.playOnlyNum integerValue]==23001){
        marr= MCRandomC(1,2 , 0, 9,WFmodel);
    }else if ([WFmodel.typeId integerValue]==3||[WFmodel.typeId integerValue]==4){
        marr= MCRandomC(1,1 , 0, 9,WFmodel);
    }
    return marr;
}

#pragma-mark 排列三
+(NSMutableArray *)Get_pl3_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr=[[NSMutableArray alloc]init];

    if ([WFmodel.playOnlyNum integerValue]==10001) {
        marr= MCRandomC(3,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        marr= MCRandomC(1,1 , 0, 27,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        marr= MCRandomC(1,2 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==15001){
        marr= MCRandomC(1,3 , 0, 9,WFmodel);
    }else if ([WFmodel.typeId integerValue]==1||[WFmodel.typeId integerValue]==2){
        marr= MCRandomC(2,1 , 0, 9,WFmodel);
    }else if ([WFmodel.typeId integerValue]==3){
        marr= MCRandomC(3,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==37001){
        marr= MCRandomC(1,1 , 0, 9,WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==38001){
        marr= MCRandomC(1,2 , 0, 9,WFmodel);
    }
    return marr;
}

#pragma-mark 排列五
+(NSMutableArray *)Get_pl5_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr=[[NSMutableArray alloc]init];

    if ([WFmodel.playOnlyNum integerValue]==10001) {
        marr= MCRandomC(5,1 , 0, 9,WFmodel);
    }else if ([ WFmodel.playOnlyNum integerValue]==12001){
        marr= [MCRandomUntits Get_DDDDMarrWithLinCount:5 andBallCount:1 andMin:0 andMax:9 andWei:1 andModel:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==13001){
        marr= MCRandomC(1,1 , 0, 9,WFmodel);
    }
    return marr;
}

#pragma-mark 快乐十分
+(NSMutableArray *)Get_klsf_RandomArrWithModel:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    if ([WFmodel.playOnlyNum integerValue]==10003||[WFmodel.playOnlyNum integerValue]==10004) {
        
        marr= MCRandomC(1,3 , 1, 20,WFmodel);
        
    }else if ([ WFmodel.playOnlyNum integerValue]==11002){
        
        marr= MCRandomC(1,2 , 1, 20,WFmodel);
        
    }else if ([WFmodel.typeId integerValue]==2){
        
        marr= MCRandomC(1,1 , 1, 20,WFmodel);
        
    }else if ([WFmodel.typeId integerValue]==3){
        
        int t=(int)([WFmodel.playOnlyNum integerValue]-13000);
        marr= MCRandomC(1, t, 1, 20,WFmodel);
        
    }else if ([WFmodel.playOnlyNum integerValue]==15001){
        
        marr = [MCRandomUntits Get_RondomMarrWithLineCount:8 andShowCount:1 andType:DaXiaoDanShuang2];

    }else if ([WFmodel.playOnlyNum integerValue]==15002){
        
        marr= MCRandomWF(HeZhiDaXiao);
        
    }else if ([WFmodel.playOnlyNum integerValue]==16001){
        
        marr = [MCRandomUntits Get_RondomMarrWithLineCount:8 andShowCount:1 andType:ChunXiaQiuDongSiJiFangWei];
        
    }else if ([WFmodel.playOnlyNum integerValue]==17001){
        
        marr = [MCRandomUntits Get_RondomMarrWithLineCount:8 andShowCount:1 andType:WuXing];
        
    }else if ([WFmodel.typeId integerValue]==8){
        marr= MCRandomWF(LongHu2);
    }
    
    return marr;
}
    

#pragma mark-===================公共方法===================
/*
 * 传入行数2   第一行个数  和第二行个数    返回一个数组
 */
+(NSMutableArray *)Get_MarrWithFirst:(int)first andSecond:(int)second andMin:(int)min andMax:(int)max andModel:(MCBasePWFModel *)WFmodel{
    
    int count =first+second;
    NSMutableArray * marrNum=[[NSMutableArray alloc]init];
    
    while (1) {
        int randomNum = (min + (arc4random() % (max - min + 1)));
        if (![MCRandomUntits isHaveSameNumber:randomNum inArr:marrNum]) {
            if ([WFmodel.isAddZero intValue]==1) {
                [marrNum addObject:[NSString stringWithFormat:@"%.2d",randomNum]];
            }else{
                [marrNum addObject:[NSString stringWithFormat:@"%d",randomNum]];
            }
        }
        if (marrNum.count==count) {
            NSMutableArray * marr_line=[[NSMutableArray alloc]init];

          NSMutableArray * marr_ball1=[[NSMutableArray alloc]init];
            for (int i=0; i<first; i++) {
                [marr_ball1 addObject:marrNum[i]];
            }
            
            [marr_line addObject:marr_ball1];
            
            NSMutableArray * marr_ball2=[[NSMutableArray alloc]init];

            for (int j=1; j<=second; j++) {
                [marr_ball2 addObject:marrNum[count-j]];
            }
            [marr_line addObject:marr_ball2];
            

            return marr_line;
        }
    }
}
+(NSMutableArray *)Get_DDDDMarrWithLinCount:(int)lineCount andBallCount:(int)ballCount andMin:(int)min andMax:(int)max   andWei:(int)wei andModel:(MCBasePWFModel *)WFmodel{
    
    NSMutableArray * marr_wei=[[NSMutableArray alloc]init];
    
    while (1) {
        int random=arc4random()%lineCount;
        if (![marr_wei containsObject:[NSString stringWithFormat:@"%d",random]]) {
            [marr_wei addObject:[NSString stringWithFormat:@"%d",random]];
        }
        if (marr_wei.count>=wei) {
            break;
        }
    }
    
    
    int count =lineCount*ballCount;
    NSMutableArray * marrNum=[[NSMutableArray alloc]init];
//    int index=arc4random() %lineCount;
    while (1) {
        int randomNum = (min + (arc4random() % (max - min + 1)));
        if (![MCRandomUntits isHaveSameNumber:randomNum inArr:marrNum]) {
            if ([WFmodel.isAddZero intValue]==1) {
                [marrNum addObject:[NSString stringWithFormat:@"%.2d",randomNum]];
            }else{
                [marrNum addObject:[NSString stringWithFormat:@"%d",randomNum]];
            }
        }
        if (marrNum.count==count) {
            NSMutableArray * marr_line=[[NSMutableArray alloc]init];
            for (int i=0; i<lineCount; i++) {
                NSMutableArray * marr_ball=[[NSMutableArray alloc]init];
                for (int j=0; j<ballCount; j++) {
                    [marr_ball addObject:marrNum[i*ballCount+j]];
                }
                if ([marr_wei containsObject:[NSString stringWithFormat:@"%d",i]]) {
                    [marr_line addObject:marr_ball];
                }else{
                    [marr_line addObject:@[]];
                }
            }
            return marr_line;
        }
    }
}
/*
 * 传入 【行数】 【每一行选的个数】  返回一个数组
 */
+(NSMutableArray *)Get_MarrWithLinCount:(int)lineCount andBallCount:(int)ballCount andMin:(int)min andMax:(int)max  andModel:(MCBasePWFModel *)WFmodel{
    
    int count =lineCount*ballCount;
    NSMutableArray * marrNum=[[NSMutableArray alloc]init];

    while (1) {
        int randomNum = (min + (arc4random() % (max - min + 1)));
        
        if (![MCRandomUntits isHaveSameNumber:randomNum inArr:marrNum]) {
            if ([WFmodel.isAddZero intValue]==1) {
                [marrNum addObject:[NSString stringWithFormat:@"%.2d",randomNum]];
            }else{
                [marrNum addObject:[NSString stringWithFormat:@"%d",randomNum]];
            }
            
        }
        if (marrNum.count==count) {
            NSMutableArray * marr_line=[[NSMutableArray alloc]init];
            for (int i=0; i<lineCount; i++) {
                NSMutableArray * marr_ball=[[NSMutableArray alloc]init];
                for (int j=0; j<ballCount; j++) {
                    [marr_ball addObject:marrNum[i*ballCount+j]];
                }
                
                [marr_line addObject:marr_ball];

            }
            return marr_line;
        }
    }
}


+(BOOL)isHaveSameNumber:(int)num inArr:(NSMutableArray *)marr{
    for (NSString * n  in marr ) {
        if ([n intValue]==num) {
            return YES;
        }
    }
    return NO;
}
/*
 * 大小单双
 */
+(NSMutableArray *)Get_Marr_DaXiaoDanShuang:(int)lineCount{
    NSArray * arr=@[@[@"大"],@[@"小"],@[@"单"],@[@"双"]];
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for (int i=0;i<lineCount;i++) {
        int index=arc4random() %4;
        [marr addObject:arr[index]];
    }
    return marr;
}

/*
 * 龙虎和
 */
+(NSMutableArray *)Get_Marr_LongHuHe{
    NSArray * arr=@[@[@"龙"],@[@"虎"],@[@"和"]];
    int index=arc4random() %3;
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    [marr addObject:arr[index]];
    return marr;

}

/*
 * 传入数组随机出数组中的值
 */
+(NSMutableArray *)Get_RondomMarrWithArr:(NSArray *)arr{
    int index=arc4random() %arr.count;
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    [marr addObject:arr[index]];
    return marr;
}
+(NSString *)Get_RondomStrWithType:(Type_WF)type{
    NSArray * arr;
    if (type==DaXiaoDanShuang) {
        arr=@[@[@"大" ],@[@"小" ],@[@"单" ],@[ @"双"]];
    }else if (type==DanShuang){
        arr=@[@[ @"单"],@[@"双" ]];
    }else if (type==HeZhiDaXiao){
        arr=@[@[ @"大"],@[@"小" ],@[ @"和"]];
    }else if (type==HeZhiDaXiaoDanShuang){
        arr=@[@[@"大单" ],@[@"大双" ],@[@"小单" ],@[@"小双" ]];
    }else if (type==WuXing){
        arr=@[@[@"金" ],@[@"木" ],@[@"水" ],@[@"火" ],@[@"土" ]];
    }else if (type==JiOuPan){
        arr=@[@[@"奇" ],@[@"偶" ],@[@"和" ]];
    }else if (type==ShangXiaPan){
        arr=@[@[@"上" ],@[@"下" ],@[ @"中"]];
    }else if (type==SanTongHaoDanXuan){
        arr=@[@[@"111" ],@[@"222" ],@[@"333" ],@[ @"444"],@[@"555" ],@[ @"666"]];
    }else if (type==ERTongHaoFuXuan){
        arr=@[@[ @"11*"],@[ @"22*"],@[@"33*" ],@[ @"44*"],@[@"55*" ],@[ @"66*"]];
    }else if (type==DaXiao){
        arr=@[@[@"大" ],@[@"小" ]];
    }else if (type==LongHu){
        arr=@[@[ @"龙"],@[@"虎" ]];
    }else if (type==TeShuHao1){
        arr=@[@[ @"豹子"],@[@"顺子" ],@[ @"对子"],@[@"半顺" ],@[ @"杂六"]];
    }else if (type==LongHu2){
        
        arr=@[@[ @"1V2"],@[@"1V3" ],@[ @"1V4"],@[@"1V5" ],@[ @"1V6"],@[@"1V7"],@[@"1V8"],@[@"2V3"],@[@"2V4"],@[@"2V5"],@[@"2V6"],@[@"2V7"],@[@"2V8"],@[@"3V4"],@[@"3V5"],@[@"3V6"],@[@"3V7"],@[@"3V8"],@[@"4V5"],@[@"4V6"],@[@"4V7"],@[@"4V8"],@[@"5V6"],@[@"5V7"],@[@"5V8"],@[@"6V7"],@[@"6V8"],@[@"7V8"]];
        
    }else if (type==DaXiaoDanShuang2){
        
        arr=@[@[@"大" ],@[@"小" ],@[@"单" ],@[ @"双"],@[@"尾大" ],@[@"尾小" ],@[@"和单" ],@[ @"和双"]];
    }else if (type==ChunXiaQiuDongSiJiFangWei){
        
        arr=@[@[@"春" ],@[@"夏" ],@[@"秋" ],@[ @"冬"],@[@"东" ],@[@"南" ],@[@"西" ],@[ @"北"]];
    }
    
    int index=arc4random() %arr.count;
    return arr[index];
}

+(NSMutableArray *)Get_RondomMarrWithType:(Type_WF)type{
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    [marr addObject:[MCRandomUntits Get_RondomStrWithType:type]];
    return marr;
}

#pragma mark-传入球的行数(lineCount) 实际有数据的行数(showCount)
+(NSMutableArray *)Get_RondomMarrWithLineCount:(int)lineCount andShowCount:(int)showCount andType:(Type_WF)type{

    NSMutableArray * marr=[[NSMutableArray alloc]init];
    showCount=1;
    
    int random=arc4random()%lineCount;
    
    for (int i=0; i< lineCount ;i++) {
        if (i==random) {
            [marr addObject:[MCRandomUntits Get_RondomStrWithType:type]];
        }else{
            [marr addObject:@[]];
        }
    }
    return marr;
   
}

/*
 * 快乐8   专用
 */
+(NSMutableArray * )Get_Kl8RandomArrWithModel:(MCBasePWFModel *)WFmodel andType:(NSString *)type{
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    if ([type isEqualToString:@"全"]) {
        //任选1
        if ([WFmodel.playOnlyNum integerValue] ==10001) {
            marr=[MCRandomUntits getWithFrom:1 To:80];
        }else{
            marr=MCRandomC(1, 8, 1, 80,WFmodel);
        }
        
    }else if ([type isEqualToString:@"上"]){
        //任选1
        if ([WFmodel.playOnlyNum integerValue] ==10001) {
            marr=[MCRandomUntits getWithFrom:1 To:40];
        }else{
            marr=MCRandomC(1, 8, 1, 40,WFmodel);
        }
    }else if ([type isEqualToString:@"下"]){
        //任选1
        if ([WFmodel.playOnlyNum integerValue] ==10001) {
            marr=[MCRandomUntits getWithFrom:41 To:80];
        }else{
            marr=MCRandomC(1, 8, 41, 80,WFmodel);
        }
    }else if ([type isEqualToString:@"奇"]){
        //任选1
        if ([WFmodel.playOnlyNum integerValue] ==10001) {
            marr=[MCRandomUntits getWithFrom:41 To:80];
        }else{
            marr=[MCRandomUntits Get_MarrWithLinCount:1 andBallCount:8 andMin:1 andMax:80 andJIOU:1 andModel:WFmodel];
            
        }
    }else if ([type isEqualToString:@"偶"]){
        //任选1
        if ([WFmodel.playOnlyNum integerValue] ==10001) {
            marr=[MCRandomUntits getWithFrom:41 To:80];
        }else{
            marr=[MCRandomUntits Get_MarrWithLinCount:1 andBallCount:8 andMin:1 andMax:80 andJIOU:2 andModel:WFmodel];
        }
    }
    
    return marr;
    
    
}
/*
 * 传入 【行数】 【每一行选的个数】  返回一个数组  以及奇偶
 */
+(NSMutableArray *)Get_MarrWithLinCount:(int)lineCount andBallCount:(int)ballCount andMin:(int)min andMax:(int)max andJIOU:(int)isJorOu  andModel:(MCBasePWFModel *)WFmodel{
    
    int count =lineCount*ballCount;
    NSMutableArray * marrNum=[[NSMutableArray alloc]init];
    
    while (1) {
        int randomNum = [MCRandomUntits random:isJorOu andMin:min andMax:max];
        if (![MCRandomUntits isHaveSameNumber:randomNum inArr:marrNum]) {
            if ([WFmodel.isAddZero intValue]==1) {
                [marrNum addObject:[NSString stringWithFormat:@"%.2d",randomNum]];
            }else{
                [marrNum addObject:[NSString stringWithFormat:@"%d",randomNum]];
            }
        }
        if (marrNum.count==count) {
            NSMutableArray * marr_line=[[NSMutableArray alloc]init];
            for (int i=0; i<lineCount; i++) {
                NSMutableArray * marr_ball=[[NSMutableArray alloc]init];
                for (int j=0; j<ballCount; j++) {
                    [marr_ball addObject:marrNum[i*ballCount+j]];
                }
                [marr_line addObject:marr_ball];
            }
            return marr_line;
        }
    }
}
+(int )random:(int)type andMin:(int)min andMax:(int)max{
    int randomNum = (min + (arc4random() % (max - min + 1)));
    if (type==1) {//奇数
        
        if (randomNum%2!=0) {
            return randomNum;
        }else{
            return [MCRandomUntits random:type andMin:min andMax:max];
        }
        
    }else{//偶数
        if (randomNum%2==0) {
            return randomNum;
        }else{
            return [MCRandomUntits random:type andMin:min andMax:max];
        }
    }
}
+(NSMutableArray * )getWithFrom:(int)from To:(int)to{
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for (int i=from ;i<=to;i++) {
        [marr addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    NSMutableArray * marrr=[[NSMutableArray alloc]init];
    [marrr addObject:marr];
    return marrr;
}
@end

























