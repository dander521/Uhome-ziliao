//
//  MCStakeUntits.m
//  TLYL
//
//  Created by MC on 2017/6/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCStakeUntits.h"

#define MCStakeWT(weiCount,type,WFmodel)   [MCStakeUntits Get_Wei:weiCount andType:type andModel:WFmodel]

#define MCStakeBallNum(WFmodel) [MCStakeUntits Get_BallNumWithModel:WFmodel]

#define MCStakeDanShi(WFmodel) [MCStakeUntits Get_DanShiWithModel:WFmodel]

#define MCStakeCorA(t,type,WFmodel) [MCStakeUntits MC_CorAWithT:t andType:type andModel:WFmodel]

#define MCStakeDMTM(t, WFmodel) [MCStakeUntits Get_DMTMWithT:t andModel:WFmodel]

#define MCStakeOnlyNum(t,WFmodel) [MCStakeUntits Get_OnlyNumWithT:t Model:WFmodel]
/*
 * 命名：
 * 五星-》FiveStar
 * 四星-》FourStar
 * 三星-》ThirdStar
 * 直选-》Direct
 * 任选-》Optional
 * 组选-》Group
 *
 * 组合-》Combination
 *
 * 前一-》Before_One
 * 前二-》Before_Two
 * 前三-》Before_Three
 *
 * 单式-》Simple
 * 复式-》Double
 *
 * 跨度-》KuaDu
 *
 * 定位胆-》LocalD
 * 不定胆-》UnsureD
 * 胆拖-》DT
 * 包胆-》BD
 * 和值-》Value
 * 尾数-》WeiShu
 * 特殊号-》TeShuHao
 *
 * 总和大小单双-》ALLSimpleDouble
 * 拖码的个数-》TMcode
 * 胆码的个数-》DMcode
 */
@implementation MCStakeUntits
#pragma mark-彩票注数计算
+(MCBallPropertyModel *)GetBallPropertyWithWFModel:(MCBasePWFModel *)WFmodel{
    
    MCBallPropertyModel * Pmodel=[[MCBallPropertyModel alloc]init];
    
    NSDictionary * dic_CZ=@{
                            @"esf":@"1",@"ssc":@"2",@"k3":@"3",@"kl8":@"4",@"sd":@"5",@"pks":@"6",@"ssl":@"7",@"pls":@"8",@"plw":@"9",@"klsf":@"10"
                            };
    NSInteger  cZNumber= [[dic_CZ  objectForKey:WFmodel.lotteryCategories] integerValue];
    if (WFmodel.baseSelectedModel.count<1&&WFmodel.danShiArray.count<1) {
        Pmodel.stakeNumber=0;
        return Pmodel;
    }
    switch (cZNumber) {
#pragma-mark 11选5
        case  1:
            Pmodel.stakeNumber =[MCStakeUntits Get_esf_StakeNumberWith:WFmodel];
            break;
#pragma-mark 时时彩
        case  2:
            Pmodel.stakeNumber =[MCStakeUntits Get_ssc_StakeNumberWith:WFmodel];
            break;
#pragma-mark 快3
        case  3:
            Pmodel.stakeNumber =[MCStakeUntits Get_k3_StakeNumberWith:WFmodel];
            break;
#pragma mark-快乐8
        case  4:
            Pmodel.stakeNumber =[MCStakeUntits Get_kl8_StakeNumberWith:WFmodel];
            break;
#pragma-mark 3D
        case  5:
            Pmodel.stakeNumber =[MCStakeUntits Get_sd_StakeNumberWith:WFmodel];
            break;
#pragma-mark PK拾
        case  6:
            Pmodel.stakeNumber =[MCStakeUntits Get_pks_StakeNumberWith:WFmodel];
            break;
#pragma-mark 时时乐
        case  7:
            Pmodel.stakeNumber =[MCStakeUntits Get_ssl_StakeNumberWith:WFmodel];
            break;
#pragma-mark 排列三
        case  8:
            Pmodel.stakeNumber =[MCStakeUntits Get_pls_StakeNumberWith:WFmodel];
            break;
#pragma-mark 排列五
        case  9:
            Pmodel.stakeNumber =[MCStakeUntits Get_plw_StakeNumberWith:WFmodel];
            break;
#pragma-mark 快乐十分
        case  10:
        Pmodel.stakeNumber =[MCStakeUntits Get_klsf_StakeNumberWith:WFmodel];
        break;
        default:
            break;
    }
    return Pmodel;
}



#pragma mark-----十一选五(算法)
/*
 * 任选复式
 * type：任选复式类型
 * MC_CCOMBINATION(所选球的个数,type )
 */
+(int)Get_esf_Optional_DoubleWithWFmodel:(MCBasePWFModel *)WFmodel{
    int type=(int)([WFmodel.playOnlyNum integerValue]-28000)/1000;
    MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];
    int n   =(int)model.selectedArray.count;
    if (n<type) {
        return 0;
    }
    return MC_CCOMBINATION(n, type);
}

/*
 * 任选胆拖
 * TMcode:拖码的个数
 * DMcode:胆码的个数
 * MC_CCOMBINATION(拖码的个数,type-胆码的个数)
 * 第一个是胆码    下面是托码
 */

+(int)Get_esf_Optional_DuplexWithWFmodel:(MCBasePWFModel *)WFmodel{
    if (WFmodel.baseSelectedModel.count<2) {
        return 0;
    }
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    MCBaseSelectedModel * model2 = [WFmodel.baseSelectedModel objectAtIndex:1];
    int DMcode,TMcode;
    if (model1.index==0) {
        DMcode=(int)model1.selectedArray.count;
        TMcode=(int)model2.selectedArray.count;
    }else{
        DMcode=(int)model2.selectedArray.count;
        TMcode=(int)model1.selectedArray.count;
    }
    int type  =(int)([WFmodel.playOnlyNum integerValue] -43000)/1000;
    if (DMcode>type-1) {
        return 0;
    }
    if (TMcode<1||TMcode>10) {
        return 0;
    }
    return MC_CCOMBINATION(TMcode, (type-DMcode));
}


#pragma 前一系列
/*
 * 前一
 * 注数=所选号码的个数
 * num:所选球的个数
 */
+(int)Get_esf_Before_OneWithWFmodel:(MCBasePWFModel *)WFmodel{
    return MCStakeBallNum(WFmodel);
}
/*
 * 不定胆
 * num:所选球的个数
 */
+(int)Get_esf_UnsureDWithWFmodel:(MCBasePWFModel *)WFmodel{
    return MCStakeBallNum(WFmodel);
}

#pragma 前三/前二 系列
/*
 * 前三/前二
 * 直选复式
 * type==0 是前三   1是前二
 */
+(int)Get_esf_DirectDoubleWithWFmodel:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.typeId integerValue]==0) {
        return MCStakeOnlyNum(3, WFmodel);
    }else{
        return MCStakeOnlyNum(2, WFmodel);
    }
}

/*
 * 前三/前二
 * 直选组合
 * num:所选球的个数
 * type==0 是前三   1是前二
 */
+(int)Get_esf_DirectCombinationWithWFmodel:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    if ([WFmodel.typeId integerValue]==0&&model1.selectedArray.count<3) {
        return 0;
    }
    if ([WFmodel.typeId integerValue]==1&&model1.selectedArray.count<2) {
        return 0;
    }
    int num=(int)model1.selectedArray.count;
    return  [WFmodel.typeId integerValue] ==0 ? MC_ACOMBINATION(num, 3):MC_ACOMBINATION(num, 2);
}


/*
 * 前三/前二
 * 直选胆拖
 * type==0 是前三   1是前二
 * 第一个是胆码    下面是托码
 */
+(int)Get_esf_DirectDTWithWFmodel:(MCBasePWFModel *)WFmodel{
    if (WFmodel.baseSelectedModel.count<2) {
        return 0;
    }
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    MCBaseSelectedModel * model2 = [WFmodel.baseSelectedModel objectAtIndex:1];
    int DMcode,TMcode;
    if (model1.index==0) {
        DMcode=(int)model1.selectedArray.count;
        TMcode=(int)model2.selectedArray.count;
    }else{
        DMcode=(int)model2.selectedArray.count;
        TMcode=(int)model1.selectedArray.count;
    }
    if ([WFmodel.typeId integerValue]==0) {
        if (TMcode < (3-DMcode)) {
            return 0;
        }
    }
    
        
    return [WFmodel.typeId integerValue]==0?MC_CCOMBINATION(TMcode, (3-DMcode))*MC_ACOMBINATION(3, 3):MC_CCOMBINATION(TMcode, 1)*MC_ACOMBINATION(2, 2);
}


/*
 * 前三/前二
 * 组选复式
 * type==0 是前三   1是前二
 */
+(int)Get_esf_GroupDoubleWithWFmodel:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int num=(int)model1.selectedArray.count;
    if (num<3&&[WFmodel.typeId integerValue]==0) {
        return 0;
    }else if(num<2&&[WFmodel.typeId integerValue]==1){
        return 0;
    }
    return [WFmodel.typeId integerValue]==0?MC_CCOMBINATION(num, 3):MC_CCOMBINATION(num, 2);
}


/*
 * 前三/前二
 * 组选胆拖
 * 胆码<=2  托码2-10
 */
+(int)Get_esf_GroupDTWithWFmodel:(MCBasePWFModel *)WFmodel{
    if (WFmodel.baseSelectedModel.count<2) {
        return 0;
    }
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    MCBaseSelectedModel * model2 = [WFmodel.baseSelectedModel objectAtIndex:1];
    int DMcode,TMcode;
    if (model1.index==0) {
        DMcode=(int)model1.selectedArray.count;
        TMcode=(int)model2.selectedArray.count;
    }else{
        DMcode=(int)model2.selectedArray.count;
        TMcode=(int)model1.selectedArray.count;
    }
    if (TMcode<1||TMcode==11) {
        return 0;
    }
    return [WFmodel.typeId integerValue]==0?MC_CCOMBINATION(TMcode, (3-DMcode)):MC_CCOMBINATION(TMcode, 1);
}

/*
 * 定位胆
 */
+(int)Get_esf_LocalDWithWFmodel:(MCBasePWFModel *)WFmodel{
    return MCStakeWT(3, MC_Add, WFmodel);
}

#pragma mark-11选5 前三/前二 注数计算
+(int)Get_esf_Before_TwoOrThree_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    
    //——直选复式
    if ([WFmodel.playOnlyNum integerValue]==10001||[WFmodel.playOnlyNum integerValue]==17001) {
        if (WFmodel.baseSelectedModel.count<2||!WFmodel.baseSelectedModel) {
            return 0;
        }
        if ([WFmodel.typeId integerValue]==0) {
            if (WFmodel.baseSelectedModel.count<3||!WFmodel.baseSelectedModel) {
                return 0;
            }
        }
        return   [MCStakeUntits Get_esf_DirectDoubleWithWFmodel:WFmodel];
        
        //——直选组合
    }else if([WFmodel.playOnlyNum integerValue]==12001||[WFmodel.playOnlyNum integerValue]==19001){
        return   [MCStakeUntits Get_esf_DirectCombinationWithWFmodel:WFmodel] ;
        //——直选胆拖
    }else if([WFmodel.playOnlyNum integerValue]==13001||[WFmodel.playOnlyNum integerValue]==20001){
        return   [MCStakeUntits Get_esf_DirectDTWithWFmodel:WFmodel];
        //组选复式
    }else if([WFmodel.playOnlyNum integerValue]==14001||[WFmodel.playOnlyNum integerValue]==21001){
        return   [MCStakeUntits Get_esf_GroupDoubleWithWFmodel:WFmodel];
        //——组选胆拖
    }else if([WFmodel.playOnlyNum integerValue]==16001||[WFmodel.playOnlyNum integerValue]==23003){
        return   [MCStakeUntits Get_esf_GroupDTWithWFmodel:WFmodel];
        //——单式
    }else{
        return MCStakeDanShi(WFmodel);
    }
    
}





#pragma mark-11选5 注数计算
+(int)Get_esf_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    switch ([WFmodel.typeId integerValue]) {
#pragma mark-前三系列
        case 0:
#pragma mark-前二系列
        case 1:
            return [MCStakeUntits Get_esf_Before_TwoOrThree_StakeNumberWith:WFmodel];
            break;
#pragma mark-前一系列
        case 2:
            return [MCStakeUntits Get_esf_Before_OneWithWFmodel:WFmodel];
            break;
#pragma mark-定位胆系列
        case 3:
            return [MCStakeUntits Get_esf_LocalDWithWFmodel:WFmodel];
            break;
#pragma mark-不定胆系列
        case 4:
            return [MCStakeUntits  Get_esf_UnsureDWithWFmodel:WFmodel];
            break;
#pragma mark-趣味型系列
        case 5:
            return 0;
            break;
#pragma mark-任选复式系列
        case 6:
            return [MCStakeUntits  Get_esf_Optional_DoubleWithWFmodel:WFmodel];
            break;
#pragma mark-任选单式系列
        case 7:
            //所有单式都等于空格隔开的数量
            return MCStakeDanShi(WFmodel);
            break;
#pragma mark-任选胆拖系列
        case 8:
            return [MCStakeUntits Get_esf_Optional_DuplexWithWFmodel:WFmodel] ;
            break;
        default:
            break;
    }
    
    return 0;
    
}

#pragma mark-时时彩注数计算
+(int)Get_ssc_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    switch ([WFmodel.typeId integerValue]) {
#pragma mark-五星
        case 0:
            return  [MCStakeUntits Get_ssc_FiveStar_StakeNumberWith:WFmodel];
            break;
#pragma mark-四星
        case 1:
            return  [MCStakeUntits Get_ssc_FourStar_StakeNumberWith:WFmodel];
            break;
#pragma mark-后三
        case 2:
#pragma mark-中三
        case 3:
#pragma mark-前三
        case 4:
            return  [MCStakeUntits Get_ssc_ThirdStar_StakeNumberWith:WFmodel];
            break;
#pragma mark-后二
        case 5:
#pragma mark-前二
        case 6:
            return  [MCStakeUntits Get_ssc_SecondStar_StakeNumberWith:WFmodel];
            break;
#pragma mark-定位胆
        case 7:
            return  [MCStakeUntits Get_ssc_LocalDWith:WFmodel];
            break;
#pragma mark-不定位
        case 8:
            return  [MCStakeUntits Get_ssc_UnsureWeiWith:WFmodel];
            break;
#pragma mark-大小单双
        case 9:
            return  [MCStakeUntits Get_ssc_SimpleDoubleWith:WFmodel];
            break;
#pragma mark-任选二
        case 10:
#pragma mark-任选三
        case 11:
#pragma mark-任选四
        case 12:
            return  [MCStakeUntits Get_ssc_Optional_StakeNumberWith:WFmodel];
            break;
#pragma mark-趣味
        case 13:
#pragma mark-龙虎
        case 14:
#pragma mark-骰宝龙虎
        case 15:
            return [MCStakeUntits DanShi:WFmodel];
            break;
            
            
        default:
            break;
    }
    return 0;
}
+(int)DanShi:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];
    return (int)model.selectedArray.count;
}


#pragma mark-时时彩--五星--注数计算
+(int)Get_ssc_FiveStar_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.playOnlyNum integerValue]==10001) {//直选复式
        return [MCStakeUntits Get_ssc_Star_Direct_DoubleWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==12001){//组选120
        return [MCStakeUntits Get_ssc_CCOMBINATIONNumWith:WFmodel andT:5 andAC:@"C"];
    }else if ([WFmodel.playOnlyNum integerValue]==13001){//组选60
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:3 Type:1];//二重号：至少选一个码  单号：至少选3个码
    }else if ([WFmodel.playOnlyNum integerValue]==14001){//组选30
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:2 Type:2];
    }else if ([WFmodel.playOnlyNum integerValue]==15001){//组选20
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:2 Type:1];
    }else if ([WFmodel.playOnlyNum integerValue]==16001||[WFmodel.playOnlyNum integerValue]==17001){//组选10,5
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:1 Type:1];
    }else if ([WFmodel.playOnlyNum integerValue]==18001){//总和大小单双
        return [MCStakeUntits Get_ssc_FiveStar_ALLSimpleDoubleWith:WFmodel];
    }else if([WFmodel.playOnlyNum integerValue]==11001){//直选单式
        return MCStakeDanShi(WFmodel);
    }
    return 0;
}

#pragma mark-时时彩--四星--注数计算
+(int)Get_ssc_FourStar_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.playOnlyNum integerValue]==19001) {//直选复式
        return [MCStakeUntits Get_ssc_Star_Direct_DoubleWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==21001){//组选24
        return [MCStakeUntits Get_ssc_CCOMBINATIONNumWith:WFmodel andT:4 andAC:@"C"];
    }else if ([WFmodel.playOnlyNum integerValue]==22001){//组选12
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:2 Type:1 ];
    }else if ([WFmodel.playOnlyNum integerValue]==23001){//组选6
        return [MCStakeUntits Get_ssc_CCOMBINATIONNumWith:WFmodel andT:2 andAC:@"C"];
    }else if ([WFmodel.playOnlyNum integerValue]==24001){//组选4
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:1 Type:1];
    }else if([WFmodel.playOnlyNum integerValue]==20002){//直选单式
        return MCStakeDanShi(WFmodel);
    }
    return 0;
}
#pragma mark-时时彩--三星--注数计算
+(int)Get_ssc_ThirdStar_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.playOnlyNum integerValue]==25001||[WFmodel.playOnlyNum integerValue]==36001||[WFmodel.playOnlyNum integerValue]==47001) {//直选复式
        return [MCStakeUntits Get_ssc_Star_Direct_DoubleWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==27001||[WFmodel.playOnlyNum integerValue]==38001||[WFmodel.playOnlyNum integerValue]==49001){//前三 中三 后三 直选和值
        return [MCStakeUntits Get_ThirdStar_Direct_ValueWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==39001||[WFmodel.playOnlyNum integerValue]==28001||[WFmodel.playOnlyNum integerValue]==50001){//直选跨度
        return [MCStakeUntits Get_ssc_ThirdStar_Direct_KuaDuWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==29001||[WFmodel.playOnlyNum integerValue]==40001||[WFmodel.playOnlyNum integerValue]==51001){//组三复式
        return [MCStakeUntits Get_ssc_CCOMBINATIONNumWith:WFmodel andT:2 andAC:@"A"];
    }else if ([WFmodel.playOnlyNum integerValue]==30001||[WFmodel.playOnlyNum integerValue]==41001||[WFmodel.playOnlyNum integerValue]==52001){//组六复式
        return [MCStakeUntits Get_ssc_CCOMBINATIONNumWith:WFmodel andT:3 andAC:@"C"];
    }else if ([WFmodel.playOnlyNum integerValue]==31001||[WFmodel.playOnlyNum integerValue]==42001||[WFmodel.playOnlyNum integerValue]==53001){//组选和值
        return [MCStakeUntits Get_ssc_ThirdStar_Group_ValueWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==32001||[WFmodel.playOnlyNum integerValue]==43001||[WFmodel.playOnlyNum integerValue]==54001){//组选包胆
        return 54;
    }else if ([WFmodel.playOnlyNum integerValue]==33001||[WFmodel.playOnlyNum integerValue]==44001||[WFmodel.playOnlyNum integerValue]==55001){//混合组选
        return MCStakeDanShi(WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==34001||[WFmodel.playOnlyNum integerValue]==45001||[WFmodel.playOnlyNum integerValue]==56001||[WFmodel.playOnlyNum integerValue]==35001||[WFmodel.playOnlyNum integerValue]==46001||[WFmodel.playOnlyNum integerValue]==57001){//特殊号 //和值尾数
        
        MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
        return (int)model1.selectedArray.count;
        
    }else if([WFmodel.playOnlyNum integerValue]==26001||[WFmodel.playOnlyNum integerValue]==37001||[WFmodel.playOnlyNum integerValue]==48001){//直选单式
        return MCStakeDanShi(WFmodel);
    }
    
    return 0;
}

#pragma mark-时时彩--二星--注数计算
+(int)Get_ssc_SecondStar_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.playOnlyNum integerValue]==58001||[WFmodel.playOnlyNum integerValue]==65001) {//直选复式
        return [MCStakeUntits Get_ssc_Star_Direct_DoubleWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==60001||[WFmodel.playOnlyNum integerValue]==67001){//直选和值
        return [MCStakeUntits Get_ssc_SecondStar_Direct_ValueWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==61001||[WFmodel.playOnlyNum integerValue]==68001){//直选跨度
        return [MCStakeUntits Get_ssc_SecondStar_Direct_KuaDuWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==62001||[WFmodel.playOnlyNum integerValue]==69001){//组选复式
        return [MCStakeUntits Get_ssc_CCOMBINATIONNumWith:WFmodel andT:2 andAC:@"C"];
    }else if ([WFmodel.playOnlyNum integerValue]==63001||[WFmodel.playOnlyNum integerValue]==70001){//组选和值
        return [MCStakeUntits Get_SecondStar_Group_ValueWith:WFmodel];
    }else if ([WFmodel.playOnlyNum integerValue]==64001||[WFmodel.playOnlyNum integerValue]==71001){//组选包胆
        return 9;
    }else if([WFmodel.playOnlyNum integerValue]==59001||[WFmodel.playOnlyNum integerValue]==66002){//直选单式
        return MCStakeDanShi(WFmodel);
    }
    return 0;
    
}
#pragma mark-时时彩--任选二/三/四--注数计算
+(int)Get_ssc_Optional_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.playOnlyNum integerValue]==88001||[WFmodel.playOnlyNum integerValue]==94001||[WFmodel.playOnlyNum integerValue]==104001) {//直选复式
        
        return [MCStakeUntits Get_ssc_Optional_Direct_DoubleWith:WFmodel ];
        
    }else if ([WFmodel.playOnlyNum integerValue]==90001||[WFmodel.playOnlyNum integerValue]==96001){//直选和值
        
        return [MCStakeUntits Get_ssc_Optional_Direct_ValueWith:WFmodel];
        
    }else if ([WFmodel.playOnlyNum integerValue]==91001||[WFmodel.playOnlyNum integerValue]==97001||[WFmodel.playOnlyNum integerValue]==99001){//任选二--组选复式 //任选三--组三复式 //任选三--组六复式
        
        return [MCStakeUntits Get_ssc_Optional_Group_DoubleWith:WFmodel];
        
    }else if ([WFmodel.playOnlyNum integerValue]==89002||[WFmodel.playOnlyNum integerValue]==92002||[WFmodel.playOnlyNum integerValue]==95001||[WFmodel.playOnlyNum integerValue]==98001||[WFmodel.playOnlyNum integerValue]==105002||[WFmodel.playOnlyNum integerValue]==101002){//任选二--组选单式 /直选单式 //任选三--直选单式/组三单式  //任选四--直选单式 //任选三--组六单式
        
        return [MCStakeUntits Get_ssc_Optional_SimpleWith:WFmodel];
        
    }else if ([WFmodel.playOnlyNum integerValue]==93001||[WFmodel.playOnlyNum integerValue]==103001){//任选二--组选和值  //任选三--组选和值
        
        return [MCStakeUntits Get_ssc_Optional_Group_ValueWith:WFmodel];
        
    }else if ([WFmodel.playOnlyNum integerValue]==102001){//任选三--混合组选
        
        return  [MCStakeUntits Get_ssc_Optional_SimpleWith:WFmodel];
        
    }else if ([WFmodel.playOnlyNum integerValue]==106001||[WFmodel.playOnlyNum integerValue]==107001||[WFmodel.playOnlyNum integerValue]==108001||[WFmodel.playOnlyNum integerValue]==109001){//任选四--组选24 //任选四--组选12  //任选四--组选6  //任选四--组选4
        
        return  [MCStakeUntits Get_ssc_Optional4_GroupWith:WFmodel];
        
    }
    
    return 0;
}

/*
 * 五星、四星、三星、二星
 * 直选复式
 */
+(int)Get_ssc_Star_Direct_DoubleWith:(MCBasePWFModel *)WFmodel{
    
    if ([WFmodel.playOnlyNum integerValue]==10001) {//五星
        return MCStakeWT(5, MC_Multip, WFmodel);
    }else if ([WFmodel.playOnlyNum integerValue]==19001){//四星
        return MCStakeWT(4, MC_Multip, WFmodel);
    }else if([WFmodel.playOnlyNum integerValue]==25001||[WFmodel.playOnlyNum integerValue]==36001||[WFmodel.playOnlyNum integerValue]==47001){//三星
        return MCStakeWT(3, MC_Multip, WFmodel);
    }else{
        return MCStakeWT(2, MC_Multip, WFmodel);
    }
}

+(int)Get_ssc_CCOMBINATIONNumWith:(MCBasePWFModel *)WFmodel andT:(int)t andAC:(NSString *)aOrc{
    
    
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int m=(int)model1.selectedArray.count;
    if (m<t) {
        return 0;
    }
    if ([aOrc isEqualToString:@"A"]) {
        return MC_ACOMBINATION(m, t);
    }else{
        return MC_CCOMBINATION(m, t);
    }
    
}

+(int)GetNumCHaoDanHaoWith:(MCBasePWFModel *)WFmodel andT:(int)t Type:(NSInteger)type{
    if (WFmodel.baseSelectedModel.count<2) {
        return 0;
    }
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    MCBaseSelectedModel * model2 = nil;
    if (WFmodel.baseSelectedModel.count >1) {
        model2 = [WFmodel.baseSelectedModel objectAtIndex:1];
    }
    
    NSArray * CHao,*DanHao;
    if (model1.index==0) {
        CHao=model1.selectedArray;
        DanHao=model2.selectedArray;
    }else{
        CHao=model2.selectedArray;
        DanHao=model1.selectedArray;
    }
    //    if (DanHao.count<t) {
    //        return 0;
    //    }
    int Number=0;
    if (type==1) {//对重号进行循环
        for (NSString * str in CHao) {
            int m=(int)DanHao.count-[MCStakeUntits Get_SameCountWithStr:str inArr:DanHao];
            if (m<t) {
            }else{
                Number = MC_CCOMBINATION(m, t) + Number;
            }
        }
    }else if(type==2){//对单号进行循环
        for (NSString * str in DanHao) {
            int m=(int)CHao.count-[MCStakeUntits Get_SameCountWithStr:str inArr:CHao];
            if (m<t) {
            }else{
                Number = MC_CCOMBINATION(m, t) + Number;
            }
        }
    }
    
    return Number;
}

/*
 *  计算字符串在数组中相同的个数
 */
+(int)Get_SameCountWithStr:(NSString *)str inArr:(NSArray *)arr{
    int count=0;
    for (NSString * item in arr) {
        if ([item isEqualToString:str]) {
            count++;
        }
    }
    return count;
}

/*
 * 五星
 * 总和大小单双
 * 至少选1个码
 */
+(int)Get_ssc_FiveStar_ALLSimpleDoubleWith:(MCBasePWFModel *)WFmodel{
    return MCStakeBallNum(WFmodel);
    
}

/*
 * 三星（包含前三 中三 后三）
 * 直选和值
 */
+(int)Get_ThirdStar_Direct_ValueWith:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int Count=0;
    for (NSString * str in model1.selectedArray) {
        Count+=[MCStakeUntits GetDirect_ValueNum:str ];
    }
    return Count;
}

+(int)GetDirect_ValueNum:(NSString *)Snum {
    
    int n =[Snum intValue];
    if (n>27||n<0) {
        return 0;
    }
    if (n<=9) {
        return (n+2)*(n+1)/2;
    }else if(9<n&&n<=13){
        return 55+(10-(13-n)*(13-n+1)/2)*2;
    }else if(13<n&&n<=18){
        return 75-((n-14)*(n-14+1)/2)*2;
    }else {//19-27
        return ABS(n-28)*(ABS(n-28)+1)/2;
    }
    return 0;
}

/*
 * 三星（包含前三 中三 后三）
 * 直选跨度
 */
+(int)Get_ssc_ThirdStar_Direct_KuaDuWith:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int count =0;
    for (NSString * str in model1.selectedArray) {
        count+= [MCStakeUntits GetNumDirect_KuaDu:str andT:6 andStarNum:3];
    }
    return count;
}

+(int)GetNumDirect_KuaDu:(NSString *)num andT:(int)t andStarNum:(int)star{
    int n=[num intValue];
    if (n==0) {
        return 10;
    }
    if (star==3) {
        return MC_CCOMBINATION(10-n, 1)*t*n;
    }else{
        return MC_CCOMBINATION(10-n, 1)*t;
    }
    
}


/*
 * 三星（包含前三 中三 后三）
 * 组选和值
 */
+(int)Get_ssc_ThirdStar_Group_ValueWith:(MCBasePWFModel *)WFmodel{
    NSDictionary * counts=@{@"01":@"1",@"02":@"2",@"03":@"2",@"04":@"4",@"05":@"5 ",@"06":@"6",@"07":@"8",@"08":@"10",@"09":@"11",@"10":@"13",@"11":@"14",@"12":@"14",@"13":@"15",@"14":@"15",@"15":@"14",@"16":@"14",@"17":@"13",@"18":@"11",@"19":@"10",@"20":@"8",@"21":@"6",@"22":@"5",@"23":@"4",@"24":@"2",@"25":@"2",@"26":@"1",@"1":@"1",@"2":@"2",@"3":@"2",@"4":@"4",@"5":@"5 ",@"6":@"6",@"7":@"8",@"8":@"10",@"9":@"11"};
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int Count=0;
    for (NSString * str in model1.selectedArray) {
        Count+=[[counts objectForKey:str] intValue];
    }
    return Count;
    
}

/*
 * 二星（包含前二和后二）
 * 直选和值
 */
+(int)Get_ssc_SecondStar_Direct_ValueWith:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int Count=0;
    for (NSString * str in model1.selectedArray) {
        Count+=[MCStakeUntits GetNum:str];
    }
    return Count;
}
+(int)GetNum:(NSString *)str{
    if ([str intValue]<10) {
        return [str intValue]+1;
    }else{
        return ABS(([str intValue]-19));
    }
}

/*
 * 二星（包含前二和后二）
 * 直选跨度
 */
+(int)Get_ssc_SecondStar_Direct_KuaDuWith:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int count =0;
    for (NSString * str in model1.selectedArray) {
        count+= [MCStakeUntits GetNumDirect_KuaDu:str andT:2 andStarNum:2];
    }
    return count;
}



/*
 * 二星（包含前二和后二）
 * 组选和值
 */
+(int)Get_SecondStar_Group_ValueWith:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int Count=0;
    for (NSString * str in model1.selectedArray) {
        Count+=[MCStakeUntits Get_SecondStar_Group_ValueNum:str ];
    }
    return Count;
}
+(int)Get_SecondStar_Group_ValueNum:(NSString *)str {
        if ([str intValue]<10) {
            return ([str intValue]+1)/2;
        }else{
            return ABS(([str intValue]-19))/2;
        }

    
}

/*
 * SSC
 * 定位胆
 */
+(int)Get_ssc_LocalDWith:(MCBasePWFModel *)WFmodel{
    int count=0;
    for (MCBaseSelectedModel * item in WFmodel.baseSelectedModel) {
        count+=item.selectedArray.count;
    }
    return count;
}

/*
 * SSC
 * 不定位
 */
+(int)Get_ssc_UnsureWeiWith:(MCBasePWFModel *)WFmodel{
    int  MaShu =0;
    if([WFmodel.playOnlyNum integerValue]==73001||[WFmodel.playOnlyNum integerValue]==75001||[WFmodel.playOnlyNum integerValue]==77001||[WFmodel.playOnlyNum integerValue]==79001||[WFmodel.playOnlyNum integerValue]==81001){//一码
        MaShu=1;
    }else if([WFmodel.playOnlyNum integerValue]==74001||[WFmodel.playOnlyNum integerValue]==76001||[WFmodel.playOnlyNum integerValue]==78001||[WFmodel.playOnlyNum integerValue]==80001||[WFmodel.playOnlyNum integerValue]==82001){//二码
        MaShu=2;
    }else if([WFmodel.playOnlyNum integerValue]==83001){//三码
        MaShu=3;
    }
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    
    if (model1.selectedArray.count<MaShu) {
        return 0;
    }
    int m=(int)model1.selectedArray.count;
    return MC_CCOMBINATION(m, MaShu);
}


/*
 * SSC
 * 大小单双
 */
+(int)Get_ssc_SimpleDoubleWith:(MCBasePWFModel *)WFmodel{
    int Type=0;
    //后二/前二
    if ([WFmodel.playOnlyNum integerValue]==84001||[WFmodel.playOnlyNum integerValue]==86001) {
        Type=2;
        //后三/前三
    }else if([WFmodel.playOnlyNum integerValue]==85001||[WFmodel.playOnlyNum integerValue]==87001){
        Type=3;
    }
    
    if (WFmodel.baseSelectedModel.count<Type) {
        return 0;
    }else{
        MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
        MCBaseSelectedModel * model2 = [WFmodel.baseSelectedModel objectAtIndex:1];
        if (Type==2) {
            return (int)model1.selectedArray.count*(int)model2.selectedArray.count;
        }
        MCBaseSelectedModel * model3 = [WFmodel.baseSelectedModel objectAtIndex:2];
        return (int)model1.selectedArray.count*(int)model2.selectedArray.count*(int)model3.selectedArray.count;
    }
}


/*
 * SSC
 * 任选二，三，四
 * 直选复式
 */
+(int)Get_ssc_Optional_Direct_DoubleWith:(MCBasePWFModel *)WFmodel{
    
    int Wan=0,Qian=0,Bai=0,Shi=0,Ge=0;
    for (MCBaseSelectedModel * item in WFmodel.baseSelectedModel) {
        if(item.index==0){
            Wan=(int)item.selectedArray.count;
        }else if(item.index==1){
            Qian=(int)item.selectedArray.count;
        }else if(item.index==2){
            Bai=(int)item.selectedArray.count;
        }else if(item.index==3){
            Shi=(int)item.selectedArray.count;
        }else if(item.index==4){
            Ge=(int)item.selectedArray.count;
        }
    }
    // 任选二
    if ([WFmodel.typeId intValue]==10) {
        return Wan*Qian+Wan*Bai+Wan*Shi+Wan*Ge
        +Qian*Bai+Qian*Shi+Qian*Ge
        +Bai*Shi+Bai*Ge
        +Shi*Ge;
        
        // 任选三
    }else if([WFmodel.typeId intValue]==11){
        
        return Wan*Qian*Bai+Wan*Qian*Shi+Wan*Qian*Ge+Wan*Bai*Shi+Wan*Bai*Ge+Wan*Shi*Ge
        +Qian*Bai*Shi+Qian*Shi*Ge+Qian*Bai*Ge
        +Bai*Shi*Ge;
        
        // 任选四
    }else if ([WFmodel.typeId intValue]==12){
        return Wan*Qian*Bai*Shi+Wan*Qian*Bai*Ge+Wan*Qian*Shi*Ge+Wan*Bai*Shi*Ge
        +Qian*Bai*Shi*Ge;
    }
    return 0;
}

/*
 * SSC
 * 任选二，三
 * 直选和值
 */
+(int)Get_ssc_Optional_Direct_ValueWith:(MCBasePWFModel *)WFmodel{
    int m=(int)[WFmodel.selectedCardArray count];//选项卡的个数
    // 任选二
    if ([WFmodel.typeId intValue]==10) {
        if (m<2) {
            return 0;
        }
        return [MCStakeUntits Get_ssc_SecondStar_Direct_ValueWith:WFmodel]*MC_CCOMBINATION(m, 2);
        // 任选三
    }else if([WFmodel.typeId intValue]==11){
        if (m<3) {
            return 0;
        }
        return [MCStakeUntits Get_ThirdStar_Direct_ValueWith:WFmodel]*MC_CCOMBINATION(m, 3);
    }
    return 0;
}

/*
 * SSC
 * 任选二，三，四
 * 组选复式
 */
+(int)Get_ssc_Optional_Group_DoubleWith:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int m=(int)[WFmodel.selectedCardArray count];//选项卡的个数
    int n=(int)model1.selectedArray.count;//
    // 任选二
    if ([WFmodel.typeId intValue]==10) {
        if (m<2) {
            return 0;
        }
        return MC_CCOMBINATION(m, 2)*MC_CCOMBINATION(n, 2);
        
        // 任选三  组三复式
    }else if([WFmodel.playOnlyNum intValue]==97001){
        if (m<3) {
            return 0;
        }
        return MC_CCOMBINATION(m, 3)*MC_ACOMBINATION(n, 2);
        // 任选三  组六复式
    }else if([WFmodel.playOnlyNum intValue]==99001){
        if (m<3) {
            return 0;
        }
        return MC_CCOMBINATION(m, 3)*MC_CCOMBINATION(n, 3);
    }
    return 0;
}

/*
 * SSC
 * 任选二，三，四
 * 组选和值
 */
+(int)Get_ssc_Optional_Group_ValueWith:(MCBasePWFModel *)WFmodel{
    int m=(int)[WFmodel.selectedCardArray count];//选项卡的个数
    // 任选二
    if ([WFmodel.typeId intValue]==10) {
        if (m<2) {
            return 0;
        }
        return [MCStakeUntits Get_SecondStar_Group_ValueWith:WFmodel]*MC_CCOMBINATION(m, 2);
        // 任选三
    }else if([WFmodel.typeId intValue]==11){
        if (m<3) {
            return 0;
        }
        return [MCStakeUntits Get_ssc_ThirdStar_Group_ValueWith:WFmodel]*MC_CCOMBINATION(m, 3);
    }
    return 0;
}

/*
 * SSC
 * 任选二，三，四
 * 单式
 */
+(int)Get_ssc_Optional_SimpleWith:(MCBasePWFModel *)WFmodel{
    int n=(int)WFmodel.danShiArray.count;
    int m=(int)[WFmodel.selectedCardArray count];//选项卡的个数
    // 任选二
    if ([WFmodel.typeId intValue]==10) {
        if (m<2) {
            return 0;
        }
        return n*MC_CCOMBINATION(m, 2);
        
        // 任选三
    }else if([WFmodel.typeId intValue]==11){
        if (m<3) {
            return 0;
        }
        return n*MC_CCOMBINATION(m, 3);
        
        // 任选四
    }else if([WFmodel.typeId intValue]==12){
        if (m<4) {
            return 0;
        }
        return n*MC_CCOMBINATION(m, 4);
    }
    return 0;
}

/*
 * SSC
 * 任选四
 * 组选24，12，6，4
 */
+(int)Get_ssc_Optional4_GroupWith:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
    int n=(int)model1.selectedArray.count;
    int m=(int)[WFmodel.selectedCardArray count];//选项卡的个数
    if (m<4) {
        return 0;
    }
    //组选24
    if([WFmodel.playOnlyNum integerValue]==106001){
        
        return MC_CCOMBINATION(n, 4)*MC_CCOMBINATION(m, 4);
        
        //组选12
    }else if ([WFmodel.playOnlyNum integerValue]==107001){
        
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:2 Type:1]*MC_CCOMBINATION(m, 4);
        
        //组选6
    }else if ([WFmodel.playOnlyNum integerValue]==108001){
        
        return MC_CCOMBINATION(n, 2)*MC_CCOMBINATION(m, 4);
        
        //组选4
    }else if ([WFmodel.playOnlyNum integerValue]==109001){
        
        return [MCStakeUntits GetNumCHaoDanHaoWith:WFmodel andT:1 Type:1]*MC_CCOMBINATION(m, 4);
        
    }
    return 0;
}


#pragma mark-快3
+(int)Get_k3_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    
    switch ([WFmodel.typeId intValue]) {
            //和值
        case 0:
            //三同号
        case 1:
            return [MCStakeUntits Get_k3_Value_3T_DTYSWith:WFmodel];
            break;
            //三不同号
        case 2:
            return [MCStakeUntits Get_k3_3BTWith:WFmodel];
            break;
            //三连号
        case 3:
            return 1;
            break;
            //二同号
        case 4:
            return [MCStakeUntits Get_k3_2TWith:WFmodel];
            break;
            //二不同号
        case 5:
            return [MCStakeUntits Get_k3_2BTWith:WFmodel];
            break;
            //单挑一骰
        case 6:
            return [MCStakeUntits Get_k3_Value_3T_DTYSWith:WFmodel];
            break;
            
        default:
            break;
    }
    return 0;
}

/*
 * k3
 * 和值、三同号、单挑一骰
 */
+(int)Get_k3_Value_3T_DTYSWith:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.playOnlyNum intValue]== 13001) {
        return 1;
    }
    return MCStakeBallNum(WFmodel);
}

/*
 * k3
 * 三不同
 */
+(int)Get_k3_3BTWith:(MCBasePWFModel *)WFmodel{
    //标准
    if ([WFmodel.playOnlyNum intValue]== 14001) {
        return MCStakeCorA(3, MC_CC, WFmodel);
        //胆拖
    }else if ([WFmodel.playOnlyNum intValue]== 15001){
        return  MCStakeDMTM(3, WFmodel);
    }
    return 0;
}

/*
 * k3
 * 二同号
 */
+(int)Get_k3_2TWith:(MCBasePWFModel *)WFmodel{
    //单选
    if ([WFmodel.playOnlyNum integerValue]==17001) {
        //同号的个数 * 不同号的个数
        return MCStakeWT(2, MC_Multip, WFmodel);
        //复选
    }else if ([WFmodel.playOnlyNum integerValue]==18001){
        return MCStakeBallNum(WFmodel);
    }
    return 0;
}

/*
 * k3
 * 二不同号
 */
+(int)Get_k3_2BTWith:(MCBasePWFModel *)WFmodel{
    //标准
    if ([WFmodel.playOnlyNum intValue]== 19001) {
        return MCStakeCorA(2, MC_CC, WFmodel);
        //胆拖
    }else if ([WFmodel.playOnlyNum intValue]== 20001){
        return  MCStakeDMTM(2, WFmodel);
    }
    return 0;
}


#pragma mark-快乐8
+(int)Get_kl8_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    switch ([WFmodel.typeId integerValue]) {
            //任选
        case 0:
            return [MCStakeUntits Get_kl8_OptionalWith:WFmodel];
            break;
            //趣味
        case 1:
            //五行
        case 2:
            return [MCStakeUntits Get_kl8_QW_WXWith:WFmodel];
            break;
        default:
            break;
    }
    return 0;
    
}

/*
 * kl8
 * 任选
 */
+(int)Get_kl8_OptionalWith:(MCBasePWFModel *)WFmodel{
    int n=([WFmodel.playOnlyNum intValue]-9000)/1000;
    return MCStakeCorA(n, MC_CC, WFmodel);
}
/*
 * kl8
 * 趣味 五行
 */
+(int)Get_kl8_QW_WXWith:(MCBasePWFModel *)WFmodel{
    return MCStakeBallNum(WFmodel);
}


#pragma mark-3D
+(int)Get_sd_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    
    
    switch ([WFmodel.typeId integerValue]) {
            //三星
        case 0:
            return [MCStakeUntits Get_sd_ThirdStarWith:WFmodel];
            break;
            //前二
        case 1:
            //后二
        case 2:
            return [MCStakeUntits Get_sd_SecondStarWith:WFmodel];
            break;
            //定位胆
        case 3:
            //不定胆
        case 4:
            return [MCStakeUntits Get_sd_LocalD_UnSureDWith:WFmodel];
            break;
        default:
            break;
    }
    return 0;
}

/*
 * 3D
 * 三星
 */
+(int)Get_sd_ThirdStarWith:(MCBasePWFModel *)WFmodel{
    //直选复式
    if ([WFmodel.playOnlyNum integerValue]==10001) {
        //百位*十位*个位
        return MCStakeWT(3, MC_Multip, WFmodel);
        //直选和值
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        //和时时彩三星直选和值一样
        return [MCStakeUntits Get_ThirdStar_Direct_ValueWith:WFmodel];
        //组三
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        return MCStakeCorA(2, MC_AA, WFmodel);
        //组六
    }else if ([WFmodel.playOnlyNum integerValue]==15001){
        return MCStakeCorA(3, MC_CC, WFmodel);
        //单式、混合
    }else{
        return MCStakeDanShi(WFmodel);
        
    }
}

/*
 * 3D
 * 前二/后二
 */
+(int)Get_sd_SecondStarWith:(MCBasePWFModel *)WFmodel{
    //直选复式
    if ([WFmodel.playOnlyNum integerValue]==21001||[WFmodel.playOnlyNum integerValue]==29001) {
        return MCStakeWT(2, MC_Multip, WFmodel);
        //单式
    }else{
        return MCStakeDanShi(WFmodel);
    }
}
/*
 * 3D
 * 定位胆、不定胆
 */
+(int)Get_sd_LocalD_UnSureDWith:(MCBasePWFModel *)WFmodel{
    //定位胆
    if ([WFmodel.typeId integerValue]==3) {
        //百位+十位+个位
        return MCStakeWT(3, MC_Add, WFmodel);
        //不定胆
    }else{
        //一码不定胆
        if ([WFmodel.playOnlyNum integerValue]==38001) {
            return MCStakeBallNum(WFmodel);
            //二码不定胆
        }else{
            return MCStakeCorA(2, MC_CC, WFmodel);
        }
    }
}

#pragma mark-PK10
+(int)Get_pks_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    switch ([WFmodel.typeId integerValue]) {
            
            //猜冠军
        case 0:
            return [MCStakeUntits Get_pks_CGJ_DX_DS_LH_With:WFmodel];
            break;
            //猜冠亚军
        case 1:
            return [MCStakeUntits Get_pks_CGYJ_With:WFmodel];
            break;
            //猜前三名
        case 2:
            return [MCStakeUntits Get_pks_CQSM_With:WFmodel];
            break;
            //定位胆
        case 3:
            return [MCStakeUntits Get_pks_LocalD_With:WFmodel];
            break;
            //大小
        case 4:
            //单双
        case 5:
            //龙虎
        case 6:
            return [MCStakeUntits Get_pks_CGJ_DX_DS_LH_With:WFmodel];
            break;
        default:
            break;
    }
    return 0;
}
/*
 * PK10
 * 猜冠军 大小 单双 龙虎
 */
+(int)Get_pks_CGJ_DX_DS_LH_With:(MCBasePWFModel *)WFmodel{
    return MCStakeBallNum(WFmodel);
}

/*
 * PK10
 * 猜冠亚军
 */
+(int)Get_pks_CGYJ_With:(MCBasePWFModel *)WFmodel{
    //复式
    if ([WFmodel.playOnlyNum integerValue]==11001) {
        
        if (WFmodel.baseSelectedModel.count<2) {
            return 0;
        }
        MCBaseSelectedModel * model1 = [WFmodel.baseSelectedModel objectAtIndex:0];
        MCBaseSelectedModel * model2 = [WFmodel.baseSelectedModel objectAtIndex:1];
        NSArray * GJArry=model1.selectedArray;
        NSArray * YJArry=model2.selectedArray;
        int count=0;
        for (NSString * GJun in GJArry) {
            if ([MCStakeUntits isHaveSame:GJun inArry:YJArry]) {
                count+=(YJArry.count-1);
            }else{
                count+=YJArry.count;
            }
        }
        return count;
        //单式
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        return MCStakeDanShi(WFmodel);
    }
    return 0;
}
+(BOOL)isHaveSame:(NSString *)str inArry:(NSArray *)arr{
    for (NSString * item in arr) {
        if ([item isEqualToString:str]) {
            return YES;
        }
    }
    return NO;
}
/*
 * PK10
 * 猜前三名
 */
+(int)Get_pks_CQSM_With:(MCBasePWFModel *)WFmodel{
    //复式
    if ([WFmodel.playOnlyNum integerValue]==13001) {
        return MCStakeOnlyNum(3, WFmodel);
        //单式
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        return MCStakeDanShi(WFmodel);
    }
    return 0;
}
/*
 * PK10
 * 定位胆
 */
+(int)Get_pks_LocalD_With:(MCBasePWFModel *)WFmodel{
    //冠军+亚军+季军+第四+第五
    return MCStakeWT(5, MC_Add, WFmodel);
}

#pragma mark-时时乐
+(int)Get_ssl_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    
    
    switch ([WFmodel.typeId integerValue]) {
            //三星
        case 0:
            return [MCStakeUntits Get_ssl_3Star_With:WFmodel];
            break;
            //前二
        case 1:
            //后二
        case 2:
            return [MCStakeUntits Get_ssl_2Star_With:WFmodel];
            break;
            //前一
        case 3:
            //后一
        case 4:
            return [MCStakeUntits Get_ssl_1Star_With:WFmodel];
            break;
        default:
            break;
    }
    return 0;
    
}
/*
 * 时时乐
 * 三星
 */
+(int)Get_ssl_3Star_With:(MCBasePWFModel *)WFmodel{
    //直选复式
    if ([WFmodel.playOnlyNum integerValue]==10001) {
        //百位*十位*个位
        return MCStakeWT(3, MC_Multip, WFmodel);
        //直选单式
    }else if ([WFmodel.playOnlyNum integerValue]==11001){
        return MCStakeDanShi(WFmodel);
        //直选和值
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        //和时时彩三星直选和值一样
        return [MCStakeUntits Get_ThirdStar_Direct_ValueWith:WFmodel];
        //组三
    }else if ([WFmodel.playOnlyNum integerValue]==13001){
        return MCStakeCorA(2, MC_AA, WFmodel);
        //组六
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        return MCStakeCorA(3, MC_CC, WFmodel);
    }
    return 0;
}
/*
 * 时时乐
 * 前二、后二
 */
+(int)Get_ssl_2Star_With:(MCBasePWFModel *)WFmodel{
    //直选复式
    if ([WFmodel.playOnlyNum integerValue]==15001||[WFmodel.playOnlyNum integerValue]==20001) {
        return MCStakeWT(2, MC_Multip, WFmodel);
        //直选单式
    }else if ([WFmodel.playOnlyNum integerValue]==16001||[WFmodel.playOnlyNum integerValue]==21001){
        return MCStakeDanShi(WFmodel);
        //直选和值
    }else if ([WFmodel.playOnlyNum integerValue]==17001||[WFmodel.playOnlyNum integerValue]==22001){
        //同时时彩2星 直选和值
        return [MCStakeUntits Get_ssc_SecondStar_Direct_ValueWith:WFmodel];
        //组选复式
    }else if ([WFmodel.playOnlyNum integerValue]==18001||[WFmodel.playOnlyNum integerValue]==23001){
        return MCStakeCorA(2, MC_CC, WFmodel);
        //组选单式
    }else if ([WFmodel.playOnlyNum integerValue]==19001||[WFmodel.playOnlyNum integerValue]==24001){
        return MCStakeDanShi(WFmodel);
    }
    return 0;
}

/*
 * 时时乐
 * 前一、后一
 */
+(int)Get_ssl_1Star_With:(MCBasePWFModel *)WFmodel{
    return MCStakeBallNum(WFmodel);
}


#pragma mark-排列3
+(int)Get_pls_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    
    
    switch ([WFmodel.typeId integerValue]) {
            //三星
        case 0:
            return [MCStakeUntits Get_pls_3Star_With:WFmodel];
            break;
            //前二
        case 1:
            //后二
        case 2:
            return [MCStakeUntits Get_pls_2Star_With:WFmodel];
            break;
            //定位胆
        case 3:
            return [MCStakeUntits Get_pls_LocalD_With:WFmodel];
            break;
            //不定胆
        case 4:
            return [MCStakeUntits Get_pls_UnsureD_With:WFmodel];
            break;
        default:
            break;
    }
    return 0;
    
}
/*
 * 排列3
 * 三星
 */
+(int)Get_pls_3Star_With:(MCBasePWFModel *)WFmodel{
    //直选复式
    if ([WFmodel.playOnlyNum integerValue]==10001) {
        //百位*十位*个位
        return MCStakeWT(3, 1, WFmodel);
        //直选单式 混合组选
    }else if ([WFmodel.playOnlyNum integerValue]==11001){
        return MCStakeDanShi(WFmodel);
        //直选和值
    }else if ([WFmodel.playOnlyNum integerValue]==12001){
        //和时时彩三星直选和值一样
        return [MCStakeUntits Get_ThirdStar_Direct_ValueWith:WFmodel];
        //组三
    }else if ([WFmodel.playOnlyNum integerValue]==14001){
        return MCStakeCorA(2, MC_AA, WFmodel);
        //组六
    }else if ([WFmodel.playOnlyNum integerValue]==15001){
        return MCStakeCorA(3, MC_CC, WFmodel);;
    }
    return 0;
    
    
}
/*
 * 排列3
 * 二星
 */
+(int)Get_pls_2Star_With:(MCBasePWFModel *)WFmodel{
    //直选复式
    if ([WFmodel.playOnlyNum integerValue]==20001||[WFmodel.playOnlyNum integerValue]==28001) {
        return MCStakeWT(2, MC_Multip, WFmodel);
        //直选单式
    }else if([WFmodel.playOnlyNum integerValue]==21001||[WFmodel.playOnlyNum integerValue]==29001){
        return MCStakeDanShi(WFmodel);
    }
    return 0;
    
}
/*
 * 排列3
 * 定位胆
 */
+(int)Get_pls_LocalD_With:(MCBasePWFModel *)WFmodel{
    return MCStakeWT(3, MC_Add, WFmodel);
}
/*
 * 排列3
 * 不定胆
 */
+(int)Get_pls_UnsureD_With:(MCBasePWFModel *)WFmodel{
    //一码
    if ([WFmodel.playOnlyNum integerValue]==37001) {
        return  MCStakeBallNum(WFmodel);
        //二码
    }else{
        return MCStakeCorA(2, MC_CC, WFmodel);
    }
}

#pragma mark-排列5
+(int)Get_plw_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    
    
    switch ([WFmodel.typeId integerValue]) {
            //五星
        case 0:
            return [MCStakeUntits Get_plw_5Star_With:WFmodel];
            break;
            //定位胆
        case 1:
            return [MCStakeUntits Get_plw_LocalD_With:WFmodel];
            break;
            //不定胆
        case 2:
            return [MCStakeUntits Get_plw_UnsureD_With:WFmodel];
            break;
        default:
            break;
    }
    return 0;
    
}
/*
 * 排列5
 * 五星
 */
+(int)Get_plw_5Star_With:(MCBasePWFModel *)WFmodel{
    if ([WFmodel.playOnlyNum integerValue]==10001) {
        return MCStakeWT(5, MC_Multip, WFmodel);
    }else{
        return MCStakeDanShi(WFmodel);
    }
    
}
/*
 * 排列5
 * 定位胆
 */
+(int)Get_plw_LocalD_With:(MCBasePWFModel *)WFmodel{
    return MCStakeWT(5, MC_Add, WFmodel);
}
/*
 * 排列5
 * 不定胆
 */
+(int)Get_plw_UnsureD_With:(MCBasePWFModel *)WFmodel{
    return MCStakeBallNum(WFmodel);
}

#pragma mark-快乐十分
+(int)Get_klsf_StakeNumberWith:(MCBasePWFModel *)WFmodel{
    
    
    switch ([WFmodel.typeId integerValue]) {
        //三星
        case 0:
        return [MCStakeUntits Get_klsf_3Star_With:WFmodel];
        break;
            
        //二星
        case 1:
            return [MCStakeUntits Get_klsf_2Star_With:WFmodel];
            break;
        //定位胆
        case 2:
            return [MCStakeUntits Get_klsf_DingWeiDan_With:WFmodel];
            break;
        //任选复式
        case 3:
            return [MCStakeUntits Get_klsf_OptionalDouble_With:WFmodel];
            break;
        //任选胆拖
        case 4:
            return [MCStakeUntits Get_klsf_OptionalDanTuo_With:WFmodel];
            break;
        //大小单双
        case 5:
            return [MCStakeUntits Get_klsf_Other_With:WFmodel];
            break;
        //四季方位
        case 6:
            return [MCStakeUntits Get_klsf_Other_With:WFmodel];
            break;
        //五行
        case 7:
            return [MCStakeUntits Get_klsf_Other_With:WFmodel];
            break;
        //龙虎
        case 8:
            return [MCStakeUntits Get_klsf_Other_With:WFmodel];
            break;

    }
    return 0;
    
}
    
/*
 * 快乐十分
 * 三星
 */
+(int)Get_klsf_3Star_With:(MCBasePWFModel *)WFmodel{
    
    //前三直选、后三直选
    if ([WFmodel.playOnlyNum integerValue]==10002||[WFmodel.playOnlyNum integerValue]==10001) {
        
        return MCStakeOnlyNum(3, WFmodel);
        
    //前三组选、后三组选
    }else if ([WFmodel.playOnlyNum integerValue]==10003||[WFmodel.playOnlyNum integerValue]==10004){
        MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];

        if (model.selectedArray.count<3) {
            return 0;
        }
        return MC_CCOMBINATION((int)model.selectedArray.count, 3);
    }
    return 0;
    
}
/*
 * 快乐十分
 * 二星
 */
+(int)Get_klsf_2Star_With:(MCBasePWFModel *)WFmodel{
    
    //直选
    if ([WFmodel.playOnlyNum integerValue]==11001) {
        
        return MCStakeOnlyNum(2, WFmodel);
        
    //组选
    }else if ([WFmodel.playOnlyNum integerValue]==11002){
        MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];
        
        if (model.selectedArray.count<2) {
            return 0;
        }
        return MC_CCOMBINATION((int)model.selectedArray.count, 2);
    }
    return 0;
    
}
/*
 * 快乐十分
 * 定位胆
 */
+(int)Get_klsf_DingWeiDan_With:(MCBasePWFModel *)WFmodel{
    
    MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];
    return (int)model.selectedArray.count;
    
}

/*
 * 快乐十分
 * 任选复式
 */
+(int)Get_klsf_OptionalDouble_With:(MCBasePWFModel *)WFmodel{
    
    int t=[WFmodel.playOnlyNum intValue]-13000;
    return MCStakeCorA(t, MC_CC, WFmodel);
    
}

/*
 * 快乐十分
 * 任选胆拖
 */
+(int)Get_klsf_OptionalDanTuo_With:(MCBasePWFModel *)WFmodel{
    
    int t=[WFmodel.playOnlyNum intValue]-14000+1;
    return MCStakeDMTM(t, WFmodel);
    
}

/*
 * 快乐十分
 * 大小单双、四季方位、五行、龙虎
 */
+(int)Get_klsf_Other_With:(MCBasePWFModel *)WFmodel{
    //大小单双-大小单双、四季方位、五行
    if ([WFmodel.playOnlyNum intValue]==15001||[WFmodel.playOnlyNum intValue]==16001||[WFmodel.playOnlyNum intValue]==17001) {
        return MCStakeWT(8, MC_Add, WFmodel);
     
    //大小单双-大小和、龙虎
    }else if ([WFmodel.playOnlyNum intValue]==15002||[WFmodel.typeId intValue]==8){
        MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];
        return (int)model.selectedArray.count;
        
    }
    return 0;
    
}

#pragma mark============公共方法=================
/*
 * 传入位数  符号（1-》乘法  0-》加法）
 */
+(int)Get_Wei:(int)weiCount andType:(Type_Rule)type andModel:(MCBasePWFModel *)WFmodel{
    
    int One=0,Two=0,Three=0,Four=0,Five=0,Six=0,Seven=0,Eight=0;
    for (MCBaseSelectedModel * item in WFmodel.baseSelectedModel) {
        if(item.index==0){
            One=(int)item.selectedArray.count;
        }else if(item.index==1){
            Two=(int)item.selectedArray.count;
        }else if(item.index==2){
            Three=(int)item.selectedArray.count;
        }else if(item.index==3){
            Four=(int)item.selectedArray.count;
        }else if(item.index==4){
            Five=(int)item.selectedArray.count;
        }else if(item.index==5){
            Six=(int)item.selectedArray.count;
        }else if(item.index==6){
            Seven=(int)item.selectedArray.count;
        }else if(item.index==7){
            Eight=(int)item.selectedArray.count;
        }
    }
    if (weiCount==2) {
        return type==MC_Multip?One*Two:(One+Two);
    }else if(weiCount==3){
        return type==MC_Multip?One*Two*Three:(One+Two+Three);
    }else if(weiCount==4){
        return type==MC_Multip?One*Two*Three*Four:(One+Two+Three+Four);
    }else if(weiCount==5){
        return type==MC_Multip?One*Two*Three*Four*Five:(One+Two+Three+Four+Five);
    }else if(weiCount==6){
        return type==MC_Multip?One*Two*Three*Four*Five*Six:(One+Two+Three+Four+Five+Six);
    }else if(weiCount==7){
        return type==MC_Multip?One*Two*Three*Four*Five*Six*Seven:(One+Two+Three+Four+Five+Six+Seven);
    }else if(weiCount==8){
        return type==MC_Multip?One*Two*Three*Four*Five*Six*Seven*Eight:(One+Two+Three+Four+Five+Six+Seven+Eight);
    }
    return 0;
    
}

/*
 * 所选球个数
 */
+(int)Get_BallNumWithModel:(MCBasePWFModel *)WFmodel{
    MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];
    return (int)model.selectedArray.count;
}

/*
 * 单式
 */
+(int)Get_DanShiWithModel:(MCBasePWFModel *)WFmodel{
    return (int)WFmodel.danShiArray.count;
}

/*
 * C(m,t)/A(m,t)
 * type 1->A 0->C
 */
+(int)MC_CorAWithT:(int)t andType:(Type_CCorAA)type andModel:(MCBasePWFModel *)WFmodel{
    
    MCBaseSelectedModel * model = [WFmodel.baseSelectedModel objectAtIndex:0];
    if (model.selectedArray.count<t) {
        return 0;
    }
    
    return type==MC_AA?MC_ACOMBINATION((int)model.selectedArray.count, t):MC_CCOMBINATION((int)model.selectedArray.count, t);
}
/*
 * 胆拖
 */
+(int)Get_DMTMWithT:(int)t andModel:(MCBasePWFModel *)WFmodel{
    
    int TMcode=0,DMcode=0;
    for (MCBaseSelectedModel * item in WFmodel.baseSelectedModel) {
        if(item.index==0){
            DMcode=(int)item.selectedArray.count;
        }else if(item.index==1){
            TMcode=(int)item.selectedArray.count;
        }
    }
    if (DMcode==0) {
        return 0;
    }
    if (TMcode<(t-DMcode)) {
        return 0;
    }
    return MC_CCOMBINATION(TMcode, t-DMcode);
}
/*
 * 2/3组各不相同
 */
+(int)Get_OnlyNumWithT:(int)t Model:(MCBasePWFModel *)WFmodel{
    NSMutableArray * marr1=[[NSMutableArray alloc]init];
    NSMutableArray * marr2=[[NSMutableArray alloc]init];
    NSMutableArray * marr3=[[NSMutableArray alloc]init];
    for (MCBaseSelectedModel * item in WFmodel.baseSelectedModel) {
        if (item.index==0) {
            marr1=[NSMutableArray arrayWithArray:item.selectedArray];
        }else if(item.index==1){
            marr2=[NSMutableArray arrayWithArray:item.selectedArray];
        }else if(item.index==2){
            marr3=[NSMutableArray arrayWithArray:item.selectedArray];
        }
    }
    int  count =0;
    if (t==2) {
        for (NSString * num1 in marr1) {
            for ( NSString * num2 in marr2) {
                if (![num1 isEqualToString:num2]) {
                    count++;
                }
            }
        }
    }else if(t==3){
        for (NSString * num1 in marr1) {
            for ( NSString * num2 in marr2) {
                for ( NSString * num3 in marr3) {
                    if (![num1 isEqualToString:num2]) {//num1!=num2!=num3
                        if (![num3 isEqualToString:num2]) {
                            if (![num3 isEqualToString:num1]) {
                                count++;
                            }
                        }
                    }
                }
            }
        }
    }
    return count;
}

@end



/*
 * 返回球的注数、金额等
 */
@implementation MCBallPropertyModel


@end





















