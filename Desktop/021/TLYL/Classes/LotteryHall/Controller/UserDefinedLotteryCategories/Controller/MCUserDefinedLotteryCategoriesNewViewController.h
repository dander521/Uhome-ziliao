//
//  MCUserDefinedLotteryCategoriesNewViewController.h
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  MCUserDefinedLotteryCategoriesModel;

typedef void(^Compeletion)(BOOL result, NSMutableArray *defaultCZArray );

typedef void(^BackUserDefinedLotteryCategoriesBlock)(NSMutableArray <MCUserDefinedLotteryCategoriesModel *> * marr);

@interface MCUserDefinedLotteryCategoriesNewViewController : UIViewController

@property (nonatomic,copy)BackUserDefinedLotteryCategoriesBlock block;

//获取用户自定义彩种
-(void)GetLotteryCustomArray:(Compeletion)compeletion;
//获取当前开售的所有彩种
-(void)loadCanSaleCZArry:(Compeletion)compeletion;

//退出登录 清空自定义彩种
+(void)clearUserDefinedCZ;
/*
 * 数据
 */
-(NSMutableArray *)GetCZListMarrWithDic:(NSArray *)arr;

@end
