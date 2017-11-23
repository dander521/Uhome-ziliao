//
//  MCBankcardManageTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBankModel.h"
@interface MCBankcardManageTableViewCell : UITableViewCell

@property (nonatomic,strong)MCBankModel* dataSource;

+(CGFloat)computeHeight:(id)info;

-(void)setBackViewWithSingal:(BOOL)isSingal;

@end
