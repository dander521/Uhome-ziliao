//
//  MCPaySelectedLotteryTableViewController.h
//  TLYL
//
//  Created by miaocai on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCPaySelectedLotteryTableViewController : UIViewController

-(void)emptyShoppingCart;
@property (nonatomic,assign)int RemainTime;
@property (nonatomic,strong)NSString * IssueNumber;
@property (nonatomic,strong) NSArray *boModelArray;
@property (nonatomic,strong) MCBasePWFModel *baseWFmodel;

@property (nonatomic,strong) NSMutableArray <MCShowBetModel*>*betRebateArray;

@end
