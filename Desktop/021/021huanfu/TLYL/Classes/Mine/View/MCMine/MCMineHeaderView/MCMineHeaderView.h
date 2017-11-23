//
//  MCMineHeaderView.h
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMineInfoModel.h"
#define HEIGHTMINEHEADERVIEW  210

@protocol MCMineHeaderViewDelegate <NSObject>

@required
/*
 * 跳转界面
 */
-(void)goToViewControllerWithType:(NSString *)type;



@end

@interface MCMineHeaderView : UIView

@property (nonatomic,strong)UIImageView * settingImgV;

@property (nonatomic, weak) id<MCMineHeaderViewDelegate>delegate;

@property (nonatomic,strong) MCMineInfoModel * dataSource;

//可用余额
-(void)setAccountBalance:(NSString *)accountBalance;

//冻结金额
-(void)setFrozenAccount:(NSString *)frozenAccount;

+(CGFloat)computeHeight:(id)info;


@end
