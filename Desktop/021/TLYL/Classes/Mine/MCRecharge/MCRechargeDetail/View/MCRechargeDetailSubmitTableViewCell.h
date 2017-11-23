//
//  MCRechargeDetailSubmitTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/8/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^MCRechargeDetailSubmitBlock)();
@interface MCRechargeDetailSubmitTableViewCell : UITableViewCell
+(CGFloat)computeHeight:(id)info;
@property (nonatomic,strong) id dataSource;
/*
 * 姓名
 */
@property (nonatomic,strong)UITextField * userNameTextField;



/*
 * 金额
 */
@property (nonatomic,strong)UITextField * moneyTextField;

/*
 * 时间
 */

@property (nonatomic,strong)UITextField * timeTextField;

@property(nonatomic,copy)MCRechargeDetailSubmitBlock block;


@property (nonatomic,strong)UIButton * submitBtn;


@end
