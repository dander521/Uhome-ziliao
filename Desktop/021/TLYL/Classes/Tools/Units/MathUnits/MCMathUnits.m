//
//  MCMathUnits.m
//  TLYL
//
//  Created by miaocai on 2017/6/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMathUnits.h"
#import "MCStakeUntits.h"
#define Delete0Marr(arr,model) [MCMathUnits GetNumberWith:arr andModel:model]

#define MCChineseToNum(chineseArr,numArr,content)  [MCMathUnits tzChinese:chineseArr ToNum:numArr andContent:content]

#define MCNumToChinese(chineseArr,numArr,content) [MCMathUnits tzNum:numArr ToChinese:chineseArr andContent:content]
@implementation MCMoneyModel

@end

@implementation MCMathUnits
#pragma mark-传入model 返回格式

+(MCPaySelectedCellModel *)GetFormatWithWFModel:(MCBasePWFModel *)WFmodel{
    
    MCPaySelectedCellModel * Pmodel =[[MCPaySelectedCellModel alloc]init];
    
    MCBasePWFModel *WF_model=[[MCBasePWFModel alloc]init];
    WF_model.ballCount=WFmodel.ballCount;
    WF_model.ballStartNumber=WFmodel.ballStartNumber;
    WF_model.ballEndNumber=WFmodel.ballEndNumber;
    WF_model.ballColor=WFmodel.ballColor;
    WF_model.ballText=WFmodel.ballText;
    WF_model.columnCount=WFmodel.columnCount;
    WF_model.info=WFmodel.info;
    WF_model.lineCount=WFmodel.lineCount;
    WF_model.maxBallNumber=WFmodel.maxBallNumber;
    WF_model.methodId=WFmodel.methodId;
    WF_model.minBallNumber=WFmodel.minBallNumber;
    WF_model.mutex=WFmodel.mutex;
    WF_model.name=WFmodel.name;
    WF_model.playOnlyNum=WFmodel.playOnlyNum;
    WF_model.typeId=WFmodel.typeId;
    WF_model.typeName=WFmodel.typeName;
    WF_model.item=WFmodel.item;
    WF_model.filterCriteria=WFmodel.filterCriteria;
    WF_model.lotteryCategories=WFmodel.lotteryCategories;
    
    NSMutableArray <MCBaseSelectedModel *>*BaseSelectedModel=[[NSMutableArray alloc]init];
    for (MCBaseSelectedModel *bbModel in WFmodel.baseSelectedModel) {
        MCBaseSelectedModel *bbbModel=[[MCBaseSelectedModel alloc]init];
        bbbModel.index=bbModel.index;
        bbbModel.selectedArray=bbModel.selectedArray;
        [BaseSelectedModel addObject:bbbModel];
    }
    WF_model.baseSelectedModel=BaseSelectedModel;
    
    WF_model.lineH=WFmodel.lineH;
    WF_model.SelectedCardNumber=WFmodel.SelectedCardNumber;
    WF_model.isShowSelectedCard=WFmodel.isShowSelectedCard;
    WF_model.selectedCardArray=WFmodel.selectedCardArray;
    WF_model.danShiArray=WFmodel.danShiArray;
    WF_model.isMachineSelectEnabled=WFmodel.isMachineSelectEnabled;
    WF_model.tongxuan=WFmodel.tongxuan;
    WF_model.filterCriteriaNotAll=WFmodel.filterCriteriaNotAll;
    WF_model.isDingWeiDan=WFmodel.isDingWeiDan;
    WF_model.isDanTuo=WFmodel.isDanTuo;
    WF_model.czName=WFmodel.czName;
    WF_model.LotteryID=WFmodel.LotteryID;
    WF_model.yuanJiaoFen=WFmodel.yuanJiaoFen;
    WF_model.multiple=WFmodel.multiple;
    WF_model.bonus=WFmodel.bonus;
    WF_model.yinli=WFmodel.yinli;
    WF_model.payMoney=WFmodel.payMoney;
    WF_model.stakeNumber=WFmodel.stakeNumber;
    WF_model.isAddZero=WFmodel.isAddZero;
    WF_model.SaleState=WFmodel.SaleState;
    WF_model.BetMode=WFmodel.BetMode;
    WF_model.IssueNumber=WFmodel.IssueNumber;
    WF_model.Mode=WFmodel.Mode;
    WF_model.czRebate=WFmodel.czRebate;
    WF_model.czTZRebate=WFmodel.czTZRebate;
    WF_model.userRegisterRebate=WFmodel.userRegisterRebate;
    WF_model.shangHuRebate=WFmodel.shangHuRebate;
    WF_model.shangHuMinRebate=WFmodel.shangHuMinRebate;
    WF_model.XRebate=WFmodel.XRebate;
    WF_model.userSelectedRebate=WFmodel.userSelectedRebate;
    WF_model.showRebate=WFmodel.showRebate;
    WF_model.maxAwardAmount=WFmodel.maxAwardAmount;
    WF_model.minAwardAmount=WFmodel.minAwardAmount;
    WF_model.profitChaseAwardAmount=WFmodel.profitChaseAwardAmount;
    

    
    Pmodel.WFModel = WF_model;
    /**奖励金额*/
    NSString * bonus=[NSString stringWithFormat:@"%f",WFmodel.bonus];
    
    /**注数*/
    NSString * stakeNumber=[NSString stringWithFormat:@"%d",WFmodel.stakeNumber];
    
    /**倍数*/
    NSString * multiple=[NSString stringWithFormat:@"%d",WFmodel.multiple];
    
    /**购买金额*/
    NSString * payMoney=[NSString stringWithFormat:@"%@",GetRealFloatNum(WFmodel.payMoney)];
    
    /**玩法名称*/
    NSString * WFName =[NSString stringWithFormat:@"%@_%@",WFmodel.typeName,WFmodel.name];
    
    /**拼接号码*/
    NSMutableArray * haoMaArry =[[NSMutableArray alloc]init];
    NSString * haoMa =@"";
    
    
    //单式
    if (WFmodel.danShiArray.count>0) {
        
        //ssl  前二/后二  组选单式
        if ([WFmodel.lotteryCategories isEqualToString:@"ssl"]&&([WFmodel.playOnlyNum integerValue]==19001||[WFmodel.playOnlyNum integerValue]==24001)) {
            
            for (NSString * string in WFmodel.danShiArray) {
                //12_34 -> 1,2_3,4
                NSArray * item= [MCMathUnits getArrWithStr:string];
                [haoMaArry addObject:[item componentsJoinedByString:@","]];
            }
            haoMa=[haoMaArry componentsJoinedByString:@" "];
            
        //ssc  前二/后二  直选单式
        }else if ([WFmodel.lotteryCategories isEqualToString:@"ssc"]&&([WFmodel.playOnlyNum integerValue]==66002||[WFmodel.playOnlyNum integerValue]==59001)) {
            
            for (NSString * string in WFmodel.danShiArray) {
                //12_34 -> 1|2_3|4
                NSArray * item= [MCMathUnits getArrWithStr:string];
                [haoMaArry addObject:[item componentsJoinedByString:@"|"]];
            }
            haoMa=[haoMaArry componentsJoinedByString:@" "];
            
        //11选5 PK10
        }else if ([WFmodel.lotteryCategories isEqualToString:@"esf"]||[WFmodel.lotteryCategories isEqualToString:@"pks"]) {
            
            for (NSString * string in WFmodel.danShiArray) {
                //01_02,03_04 -> 01|02_03|04
                  NSString * str =@"";
                if (([WFmodel.playOnlyNum intValue]== 15001||[WFmodel.playOnlyNum intValue]== 22002 ||[WFmodel.typeId intValue] == 7) && [WFmodel.lotteryCategories isEqualToString:@"esf"]) {
                    
                
                    str = [string stringByReplacingOccurrencesOfString:@" "withString:@","];
                }else{
                
                    str = [string stringByReplacingOccurrencesOfString:@" "withString:@"|"];
                }
                
                [haoMaArry addObject:str];
                
                if ([haoMa isEqualToString:@""]) {
                    haoMa=str;
                }else{
                    haoMa=[NSString stringWithFormat:@"%@ %@",haoMa,str];
                }
            }
            
            //含有选项卡的
        }else if ([WFmodel.isShowSelectedCard isEqualToString:@"1"]){
            for (NSString * string in WFmodel.danShiArray) {
                //12_34 -> 1,2_3,4#千百十个
                NSArray * item= [MCMathUnits getArrWithStr:string];
                [haoMaArry addObject:[item componentsJoinedByString:@","]];
            }
            haoMa=[haoMaArry componentsJoinedByString:@" "];
            NSString * strCard=[MCMathUnits getSelectCardWithArr:WFmodel.selectedCardArray];
            haoMa=[NSString stringWithFormat:@"%@#%@",haoMa,strCard];
            
        }else if ([WFmodel.name isEqualToString:@"混合组选"]){
            
            
            for (NSString * string in WFmodel.danShiArray) {
                //12_34 -> 12_34
                NSArray * item= [MCMathUnits getArrWithStr:string];
                [haoMaArry addObject:[item componentsJoinedByString:@","]];
            }
            haoMa=[haoMaArry componentsJoinedByString:@" "];
            
        }else if (  ([WFmodel.lotteryCategories isEqualToString:@"ssc"]&&([WFmodel.playOnlyNum integerValue]==20002||[WFmodel.playOnlyNum integerValue]==26001||[WFmodel.playOnlyNum integerValue]==37001||[WFmodel.playOnlyNum integerValue]==48001))   ||[WFmodel.lotteryCategories isEqualToString:@"ssl"] || [WFmodel.lotteryCategories isEqualToString:@"sd"]  ||[WFmodel.lotteryCategories isEqualToString:@"pls"] ||[WFmodel.lotteryCategories isEqualToString:@"plw"]){
            //时时彩   四星  三星
            for (NSString * string in WFmodel.danShiArray) {
                //0102 0304 -> 01|02_03|04
                NSString * newStr=@"";
                for(int i =0; i < [string length]; i++)
                {
                    
//                    NSLog(@"第%d个字符是:%@",i, [string substringWithRange:NSMakeRange(i,1)]);
                    if (i==0) {

                    }else{

                        newStr=[NSString stringWithFormat:@"%@|",newStr];

                    }
                    newStr=[NSString stringWithFormat:@"%@%@",newStr,[string substringWithRange:NSMakeRange(i,1)]];
                    
                }
                [haoMaArry addObject:newStr];
                
                if ([haoMa isEqualToString:@""]) {
                    haoMa=newStr;
                }else{
                    haoMa=[NSString stringWithFormat:@"%@ %@",haoMa,newStr];
                }
            }
            
            
        //其他
        }else{
            for (NSString * string in WFmodel.danShiArray) {
                //12_34 -> 12_34
                [haoMaArry addObject:string];
            }
            haoMa=[haoMaArry componentsJoinedByString:@" "];
        }
        
        //胆拖
    }else if([WFmodel.isDanTuo integerValue]==1){
        
        NSMutableArray * DMArr=[[NSMutableArray alloc]init],*TMArr=[[NSMutableArray alloc]init];
        for (MCBaseSelectedModel * Smodel in WFmodel.baseSelectedModel) {
            //胆码
            if (Smodel.index==0) {
                DMArr=Smodel.selectedArray;
                //托码
            }else if (Smodel.index==1){
                TMArr=Smodel.selectedArray;
            }
        }
        NSString *DMHaoMa=@"";
        NSString *TMHaoMa=@"";
        for (NSString * str in DMArr) {
            if ([DMHaoMa isEqualToString:@""]) {
                DMHaoMa=str;
            }else{
                DMHaoMa=[NSString stringWithFormat:@"%@,%@",DMHaoMa,str];
            }
        }
        [haoMaArry addObject:DMHaoMa];
        for (NSString * str in TMArr) {
            if ([TMHaoMa isEqualToString:@""]) {
                TMHaoMa=str;
            }else{
                TMHaoMa=[NSString stringWithFormat:@"%@,%@",TMHaoMa,str];
            }
        }
        [haoMaArry addObject:TMHaoMa];
        
        haoMa=[NSString stringWithFormat:@"%@#%@",DMHaoMa,TMHaoMa];
        
        //定位胆
    }else if ([WFmodel.isDingWeiDan integerValue]==1){
        
        for (int i=0 ;i<[WFmodel.lineCount intValue];i++) {
            NSString * wei=@"*";
            for (MCBaseSelectedModel *Smodel in WFmodel.baseSelectedModel) {
                if (Smodel.index==i) {
                    wei = [Delete0Marr(Smodel.selectedArray ,WFmodel) componentsJoinedByString:@","];
                }
            }
            [haoMaArry addObject:wei];
        }
        haoMa=[haoMaArry componentsJoinedByString:@"|"];
        
    //其他
    }else{
        for (int i=0 ;i<[WFmodel.lineCount intValue];i++) {
            
            for (MCBaseSelectedModel *Smodel in WFmodel.baseSelectedModel) {
                if (Smodel.index==i) {
                    NSString * wei= [Delete0Marr(Smodel.selectedArray,WFmodel) componentsJoinedByString:@","];

                    
                    [haoMaArry addObject:wei];
                }
            }
            
        }
        haoMa=[haoMaArry componentsJoinedByString:@"|"];
        //有选项卡
        if ([WFmodel.isShowSelectedCard isEqualToString:@"1"]) {
            NSString * strCard=[MCMathUnits getSelectCardWithArr:WFmodel.selectedCardArray];
            haoMa=[NSString stringWithFormat:@"%@#%@",haoMa,strCard];
        }
        
    }
    //快三  三同号_通选  三连号_通选
    if (( [WFmodel.lotteryCategories isEqualToString:@"k3"]&&([WFmodel.playOnlyNum integerValue]== 13001||[WFmodel.playOnlyNum integerValue]== 16001)  ) ||  ([WFmodel.lotteryCategories isEqualToString:@"kl8"]&&[WFmodel.typeId intValue]==0) ) {
        
        NSArray * arr=[haoMa componentsSeparatedByString:@","];
        haoMa=[[MCMathUnits arraySortASC:arr] componentsJoinedByString:@","];
        
    }
    Pmodel.haoMa=haoMa;
    Pmodel.haoMaArry=haoMaArry;
    Pmodel.WFName=WFName;
    Pmodel.bonus=bonus;
    Pmodel.stakeNumber=stakeNumber;
    Pmodel.multiple=multiple;
    Pmodel.payMoney=payMoney;
    Pmodel.tz_haoMa=[MCMathUnits tzContentToNum:WFmodel andContent:haoMa];
    
    Pmodel.BetMode=WFmodel.BetMode;
    Pmodel.PlayCode=[NSString stringWithFormat:@"%@%@",WFmodel.LotteryID,WFmodel.methodId];
    Pmodel.BetRebate=WFmodel.userSelectedRebate;
    Pmodel.IssueNumber=[NSString stringWithFormat:@"%@",WFmodel.IssueNumber];
    Pmodel.showRebate=WFmodel.showRebate;
    Pmodel.isMachineSelectEnabled=WFmodel.isMachineSelectEnabled;
    if (WFmodel.yuanJiaoFen>0.99) {
        Pmodel.yuanJiaoFen=@"元模式";
    }else if (WFmodel.yuanJiaoFen>0.099){
        Pmodel.yuanJiaoFen=@"角模式";
    }else if (WFmodel.yuanJiaoFen>0.0099){
        Pmodel.yuanJiaoFen=@"分模式";
    }else{
        Pmodel.yuanJiaoFen=@"厘模式";
    }
    
    
    if (WFmodel.maxAwardAmount&&WFmodel.minAwardAmount==nil&&WFmodel.profitChaseAwardAmount) {
        Pmodel.isCanProfitChase=YES;
    }else{
        Pmodel.isCanProfitChase=NO;
    }
    Pmodel.profitChaseAwardAmount=WFmodel.profitChaseAwardAmount;
    return Pmodel;
}

+(NSArray *)arraySortASC:(NSArray *)array{

    //对数组进行排序
    
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        NSLog(@"%@~%@",obj1,obj2); //3~4 2~1 3~1 3~2
        
        return [obj1 compare:obj2]; //升序
        
    }];
    
    NSLog(@"result=%@",result);
    
    return result;
}

/*
 * 将数组@[@"01",@"02"]  ->@[@"1",@"2"]
 */
+(NSMutableArray *)GetNumberWith:(NSArray *)arr andModel:(MCBasePWFModel *)model{
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    if ([model.lotteryCategories isEqualToString:@"esf"]||[model.lotteryCategories isEqualToString:@"pks"]||[model.lotteryCategories isEqualToString:@"kl8"]||[model.lotteryCategories isEqualToString:@"klsf"]) {
        marr= [NSMutableArray arrayWithArray:arr];
        return marr;
    }
    
    for (NSString * str in arr) {
        [marr addObject:[MCMathUnits getCwithStr:str]];
    }
    return marr;
}

/*
 * 去掉字符开头的0
 */
+(NSString * )getCwithStr:(NSString*)str{
    NSString *first = [str substringToIndex:1];//字符串开始
    if ([first isEqualToString:@"0"]&&str.length>1) {
        return [str substringFromIndex:str.length-1];
    }
    return str;
}
/*
 * 将字符串 转化成数组
 */
+(NSMutableArray *)getArrWithStr:(NSString *)str{
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    for (int i=0; i<str.length; i++) {
        [marr addObject:[str substringWithRange:NSMakeRange(i, 1)]];
    }
    return marr;
}
/*
 * 选项卡 去掉“位”
 */
+(NSString *)getSelectCardWithArr:(NSArray *)arr{
    
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    NSString * str=[arr componentsJoinedByString:@""];
    if([str rangeOfString:@"万"].location !=NSNotFound){
        [marr addObject:@"万"];
    }
    if([str rangeOfString:@"千"].location !=NSNotFound){
        [marr addObject:@"千"];
    }
    if([str rangeOfString:@"百"].location !=NSNotFound){
        [marr addObject:@"百"];
    }
    if([str rangeOfString:@"十"].location !=NSNotFound){
        [marr addObject:@"十"];
    }
    if([str rangeOfString:@"个"].location !=NSNotFound){
        [marr addObject:@"个"];
    }
    str=[str stringByReplacingOccurrencesOfString:@"位"withString:@""];
    str=[marr componentsJoinedByString:@""];
    return str;
}





//*******************************************
//投注页面：汉字转数字
//*******************************************
+(NSString *)tzContentToNum:(MCBasePWFModel *)WFmodel andContent:(NSString * )content{
    
    
    /*
     * 根据两个参数  彩种ID  玩法ID  进行转换
     */
    NSArray * chineseArr,*numArr;
    
    if ([WFmodel.lotteryCategories isEqualToString:@"ssc"]) {
        
        int methodId=[WFmodel.methodId intValue];
        
        switch (methodId) {
            case 82:
            case 11:
            case 79:
            case 80:
            case 81:
                chineseArr= @[@"大",@"小",@"单",@"双"];
                numArr=     @[@"0",@"1",@"2",@"3"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
                
            case 85:
            case 88:
            case 91:
                //特殊号
                chineseArr = @[@"豹子", @"顺子", @"对子", @"半顺", @"杂六"];
                numArr =     @[@"0", @"1", @"2", @"3", @"4"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 37:
            case 38:
            case 39:
            case 40:
            case 59:
            case 60:
            case 61:
            case 62:
            case 63:
            case 64:
            case 65:
            case 66:
            case 67:
            case 68:
            case 69:
                //万千百十个
                chineseArr  = @[@"万", @"千", @"百", @"十", @"个", @"#"];
                numArr      = @[@"0", @"1", @"2", @"3", @"4", @"$"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 94:
            case 95:
            case 96:
            case 97:
            case 98:
            case 99:
            case 100:
            case 101:
            case 102:
            case 103:
                //龙虎和
                chineseArr   = @[@"龙", @"虎", @"和"];
                numArr       = @[@"0", @"1", @"2"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            default:
                break;
        }
    }else if ([WFmodel.lotteryCategories isEqualToString:@"pks"]){
        int methodId=[WFmodel.methodId intValue];
        
        switch (methodId) {
            case 16:
            case 17:
            case 18:

                chineseArr = @[@"大", @"小"];
                numArr = @[@"0", @"1"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 19:
            case 20:
            case 21:
                chineseArr = @[@"单", @"双"];
                numArr = @[@"2", @"3"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 22:
            case 23:
            case 24:
                chineseArr = @[@"龙", @"虎"];
                numArr = @[@"0", @"1"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
                
            default:
                break;
        }
    }else if ([WFmodel.lotteryCategories isEqualToString:@"kl8"]){
        int methodId=[WFmodel.methodId intValue];

        switch (methodId) {
            case 11:
                chineseArr = @[@"单", @"双"];
                numArr = @[@"0", @"1"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 12:
                chineseArr = @[@"小", @"和", @"大"];
                numArr = @[@"1", @"2", @"0"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 13:
                chineseArr = @[@"奇", @"和", @"偶"];
                numArr = @[@"0", @"2", @"1"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 14:
                chineseArr = @[@"上", @"中", @"下"];
                numArr = @[@"0", @"2", @"1"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 15:
                chineseArr = @[@"大单", @"大双", @"小单",@"小双"];
                numArr = @[@"0", @"1", @"2",@"3"];

                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 16:
                chineseArr = @[@"金", @"木", @"水",@"火",@"土"];
                numArr = @[@"0", @"1", @"2",@"3",@"4"];

                return MCChineseToNum(chineseArr,numArr,content);
                break;
                
            default:
                break;
        }
        
    }else if ([WFmodel.lotteryCategories isEqualToString:@"k3"]){
        if([WFmodel.methodId intValue] == 18) {
            chineseArr= @[@"大",@"小",@"单",@"双"];
            numArr=     @[@"0",@"1",@"2",@"3"];
            return MCChineseToNum(chineseArr,numArr,content);
        }
    }else if ([WFmodel.lotteryCategories isEqualToString:@"klsf"]){
        int methodId=[WFmodel.methodId intValue];

        switch (methodId) {
            case 20:
            case 21:
                //大小单双
                chineseArr = @[@"尾大",@"尾小",@"和单",@"和双",@"大", @"小",@"和",@"单",@"双"];
                numArr = @[@"4",@"5",@"6",@"7",@"0", @"1",@"2",@"2",@"3"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 22:
                //四季方位
                chineseArr = @[@"春", @"夏",@"秋",@"冬",@"东",@"南",@"西",@"北"];
                numArr = @[@"0", @"1",@"2",@"3",@"4",@"5",@"6",@"7"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 23:
                //五行
                chineseArr = @[@"金", @"木",@"水",@"火",@"土"];
                numArr = @[@"0", @"1",@"2",@"3",@"4"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
            case 24:
            case 25:
                //龙虎
                
                
                chineseArr = @[@"1V2", @"1V3",@"1V4",@"1V5",@"1V6",@"1V7",@"1V8",@"2V3",@"2V4",@"2V5",@"2V6",@"2V7",@"2V8",@"3V4",@"3V5",@"3V6",@"3V7",@"3V8",@"4V5",@"4V6",@"4V7",@"4V8",@"5V6",@"5V7",@"5V8",@"6V7",@"6V8",@"7V8"];
                numArr = @[@"1|2",@"1|3",@"1|4",@"1|5",@"1|6",@"1|7",@"1|8",@"2|3",@"2|4",@"2|5",@"2|6",@"2|7",@"2|8",@"3|4",@"3|5",@"3|6",@"3|7",@"3|8",@"4|5",@"4|6",@"4|7",@"4|8",@"5|6",@"5|7",@"5|8",@"6|7",@"6|8",@"7|8"];
                return MCChineseToNum(chineseArr,numArr,content);
                break;
                
            default:
                break;
        }
    }
    NSLog(@"%@",content);
    return content;
}
//中文  转  数字
+(NSString *)tzChinese:(NSArray *)chineseArr ToNum:(NSArray*)numArr andContent:(NSString *)content{

    for (int i=0;i<chineseArr.count;i++) {
        content = [content stringByReplacingOccurrencesOfString:chineseArr[i] withString:numArr[i]];
    }
    return content;
}

//数字  转  中文
+(NSString *)tzNum:(NSArray *)numArr ToChinese:(NSArray*)chineseArr andContent:(NSString *)content{

    for (int i=0;i<chineseArr.count;i++) {
        content = [content stringByReplacingOccurrencesOfString:numArr[i] withString:chineseArr[i]];
    }
    return content;
}


+(NSString *)tzWQBSGContent:(NSString * )content{
    content = [content stringByReplacingOccurrencesOfString:@"$" withString:@"#"];
    NSArray *arr = [content componentsSeparatedByString:@"#"];
    if (arr.count<2) {
        return content;
    }else{
        NSArray * chineseArr  = @[@"万", @"千", @"百", @"十", @"个", @"#"];
        NSArray * numArr      = @[@"0", @"1", @"2", @"3", @"4", @"$"];
        
        NSString * str2=[MCMathUnits tzNum:numArr ToChinese:chineseArr andContent:arr[1]];
        
        return [NSString stringWithFormat:@"%@#%@",arr[0],str2];
    }

}

//*******************************************************
//个人中心：数字转汉字
//*******************************************************
+(NSString *)tzContentToChinese:(NSString *)lotteryCategories andMethodId:(NSString *)methodId andContent:(NSString * )content{
    
    NSArray * chineseArr,*numArr;
    
    if ([lotteryCategories isEqualToString:@"ssc"]) {
        switch ([methodId intValue]) {
            case 82:
            case 11:
            case 79:
            case 80:
            case 81:
                chineseArr= @[@"大",@"小",@"单",@"双"];
                numArr=     @[@"0",@"1",@"2",@"3"];
                return MCNumToChinese(chineseArr, numArr, content);
                break;
            case 85:
            case 88:
            case 91:
                chineseArr = @[@"豹子", @"顺子", @"对子", @"半顺", @"杂六"];
                numArr =     @[@"0", @"1", @"2", @"3", @"4"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 37:
            case 38:
            case 39:
            case 40:
            case 59:
            case 60:
            case 61:
            case 62:
            case 63:
            case 64:
            case 65:
            case 66:
            case 67:
            case 68:
            case 69:
                return  [MCMathUnits tzWQBSGContent:content];
                
                break;
            case 94:
            case 95:
            case 96:
            case 97:
            case 98:
            case 99:
            case 100:
            case 101:
            case 102:
            case 103:
            case 109:
            case 110:
            case 111:
            case 112:
            case 113:
            case 114:
            case 115:
            case 116:
            case 117:
            case 118:
                chineseArr = @[@"龙", @"虎", @"和"];
                numArr = @[@"0", @"1", @"2"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            default:
                break;
                
        }

        
    }else if ([lotteryCategories isEqualToString:@"pks"]){
        switch ([methodId intValue]) {
            case 16:
            case 17:
            case 18:
                numArr = @[@"0", @"1"];
                chineseArr = @[@"大",@"小"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 19:
            case 20:
            case 21:
                numArr = @[@"2", @"3"];
                chineseArr = @[@"单",@"双"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 22:
            case 23:
            case 24:
                numArr = @[@"0", @"1"];
                chineseArr = @[@"龙",@"虎"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            default:
                break;
        }
    
    }else if ([lotteryCategories isEqualToString:@"kl8"]){
        switch ([methodId intValue]) {
            case 11:
                numArr = @[@"0", @"1"];
                chineseArr = @[@"单",@"双"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 12:
                numArr = @[@"1", @"2", @"0"];
                chineseArr = @[@"小",@"和",@"大"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 13:
                numArr = @[@"0", @"2", @"1"];
                chineseArr = @[@"奇",@"和",@"偶"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 14:
                numArr = @[@"0", @"2", @"1"];
                chineseArr =@[@"上",@"中",@"下"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 15:
                numArr = @[@"0", @"1", @"2",@"3"];
                chineseArr = @[@"大单",@"大双",@"小单",@"小双"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 16:
                numArr = @[@"0", @"1", @"2",@"3",@"4"];
                chineseArr = @[@"金",@"木",@"水",@"火",@"土"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
                
            default:
                break;
        }
    }else if ([lotteryCategories isEqualToString:@"tb"]){
        switch ([methodId intValue]) {
            case 16:
            case 17:
                numArr = @[@"0", @"1", @"2", @"3"];
                chineseArr = @[@"大", @"小", @"单", @"双"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
                
            default:
                break;
        }
    }else if ([lotteryCategories isEqualToString:@"k3"]){
        if([methodId intValue]== 18) {
            numArr = @[@"0", @"1", @"2", @"3"];
            chineseArr = @[@"大", @"小", @"单", @"双"];
            return MCNumToChinese(chineseArr,numArr,content);
        }
    }else if ([lotteryCategories isEqualToString:@"klsf"]){
        
        switch ([methodId intValue]) {
            case 20:
            case 21:
                //大小单双
                chineseArr = @[@"大", @"小",@"和",@"单",@"双",@"尾大",@"尾小",@"和单",@"和双"];
                numArr = @[@"0", @"1",@"2",@"2",@"3",@"4",@"5",@"6",@"7"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 22:
                //四季方位
                chineseArr = @[@"春", @"夏",@"秋",@"冬",@"东",@"南",@"西",@"北"];
                numArr = @[@"0", @"1",@"2",@"3",@"4",@"5",@"6",@"7"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 23:
                //五行
                chineseArr = @[@"金", @"木",@"水",@"火",@"土"];
                numArr = @[@"0", @"1",@"2",@"3",@"4"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
            case 24:
            case 25:
                //龙虎
                
                
                chineseArr = @[@"1V2", @"1V3",@"1V4",@"1V5",@"1V6",@"1V7",@"1V8",@"2V3",@"2V4",@"2V5",@"2V6",@"2V7",@"2V8",@"3V4",@"3V5",@"3V6",@"3V7",@"3V8",@"4V5",@"4V6",@"4V7",@"4V8",@"5V6",@"5V7",@"5V8",@"6V7",@"6V8",@"7V8"];
                numArr = @[@"1|2",@"1|3",@"1|4",@"1|5",@"1|6",@"1|7",@"1|8",@"2|3",@"2|4",@"2|5",@"2|6",@"2|7",@"2|8",@"3|4",@"3|5",@"3|6",@"3|7",@"3|8",@"4|5",@"4|6",@"4|7",@"4|8",@"5|6",@"5|7",@"5|8",@"6|7",@"6|8",@"7|8"];
                return MCNumToChinese(chineseArr,numArr,content);
                break;
                
            default:
                break;
        }
    }

    

    return content;
}

#pragma mark-银行卡号码  每隔四位添加空格
+(NSString *)GetBankCardShowNum:(NSString *)num{
    
//    NSString *str = num;
//    NSMutableArray *mA = [NSMutableArray array];
//    int groupCount =  ceilf(num.length/4.0);
//    
//    for (NSInteger i = 1; i <= num.length+2; i++) {
//        if (i <= num.length) {
//            if (i<=(groupCount-1)*4) {
//                [mA addObject:@"*"];
//            }else{
//                [mA addObject:[str substringToIndex:1]];
//            }
//            
//            str = [str substringFromIndex:1];
//        }
//        if (i%5 == 0) {
//            [mA insertObject:@" " atIndex:i-1];
//        }
//    }
//    NSString *string = [mA componentsJoinedByString:@""];

    NSString * string=[NSString stringWithFormat:@"**** **** **** %@",[num substringToIndex:4]];
    return string;
}
#pragma mark-金钱   每隔三位加一个“,”
+(NSString *)GetMoneyShowNum:(NSString *)num{
    //取出无用0
    num = [MCMathUnits GetRealNumWithStr:num];

    NSArray *temp=[num componentsSeparatedByString:@"."];
    
    NSString * decimalsNum=@"",*integerNum=@"";
    integerNum=temp[0];
    if (temp.count>1) {
        decimalsNum=temp[1];
    }
    
    NSString *str = integerNum;
    NSString *string=@"";
    for (NSInteger i = integerNum.length-1; i >=0; i--) {
        if (i <= integerNum.length) {
            string=[NSString stringWithFormat:@"%@%@",[str substringWithRange:NSMakeRange(i, 1)],string];
            str = [str substringWithRange:NSMakeRange(0, i)];
        }
        NSInteger index=integerNum.length-i;
        if (index%3 == 0&&index!=0&&index!=integerNum.length) {
            string=[NSString stringWithFormat:@",%@",string];

        }
    }
    if (decimalsNum.length>0) {
        return [NSString stringWithFormat:@"%@.%@",string,decimalsNum];
    }
    return string;
}

#pragma mark-获取真实的小数点位  1.080000-》1.08  1.000-》1
+(NSString*)removeFloatAllZero:(double)num
{
    NSString * testNumber = [NSString stringWithFormat:@"%.5f",num];

    
    NSString * outNumber;
    if (num>1000000) {
        NSString * s = @"";
        int offset = (int)testNumber.length - 1;
        while (offset)
        {
            s = [testNumber substringWithRange:NSMakeRange(offset, 1)];
            if ([s isEqualToString:@"0"]){
                offset--;
            }else{
                if ([s isEqualToString:@"."]) {
                    offset--;
                    break;
                }
                break;
            }
        }
        outNumber = [testNumber substringToIndex:offset+1];
    }else{
        outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
    }

    outNumber=[MCMathUnits GetRealNumWithStr:outNumber];
    return outNumber;
}

+(NSString *)GetRealNumWithStr:(NSString *)Snum{
    
    
    NSArray * numArr=[Snum componentsSeparatedByString:@"."];
    if (numArr.count<2) {
        return Snum;
    }
    
    NSString * xiaoshu=numArr[1];
    int index=0;
    for (int i=0; i<xiaoshu.length; i++) {
        NSString * c=[xiaoshu substringWithRange:NSMakeRange((xiaoshu.length-1-i),1)];
        if (![c isEqualToString:@"0"]) {
            
            index=(int)xiaoshu.length-i;
            xiaoshu=[xiaoshu substringWithRange:NSMakeRange(0,index)];
            if (xiaoshu.length>4) {
                xiaoshu=[xiaoshu substringToIndex:4];
            }
            return [NSString stringWithFormat:@"%@.%@",numArr[0],xiaoshu];

        }
        if (i==(xiaoshu.length-1)) {
            return numArr[0];
        }
    }
    
    return Snum;

}


+(MCMoneyModel *)GetBounsWithAwardAmount:(NSString *)AwardAmount andUserSelectedRebate:(NSString*)userSelectedRebate andYuanJiaoFen:(float)yuanJiaoFen andMultiple:(int)multiple andPayMoney:(double)payMoney{
    
    
    MCMoneyModel * model=[[MCMoneyModel alloc]init];
    
    /*
     * 奖级奖金 = 基础奖金 * 返点 * 2
     */
    double  gradeBouns = [AwardAmount doubleValue]*[userSelectedRebate intValue] * 2.0 /2000.0 + 0.000001;
    //只保留两位小数
    gradeBouns=(double)[MCMathUnits GetNum:gradeBouns andWei:2];
    
    double bouns= gradeBouns *multiple*yuanJiaoFen;
    
    NSString * Sbouns=[MCMathUnits removeFloatAllZero:bouns];
    model.bouns=Sbouns;
//    model.yinli=[MCMathUnits removeFloatAllZero:(bouns-payMoney)];
     model.yinli=[MCMathUnits removeFloatAllZero:([Sbouns doubleValue]-payMoney)];
    return model;

}


#pragma mark-专门截取小数 1.9999，2-》1.99
+(double)GetNum:(double)num andWei:(int)wei{
    
    NSString * Snum = [NSString stringWithFormat:@"%.5f",num];
    NSArray * numArr=[Snum componentsSeparatedByString:@"."];
    if (numArr.count<2) {
        return num;
    }
    NSString * xiaoshu=numArr[1];
    if (xiaoshu.length<=wei) {
        return num;
    }
    xiaoshu=[xiaoshu substringToIndex:wei];
    return [[NSString stringWithFormat:@"%@.%@",numArr[0],xiaoshu] doubleValue];
}


+(BOOL)isNeedCut:(NSString *)ID{
    NSArray * arr=@[@"86",@"73",@"74",@"9",@"79",@"80",@"10",@"19",@"17",@"18"];
    if ([arr containsObject:ID]) {
        return NO;
    }
    return YES;
//    以下是不需要去掉的：
//    北京时时彩【86】
//    台湾五分彩【73】
//    新加坡2分彩【74】
//    
//    北京快乐8【9】
//    韩国快乐8【79】
//    台湾快乐8【80】
//    北京PK拾【10】
//    
//    福彩3D【19】
//    排列3【17】
//    排列5【18】
}


+(NSInteger)getBallCountWithCZType:(NSString *)str{
    NSInteger count = 0;
    
    if ([str isEqualToString:@"ssc"]) {
        
        count=5;
        
    } else if ([str isEqualToString:@"esf"]){
        
        count=5;
        
    }else if ([str isEqualToString:@"sd"]){
        
        count=3;
        
    }else if ([str isEqualToString:@"pls"]){
        
        count=3;
        
    }else if ([str isEqualToString:@"plw"]){
        
        count=5;
        
    }else if ([str isEqualToString:@"ssl"]){
        
        count=3;
        
    }else if ([str isEqualToString:@"kl8"]){
        
        count=20;
        
    }else if ([str isEqualToString:@"pks"]){
        
        count=10;
        
    }else if ([str isEqualToString:@"k3"]){
        
        count=3;
        
    }else if ([str isEqualToString:@"tb"]){
        
        count=5;
        
    }else if([str isEqualToString:@"klsf"]){
        
        count=8;
    }
    
    return count;
}



@end








