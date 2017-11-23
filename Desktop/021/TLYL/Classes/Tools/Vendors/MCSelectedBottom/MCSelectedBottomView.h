//
//  MCSelectedBottomView.h
//  TLYL
//
//  Created by MC on 2017/7/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HEIGHT_MCSBVIEW  230
#import "MCBankModel.h"

typedef NS_ENUM(NSInteger, Type_Bottom) {
    ProvinceType=1,
    CityType,
    BankType,
    FastPayType,
};

@protocol MCSelectedBottomDelegate <NSObject>
@optional
/*
 * 选择省份
 */
-(void)MCSelectedBottom_Province:(MCBankModel *)model;

/*
 * 选择市区
 */
-(void)MCSelectedBottom_City:(MCBankModel *)model;

/*
 * 选择银行
 */
-(void)MCSelectedBottom_Bank:(MCBankModel *)model;



@end





@interface MCSelectedBottomView : UIView

@property (nonatomic,strong)NSMutableArray * dataSource;

@property (nonatomic, weak) id<MCSelectedBottomDelegate>delegate;

-(void)reloadDataWithType:(Type_Bottom)type andModel:(MCBankModel *)model;
-(void)reloadDataWithType:(Type_Bottom)type andDataSource:(NSArray *)arr_FastPayment;


@end
