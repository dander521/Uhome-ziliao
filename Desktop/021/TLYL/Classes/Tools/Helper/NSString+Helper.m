//
//  NSString+Helper.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "NSString+Helper.h"
#import <CommonCrypto/CommonDigest.h>

#define EFS_DANXUAN_ARRAY [NSMutableArray arrayWithObjects:@"11001", @"15001",@"18001",@"22002",@"29001",@"30001",@"31001",@"32001",@"33001",@"34001",@"35001",@"36001", nil]

#define SSC_CountDictionary @{@"11001":@"5",@"20002":@"4",@"26001":@"3",@"33001":@"3",@"37001":@"3",@"44001":@"3",@"48001":@"3",@"55001":@"3",@"59001":@"2",@"66002":@"2",@"89002":@"2",@"92002":@"2",@"95001":@"3",@"98001":@"3",@"101002":@"3",@"102001":@"3",@"105002":@"4"}

#define Sd_CountDictionary @{@"11001":@"3",@"16001":@"3",@"22001":@"2",@"30001":@"2"}

#define SSl_CountDictionary @{@"11001":@"3",@"16001":@"2",@"21001":@"2",@"19001":@"2",@"24001":@"2"}

#define Pls_CountDictionary @{@"11001":@"3",@"21001":@"2",@"29001":@"2"}

#define Plw_CountDictionary @{@"11001":@"5"}

@implementation MCArryModel

@end

@implementation NSString (Helper)

//
//        //esf 前三直选单式 11001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){2}$
//
//        //esf 前二直选单式18001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){1}$
//
//        //esf 前三组选单式15001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){2}$
//
//        //esf 前二组选单式22002
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){1}$
//
//        //esf 任选单式：一中一29001
//        ^((0[1-9])|1[01]){1}$
//
//        //esf 任选单式：二中二30001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){1}$
//
//        //esf 任选单式：三中三31001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){2}$
//
//        //esf 任选单式：四中四32001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){3}$
//
//        //esf 任选单式：五中五33001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){4}$
//
//        //esf 任选单式：六中五34001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){5}$
//
//        //esf 任选单式：七中五35001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){6}$
//
//        //esf 任选单式：八中五36001
//        ^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){7}$

- (BOOL)isValidateMobile
{
    // 130-139  150-153,155-159  180-189  145,147  170,171,173,176,177,178
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0-9])|(14[57])|(17[013678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isEmailAddress{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidateByRegex:emailRegex];
}

- (BOOL)isValidateByRegex:(NSString *)regex{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
    
}

#pragma mark-字符串分割成数组
+ (NSMutableArray *)splitStringByDiffrentSplitMarkInString:(NSString *)str andModel:(MCBasePWFModel *)model{
    NSMutableArray *stringArray=[[NSMutableArray alloc]init];
    NSLog(@"kkkkkkkkkkkkkkkk#pragma mark-字符串分割成数组");
    //11选5 PK10
    if ([model.lotteryCategories isEqualToString:@"esf"]||[model.lotteryCategories isEqualToString:@"pks"]) {
        
        NSString *tempStr = [str stringByReplacingOccurrencesOfString:@"；" withString:@","];
        NSString *newString = [tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@","];
        NSString *newString1 = [newString stringByReplacingOccurrencesOfString:@"，" withString:@","];
        stringArray = [NSMutableArray arrayWithArray:[newString1 componentsSeparatedByString:@","]];
        
    }else if([model.lotteryCategories isEqualToString:@"ssc"]||[model.lotteryCategories isEqualToString:@"ssl"]||[model.lotteryCategories isEqualToString:@"sd"]||[model.lotteryCategories isEqualToString:@"pls"]||[model.lotteryCategories isEqualToString:@"plw"]){
        //    时时彩，时时乐，3D彩，排列三，排列五
        //    单式格式说明替换第二点：2)每注之间可用空格、逗号、分号或回车分割;
        NSString *newString1 = [str stringByReplacingOccurrencesOfString:@"，" withString:@" "];
        NSString *tempStr = [newString1 stringByReplacingOccurrencesOfString:@"；" withString:@" "];
        NSString *newString = [tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        stringArray = [NSMutableArray arrayWithArray:[newString componentsSeparatedByString:@" "]];
        
    }else{
        //其余都是空格分割
        stringArray = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@" "]];
    }
    NSLog(@"SSSSSSSSSSSSSSSSSS#pragma mark-字符串分割成数组");
    return stringArray;
}


#pragma mark-所有玩法去错处理
- (MCArryModel *)MC_delWrongLottoryNumberWithWF:(MCBasePWFModel *)model andShow:(BOOL)isShow{
    MCArryModel*AModel=[[MCArryModel alloc]init];
    AModel.arr_Wrong=nil;
    AModel.arr_Repart=nil;
    AModel.arr_Result=nil;
    AModel.Do_Wrong=YES;
    NSMutableArray * marr_Wrony=[[NSMutableArray alloc]init];
    //字符串分割成数组
    NSArray *strArry = [NSString splitStringByDiffrentSplitMarkInString:self andModel:model];
    NSMutableArray * strMarry=[NSMutableArray arrayWithArray:strArry];
    AModel.arr_Result=strMarry;
    if (self == nil || [self isEqualToString:@""]) {
        AModel.arr_Result=nil;
        if (isShow) {
            [SVProgressHUD showErrorWithStatus:@"未发现错误号！"];
        }
        return AModel;
    }
    //11选5 PK10 《纯正则校验》
    if ([model.lotteryCategories isEqualToString:@"esf"]||[model.lotteryCategories isEqualToString:@"pks"]) {
        
        //如果格式不匹配  删除
        NSArray * geshiArr=[NSArray arrayWithArray:strMarry];
        NSString *regularExpressionStr = [self regularExpressionWithModel:model];
        
        for (NSString * temp in geshiArr) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpressionStr];
            BOOL isValid = [predicate evaluateWithObject:temp];
            if (!isValid) {
                [strMarry removeObject:temp];
                [marr_Wrony addObject:temp];
            }
            if ([model.lotteryCategories isEqualToString:@"esf"]) {
                //三不同 //二不同//任选单式  n不同
                if ([model.playOnlyNum integerValue]==11001||[model.playOnlyNum integerValue]==15001||[model.playOnlyNum integerValue]==18001||[model.playOnlyNum integerValue]==22002||[model.typeId integerValue]==7) {
                    
                    if ([self GetisSameStrInArr:[temp componentsSeparatedByString:@" "]]) {
                        [strMarry removeObject:temp];
                        [marr_Wrony addObject:temp];
                    }
                }
            }
            
            if ([model.lotteryCategories isEqualToString:@"pks"]) {
                if ([self GetisSameStrInArr:[temp componentsSeparatedByString:@" "]]) {
                    [strMarry removeObject:temp];
                    [marr_Wrony addObject:temp];
                }
            }
        }
        
        
        if ([strMarry isEqualToArray:strArry]&&isShow) {
            [SVProgressHUD showErrorWithStatus:@"未发现错误号！"];
        }
        AModel.arr_Wrong=marr_Wrony;
        AModel.arr_Result=strMarry;
        if (strMarry.count==1) {
            if ([strMarry[0] isEqualToString:@""]) {
                AModel.arr_Result=nil;
            }
        }
        return AModel;
        
    }else{
        return [self other_delWrongLottoryNumberWithWF:model andShow:isShow andArr:strArry];
    }
}
#pragma mark-剩余彩种去错误号码
-(MCArryModel *)other_delWrongLottoryNumberWithWF:(MCBasePWFModel *)model andShow:(BOOL)isShow andArr:(NSArray *)strArry{
    NSLog(@"kkkkkkkkkkkkkkkk");
    MCArryModel * Amodel=[[MCArryModel alloc]init];
    Amodel.arr_Wrong=nil;
    Amodel.arr_Repart=nil;
    Amodel.arr_Result=nil;
    Amodel.Do_Wrong=YES;
    NSMutableArray * marr_Wrong=[[NSMutableArray alloc]init];
    //字符串分割成数组
    NSMutableArray * strMarry=[NSMutableArray arrayWithArray:strArry];
    Amodel.arr_Result=strMarry;
    
    //如果格式不匹配  删除
    NSArray * geshiArr=[NSArray arrayWithArray:strMarry];
    NSString *regularExpressionStr = [self regularExpressionWithModel:model];
    for (NSString * temp in geshiArr) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularExpressionStr];
        BOOL isValid = [predicate evaluateWithObject:temp];
        if (!isValid) {
            [strMarry removeObject:temp];
            [marr_Wrong addObject:temp];
        }
        /**3 3不全同 122 123*/
        //        22001  sd  二星  直选单式
        
        if (([model.playOnlyNum integerValue]==22001&&![model.lotteryCategories isEqualToString:@"sd"])||[model.playOnlyNum integerValue]==33001||[model.playOnlyNum integerValue]==44001||[model.playOnlyNum integerValue]==55001||[model.playOnlyNum integerValue]==102001   || ([model.lotteryCategories isEqualToString:@"sd"]&&[model.playOnlyNum integerValue]==16001)) {
            NSString *first=@"",*second=@"",*third=@"";
            first = [temp substringWithRange: NSMakeRange(0, 1)];//字符1
            if (temp.length>1) {
                second = [temp substringWithRange:NSMakeRange(1, 1)];//字符2
            }
            if (temp.length>2) {
                third = [temp substringWithRange:NSMakeRange(2, 1)];//字符3
            }
            if ([first isEqualToString:second]&&[first isEqualToString:third]) {
                [strMarry removeObject:temp];
                [marr_Wrong addObject:temp];
            }
            
            /**2 2不同  12*/
        }else if ([model.playOnlyNum integerValue]==24001||[model.playOnlyNum integerValue]==19001||[model.playOnlyNum integerValue]==92002){
            NSString *first = [temp substringWithRange: NSMakeRange(0, 1)];//字符1
            NSString *second = [temp substringWithRange:NSMakeRange(1, 1)];//字符2
            if ([first isEqualToString:second]) {
                [strMarry removeObject:temp];
                [marr_Wrong addObject:temp];
            }
            /**3 全不同*/
        }else if ([model.playOnlyNum integerValue]==101002){
            NSString *first = [temp substringWithRange: NSMakeRange(0, 1)];//字符1
            NSString *second = [temp substringWithRange:NSMakeRange(1, 1)];//字符2
            NSString *third = [temp substringWithRange:NSMakeRange(2, 1)];//字符3
            if ([first isEqualToString:second]||[first isEqualToString:third]||[second isEqualToString:third]) {
                [strMarry removeObject:temp];
                [marr_Wrong addObject:temp];
            }
            /**2个相同1个不同*/
        }else if ([model.playOnlyNum integerValue]==98001){
            NSString *first = [temp substringWithRange: NSMakeRange(0, 1)];//字符1
            NSString *second = [temp substringWithRange:NSMakeRange(1, 1)];//字符2
            NSString *third = [temp substringWithRange:NSMakeRange(2, 1)];//字符3
            if (([first isEqualToString:second]&&[first isEqualToString:third]) || ( (![first isEqualToString:second]) && (![first isEqualToString:third])  && (![third isEqualToString:second]) ) ) {
                [strMarry removeObject:temp];
                [marr_Wrong addObject:temp];
            }
        }
    }
    Amodel.arr_Result=strMarry;
    if ((strMarry.count == strArry.count)&&isShow) {
        [SVProgressHUD showErrorWithStatus:@"未发现错误号！"];
    }
    if (strMarry.count==1) {
        if ([strMarry[0] isEqualToString:@""]) {
            Amodel.arr_Result=nil;
        }
    }
    Amodel.arr_Wrong=marr_Wrong;
    NSLog(@"ssssssssssssssssssss");
    return Amodel;
}



#pragma mark-所有去重复处理
- (MCArryModel *)MC_delRepartLottoryNumberInStringmodel:(MCBasePWFModel *)model{
    
    MCArryModel *AModel=[[MCArryModel alloc]init];
    AModel.arr_Wrong=nil;
    AModel.arr_Repart=nil;
    AModel.arr_Result=nil;
    AModel.Do_Repart=NO;
    //字符串分割成数组
    NSArray *strArray = [NSString splitStringByDiffrentSplitMarkInString:self andModel:model];
    AModel.arr_Result=strArray;
    if (self == nil || [self isEqualToString:@""]) {
        AModel.Do_Repart=YES;
        [SVProgressHUD showErrorWithStatus:@"未发现重复号！"];
        AModel.arr_Result=nil;
        return AModel;
    }
    MCArryModel*AAModel=[self MC_delWrongLottoryNumberWithWF:model andShow:NO];
    if (AAModel.arr_Wrong.count>0) {
        [SVProgressHUD showErrorWithStatus:@"请先去除错误号！"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MCSTAKEUNITS_HIDEN" object:nil];
        AModel.arr_Wrong=AAModel.arr_Wrong;
        return AModel;
    }
    NSLog(@"quchong--------------kkkkkkkkkkkkkkkkkkkkkkkk");
    NSMutableOrderedSet * chongFu_marr=[[NSMutableOrderedSet alloc]init];
    NSMutableOrderedSet *arrtemp = [[NSMutableOrderedSet alloc]init];
    
    for (NSString *str in strArray) {
        
        
        
        if (![arrtemp containsObject:str]) {
            
            //sd  混合组选
            if ([model.name containsString:@"组选"]) {
                int isSame=NO;
                for (NSString * tt in arrtemp) {
                    if ([self isSameStr:tt andStr:str]) {
                        isSame=YES;
                    }
                }
                if (isSame) {
                    [chongFu_marr addObject:str];
                }else{
                    [arrtemp addObject:str];
                }
            }else{
                [arrtemp addObject:str];
            }
            
        }else{
            [chongFu_marr addObject:str];
        }
        
        
    }
    AModel.arr_Result=arrtemp.array;
    NSLog(@"quchong--------------SSSSSSSSSSSSSSSSSSSSSSSSSS");
    if (strArray.count == arrtemp.count) {
        AModel.Do_Wrong=YES;
        AModel.Do_Repart=YES;
        [SVProgressHUD showErrorWithStatus:@"未发现重复号！"];
        return AModel;
    }
    AModel.arr_Repart=chongFu_marr.array;
    AModel.Do_Repart=YES;
    AModel.Do_Wrong=YES;
    return AModel;
    
}

-(BOOL)isSameStr:(NSString *)str1 andStr:(NSString *)str2{
    
    NSMutableArray * arr1=[[NSMutableArray alloc]init];
    NSMutableArray * arr2=[[NSMutableArray alloc]init];
    if (str1.length==str2.length) {
        for(int i =0; i < [str1 length]; i++)
        {
            NSString * temp1 = [str1 substringWithRange:NSMakeRange(i, 1)];
            [arr1 addObject:temp1];
        }
        arr1 = [NSMutableArray arrayWithArray:[MCMathUnits arraySortASC:arr1]];
        
        for(int i =0; i < [str2 length]; i++)
        {
            NSString * temp1 = [str2 substringWithRange:NSMakeRange(i, 1)];
            [arr2 addObject:temp1];
        }
        arr2 = [NSMutableArray arrayWithArray:[MCMathUnits arraySortASC:arr2]];
        
        NSString * t1=[arr1 componentsJoinedByString:@""];
        NSString * t2=[arr2 componentsJoinedByString:@""];
        if ([t1 isEqualToString:t2]) {
            return YES;
        }
        return NO;
    }else{
        return NO;
    }
}

#pragma mark-获取正则过滤表达式
- (NSString *)regularExpressionWithModel:(MCBasePWFModel *)model {
    
    NSString *regularExpressionStr = @"";
    //11选5
    if ([model.lotteryCategories isEqualToString:@"esf"]) {
        //前三直选单式 前三组选单式
        if ([model.playOnlyNum integerValue]==11001||[model.playOnlyNum integerValue]==15001) {
            
            regularExpressionStr=@"^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){2}$";
            
            //前二直选单式
        }else if ([model.playOnlyNum integerValue]==18001||[model.playOnlyNum integerValue]==22002){
            
            regularExpressionStr=@"^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){1}$";
            
            //任选单式：一中一
        }else if ([model.playOnlyNum integerValue]==37001){
            
            regularExpressionStr=@"^((0[1-9])|1[01]){1}$";
            
        }else if ([model.typeId integerValue]==7||[model.playOnlyNum integerValue]>37001){
            
            regularExpressionStr = [NSString stringWithFormat:@"^((0[1-9])|1[01])(\\s((0[1-9])|1[01])){%d}$",([model.playOnlyNum intValue]-37001)/1000];
            
        }
        
        //Pk10
    }else if([model.lotteryCategories isEqualToString:@"pks"]){
        if ([model.playOnlyNum integerValue]==12001) {//猜冠亚军单式
            
            regularExpressionStr =@"^((0[1-9])|10)(\\s((0[1-9])|10)){1}$";
            
        }else if([model.playOnlyNum integerValue]==14001){//猜前三名单式
            
            regularExpressionStr =@"^((0[1-9])|10)(\\s((0[1-9])|10)){2}$";
            
        }
        //剩余彩种
    } else{
        
        regularExpressionStr =[NSString stringWithFormat:@"^[0-9]{%d}$",[self GetWeiCountWithModel:model]];
        
    }
    
    return regularExpressionStr;
}
-(int)GetWeiCountWithModel:(MCBasePWFModel *)model{
    int WeiCount=0;
    //时时彩
    if ([model.lotteryCategories isEqualToString:@"ssc"]){
        WeiCount=[[SSC_CountDictionary objectForKey: model.playOnlyNum] intValue];
        //3D
    }else if([model.lotteryCategories isEqualToString:@"sd"]){
        WeiCount =[[Sd_CountDictionary objectForKey: model.playOnlyNum] intValue];
        //时时乐
    }else if ([model.lotteryCategories isEqualToString:@"ssl"]){
        WeiCount =[[SSl_CountDictionary objectForKey: model.playOnlyNum] intValue];
        //排列三
    }else if ([model.lotteryCategories isEqualToString:@"pls"]){
        WeiCount =[[Pls_CountDictionary objectForKey: model.playOnlyNum] intValue];
        //排列五
    }else if ([model.lotteryCategories isEqualToString:@"plw"]){
        WeiCount =[[Plw_CountDictionary objectForKey: model.playOnlyNum] intValue];
    }
    return WeiCount;
}

//干掉非法字符
- (NSString *)resultString{
    
    NSMutableString *strM = self.mutableCopy;
    NSMutableArray *array = [NSMutableArray array];
    NSString *character = nil;
    for (int i = 0; i < strM.length; i ++) {
        character = [strM substringWithRange:NSMakeRange(i, 1)];
        
        if ([character isEqualToString:@"["] || [character isEqualToString:@"`"] || [character isEqualToString:@"~"] || [character isEqualToString:@"!"] || [character isEqualToString:@"@"] || [character isEqualToString:@"#"] || [character isEqualToString:@"$"] || [character isEqualToString:@"^"] || [character isEqualToString:@"&"] || [character isEqualToString:@"*"] || [character isEqualToString:@"("] || [character isEqualToString:@")"] || [character isEqualToString:@"="] || [character isEqualToString:@"|"] || [character isEqualToString:@"{"] || [character isEqualToString:@"}"] || [character isEqualToString:@"'"] || [character isEqualToString:@":"] || [character isEqualToString:@""] || [character isEqualToString:@"'"] || [character isEqualToString:@""] || [character isEqualToString:@"["] || [character isEqualToString:@"]"] || [character isEqualToString:@"<"] || [character isEqualToString:@">"] || [character isEqualToString:@">"]  || [character isEqualToString:@"."] || [character isEqualToString:@"/"] || [character isEqualToString:@"?"] || [character isEqualToString:@"！"] || [character isEqualToString:@"￥"] || [character isEqualToString:@"……"] || [character isEqualToString:@"——"] || [character isEqualToString:@""] || [character isEqualToString:@"【"] || [character isEqualToString:@"】"] || [character isEqualToString:@"‘"] || [character isEqualToString:@""] || [character isEqualToString:@"："] || [character isEqualToString:@"“"] || [character isEqualToString:@"”"] || [character isEqualToString:@"。"] || [character isEqualToString:@""] || [character isEqualToString:@"、"] || [character isEqualToString:@"？"] || [character isEqualToString:@"%"] || [character isEqualToString:@"+"] || [character isEqualToString:@"_"] || [character isEqualToString:@"）"] || [character isEqualToString:@"（"] || [character isEqualToString:@"—"] || [character isEqualToString:@"…"] || [character isEqualToString:@"\\"] || [character isEqualToString:@"（）"]|| [character isEqualToString:@"（"]|| [character isEqualToString:@"）"]|| [character isEqualToString:@"¥"]|| [character isEqualToString:@"℃"]|| [character isEqualToString:@"-"]|| [character isEqualToString:@"-"]|| [character isEqualToString:@"•"]|| [character isEqualToString:@"～"]|| [character isEqualToString:@"－"]|| [character isEqualToString:@"＠"]|| [character isEqualToString:@"＃"]|| [character isEqualToString:@"＊"]|| [character isEqualToString:@"％"]|| [character isEqualToString:@"《"]|| [character isEqualToString:@"〈"]|| [character isEqualToString:@"『"]|| [character isEqualToString:@"』"]|| [character isEqualToString:@"〉"]|| [character isEqualToString:@"》"]|| [character isEqualToString:@"’"]|| [character isEqualToString:@"’"]|| [character isEqualToString:@"｛"]|| [character isEqualToString:@"｝"]|| [character isEqualToString:@"·"]) {
            
            continue;
        }else{
            
            [array addObject:character];
            
        }
    }
    
    
    
    return [array componentsJoinedByString:@""];
    
    
}
/*
 * 在数组里相同的元素个数
 */
-(BOOL)GetisSameStrInArr:(NSArray*)arr{
    
    NSMutableArray * newArry=[[NSMutableArray alloc]init];
    for (NSString * str in arr) {
        if (![newArry containsObject:str]) {
            [newArry addObject:str];
        }
    }
    if (newArry.count!=arr.count) {
        return YES;
    }
    
    return NO;
}
//判断内容是否全部为空格 yes 全部为空格 no 不是
+ (BOOL) isEmpty:(NSString *) str {
    
    if(!str) {
        
        return true;
        
    }else {
        
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if([trimedString length] == 0) {
            
            return true;
            
        }else {
            
            return false;
        }
    }
    
}

/*
 * 将输入框校验成标准的字符
 */
+(NSString *)GetFormatStr:(NSString*)str WithModel:(MCBasePWFModel *)model{
    NSMutableArray * marr=[[NSMutableArray alloc]init];
    
    NSArray * arr=[NSString splitStringByDiffrentSplitMarkInString:str andModel:model];
    
    for (NSString * item in arr) {
        NSString * sstr=[item stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (![NSString isEmpty:sstr]) {
            [marr addObject:sstr];
        }
    }
    
    if ([model.lotteryCategories isEqualToString:@"esf"]||[model.lotteryCategories isEqualToString:@"pks"]) {
        return [marr componentsJoinedByString:@","];
    }else{
        return [marr componentsJoinedByString:@" "];
    }
    
}


/*
 * 字符串   每隔3位加一个逗号
 */
+(NSString *)MCcountNumChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

/**
 *   获取字符宽度
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title font:(CGFloat )font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:font];
    [label sizeToFit];
    return label.frame.size.width;
}


- (NSString *)MD5
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
+(NSString*)getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a*1000];//转为字符型
    return timeString;
}

+ (BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

@end















