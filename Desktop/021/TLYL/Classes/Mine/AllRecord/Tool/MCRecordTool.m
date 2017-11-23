//
//  MCRecordTool.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRecordTool.h"
#import "MCMineInfoModel.h"

@implementation MCRecordTool
+(NSDate *)getDateWithStr:(NSString *)birthdayStr{
    //NSString *birthdayStr=@"1986-03-28 00:00:00";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSDate *birthdayDate = [dateFormatter dateFromString:birthdayStr];
    return birthdayDate;
}
+ (BOOL)bissextile:(int)year {
    
    if ((year%4==0 && year %100 !=0) || year%400==0) {
        return YES;
    }else {
        return NO;
    }
    return NO;
}

+(NSArray *)getSourceCodeArray{

    MCMineInfoModel *mineInfoModel =[MCMineInfoModel sharedMCMineInfoModel];
    if (mineInfoModel.IsDayWages&&mineInfoModel.IsDividend) {
        return
        @[@"全部",@"充值",@"提款",@"转账",@"投注",@"中奖",@"撤单",@"撤奖",@"活动",@"下级返点",@"自身投注返点",@"给下级充值",@"来自上级的充值",@"管理员添加",@"分红",@"日工资"];
        
    //只有分红
    }else if (mineInfoModel.IsDividend){
        return @[@"全部",@"充值",@"提款",@"转账",@"投注",@"中奖",@"撤单",@"撤奖",@"活动",@"下级返点",@"自身投注返点",@"给下级充值",@"来自上级的充值",@"管理员添加",@"分红"];
        
    //只有日工资
    }else if (mineInfoModel.IsDayWages){
        return @[@"全部",@"充值",@"提款",@"转账",@"投注",@"中奖",@"撤单",@"撤奖",@"活动",@"下级返点",@"自身投注返点",@"给下级充值",@"来自上级的充值",@"管理员添加",@"日工资"];
    }else{
        return @[@"全部",@"充值",@"提款",@"转账",@"投注",@"中奖",@"撤单",@"撤奖",@"活动",@"下级返点",@"自身投注返点",@"给下级充值",@"来自上级的充值",@"管理员添加"];
    }
    
    
    
}
+(NSDictionary *)getSourceCodeDic{
    return @{
             @"全部":@"0",
             @"充值":@"18",
             @"提款":@"26",
             @"转账":@"3",
             @"投注":@"1",
             @"中奖":@"2",
             @"撤单":@"4",
             @"撤奖":@"5",
             @"活动":@"6",
             @"下级返点":@"7",
             @"自身投注返点":@"8",
             @"给下级充值":@"9",
             @"来自上级的充值":@"10",
             @"管理员添加":@"11",
             @"分红":@"28",
             @"日工资":@"29"
             };
}

+(NSDictionary *)getCode_SourceDic{
    return @{
             @"0":@"全部",
             @"18":@"充值",
             @"26":@"提款",
             @"3":@"转账",
             @"1":@"投注",
             @"2":@"中奖",
             @"4":@"撤单",
             @"5":@"撤奖",
             @"6":@"活动",
             @"7":@"下级返点",
             @"8":@"自身投注返点",
             @"9":@"给下级充值",
             @"10":@"来自上级的充值",
             @"11":@"管理员添加",
             @"28":@"分红",
             @"29":@"日工资"
             
             };
}


+(MCUserARecordModel *)getAccountType:(MCUserAccountRecordDetailDataModel *)dataSource{
    
    MCUserARecordModel *Cmodel=[[MCUserARecordModel alloc]init];
    Cmodel.color=RGB(255,168,0);
    Cmodel.imgVName=@"";
    Cmodel.name= @"";
    
    NSString *DetailsSource=dataSource.DetailsSource;
    NSString *sRechargeType =dataSource.RechargeType;
    NSInteger RechargeType=[sRechargeType integerValue];
    
    MCGroupPaymentModel * groupPaymentModel =[MCGroupPaymentModel sharedMCGroupPaymentModel];

    NSString * temp=@"";
    switch([DetailsSource integerValue]) {
        case 1:
            Cmodel.name= @"投注";
            Cmodel.color=RGB(255,168,0);
            Cmodel.imgVName=@"投";
            
            break;
        case 10:
        case 11:
        case 12:
        case 13:
            Cmodel.name= @"撤单";
            Cmodel.color=RGB(79,125,229);
            Cmodel.imgVName=@"撤";
            break;
        case 17:
        case 153:
            Cmodel.name= @"活动加款";
            Cmodel.color=RGB(145,83,249);
            Cmodel.imgVName=@"惠";
            break;
        case 20 :
            Cmodel.name= @"出票";
            Cmodel.color=RGB(255,168,0);
            Cmodel.imgVName=@"投";
            break;
        case 30:
            Cmodel.name= @"自身投注返点";
            Cmodel.color=RGB(59,193,160);
            Cmodel.imgVName=@"返";
            break;
        case 40:
            Cmodel.name =@"下级返点";
            Cmodel.color=RGB(59,193,160);
            Cmodel.imgVName=@"返";
            break;
        case 50:
            Cmodel.name= @"中奖";
            Cmodel.color=RGB(249,84,83);
            Cmodel.imgVName=@"奖";
            break;
        case 60:
            Cmodel.name= @"撤奖";
            Cmodel.color=RGB(79,125,229);
            Cmodel.imgVName=@"撤";
            break;
        case 70:
        case 90:
            Cmodel.name= @"提款";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 80:
            Cmodel.name= @"申请提款失败";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 100:
            Cmodel.name= @"提款审批同意--后台人工出款";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 110:
            Cmodel.name= @"提款审批同意--自动出款";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 120:
            Cmodel.name= @"人工出款";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 121:
            Cmodel.name= @"提款成功--刷新";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 122:
            Cmodel.name= @"人工提款";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 130:
            Cmodel.name= @"提款失败";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 131:
            Cmodel.name= @"提款失败--刷新1";
            Cmodel.color=RGB(30,212,17);
            Cmodel.imgVName=@"提";
            break;
        case 140:
            Cmodel.name= @"申请充值";
            Cmodel.color=RGB(11,167,236);
            Cmodel.imgVName=@"充";
            break;
        case 150:
            if(RechargeType==0){
                temp=@"网银充值";
            }else if(RechargeType==1){
                temp=@"在线转账";
            }else if(RechargeType==2){
                temp=@"其他";
            }else if(RechargeType==3){
                temp=@"人工存款";
            }else if(RechargeType==4){
                temp=@"活动";
            }else {
                //                (RechargeType==【此商户添加的银行】)
                for (MCPaymentModel * model in groupPaymentModel.payMentArr) {
                    if ([model.RechargeType isEqualToString:sRechargeType]) {
                        //                        temp = 【对应的银行名称】
                        temp=model.PayName;
                    }
                }
            }
            Cmodel.name= temp;
            Cmodel.color=RGB(11,167,236);
            Cmodel.imgVName=@"充";
            break;
        case 151:
            Cmodel.name= @"其他加款";
            Cmodel.color=RGB(176,193,59);
            Cmodel.imgVName=@"管";
            break;
        case 152:
            Cmodel.name= @"人工存款";
            Cmodel.color=RGB(11,167,236);
            Cmodel.imgVName=@"充";
            break;
        case 160:
            Cmodel.name= @"充值失败";
            Cmodel.color=RGB(11,167,236);
            Cmodel.imgVName=@"充";
            break;
        case 170:
        case 180:
            Cmodel.name= @"转账";
            Cmodel.color=RGB(249,83,208);
            Cmodel.imgVName=@"转";
            break;
        case 190:
            Cmodel.name= @"给下级充值";
            Cmodel.color=RGB(176,193,59);
            Cmodel.imgVName=@"管";
            break;
        case 200:
            Cmodel.name= @"来自上级的充值";
            Cmodel.color=RGB(176,193,59);
            Cmodel.imgVName=@"管";
            break;
        case 210:
            Cmodel.name= @"分红";//fffff
            Cmodel.color=RGB(84,167,219);
            Cmodel.imgVName=@"分";
            break;
        case 220:
        case 230:
        case 231:
        case 240:
        case 241:
        case 251:
        case 252:
        case 253:
        case 254:
        case 255:
        case 256:
        case 257:
            Cmodel.name= @"系统活动";
            Cmodel.color=RGB(145,83,249);
            Cmodel.imgVName=@"惠";
            break;
        case 261:
            Cmodel.name= @"按比例发放日工资";//z
            Cmodel.color=RGB(178,52,159);
            Cmodel.imgVName=@"资";
            
            break;
        case 262:
            Cmodel.name= @"按阶梯发放日工资";//z
            Cmodel.color=RGB(178,52,159);
            Cmodel.imgVName=@"资";
            break;
        case 263:
            Cmodel.name= @"来自上级的日工资";//z
            Cmodel.color=RGB(178,52,159);
            Cmodel.imgVName=@"资";
            break;
        case 264:
            Cmodel.name= @"发给下级的日工资";//z
            Cmodel.color=RGB(178,52,159);
            Cmodel.imgVName=@"资";
            break;
        case 265:
            Cmodel.name= @"人工添加日工资";//z
            Cmodel.color=RGB(178,52,159);
            Cmodel.imgVName=@"资";
            break;
        case 266:
            Cmodel.name= @"人工扣除日工资";//z
            Cmodel.color=RGB(178,52,159);
            Cmodel.imgVName=@"资";
            break;
        case 267:
        case 268:
        case 269:
            Cmodel.name= @"分红";
            Cmodel.color=RGB(84,167,219);
            Cmodel.imgVName=@"分";
            break;
        case 290:
            Cmodel.name= @"转账";
            Cmodel.color=RGB(249,83,208);
            Cmodel.imgVName=@"转";
            break;
        case 300:
            Cmodel.name= @"转账";
            Cmodel.color=RGB(249,83,208);
            Cmodel.imgVName=@"转";
            break;
        case 301:
        case 302:
            Cmodel.name= @"日工资";//z
            Cmodel.color=RGB(178,52,159);
            Cmodel.imgVName=@"资";
            break;
        case 303:
            Cmodel.name= @"其他扣款";//g
            Cmodel.color=RGB(176,193,59);
            Cmodel.imgVName=@"管";
            break;
        case 304:
            Cmodel.name= @"活动扣款";//g
            Cmodel.color=RGB(176,193,59);
            Cmodel.imgVName=@"管";
            break;
        case 310:
            Cmodel.name= @"转账";
            Cmodel.color=RGB(249,83,208);
            Cmodel.imgVName=@"转";
            break;
        default:
            break;
    }
    return Cmodel;
}

#pragma mark-设置你需要增加或减少的年、月、日即可获得新的日期，上述的表示获取mydate日期前一个月的日期，如果该成+1，则是一个月以后的日期，以此类推都可以计算。
+ (NSDate *)getLaterDateFromDate:(NSDate *)date withYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    
    return newdate;
}


+ (NSArray *)GetMonthFirstAndLastDay{
    
//    NSDateFormatter *format=[[NSDateFormatter alloc] init];
//    [format setDateFormat:@"yyyy/MM/dd"];
    NSDate *newDate=[NSDate date];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY/MM/dd"];
    NSString *firstString = [myDateFormatter stringFromDate: firstDate];
    NSString *lastString = [myDateFormatter stringFromDate: lastDate];
    return @[firstString, lastString];
}


@end















