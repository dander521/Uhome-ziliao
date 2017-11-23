//
//  MCPullMenuViewController.h
//  TLYLSF
//
//  Created by MC on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPullMenuTableViewCell.h"
#import "MCUserDefinedLotteryCategoriesModel.h"

@interface WFModel :NSObject
@property (nonatomic ,assign)BOOL isCanAdd;
@property (nonatomic ,strong)NSMutableArray <MCPullMenuCollectionCellModel *>* dataSource;

@end

@protocol MCPullMenuDelegate <NSObject>

@required

-(void)selectLotteryKindWithTag:(MCBasePWFModel*)baseWFmodel;

@end

@interface MCPullMenuViewController : UIViewController

@property (nonatomic, weak) id<MCPullMenuDelegate>delegate;

@property (nonatomic,strong)MCUserDefinedLotteryCategoriesModel *lotteriesTypeModel;

/*
 * 第一次获取默认选项
 */
+(MCBasePWFModel*)Get_DefaultDicWithID:(NSString *)LotteryCode and:(NSString * )PlayCode;
@end
