//
//  MCZhuiHaoModel.h
//  TLYL
//
//  Created by miaocai on 2017/7/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCZhuiHaoModel : NSObject
/*
 *
 *property
 *
 */

/**params LotteryCode 菜种*/
@property(nonatomic,assign) int LotteryCode;
/**params Num 追其数*/
@property(nonatomic,assign) int Num;



@property(nonatomic,assign) BOOL selected;

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *beishu;
/**IssueNumber 返回的期号*/

@property (nonatomic,strong) NSString *IssueNumber;

@property (nonatomic,assign) CGFloat typeValue;

//元角分厘
@property (nonatomic,strong) NSString * yuanJiaoFen;

/*
 *
 *method
 *
 */

- (void)refreashDataAndShow;

@property(nonatomic,strong) void(^callBackSuccessBlock)(id manager);

@property(nonatomic,strong) void(^callBackFailedBlock)(id manager,NSString *errorCode);

@end
