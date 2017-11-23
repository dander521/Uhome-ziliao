//
//  MCBonusRecordXiaJiTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetDividentsListModel.h"

@interface MCBonusRecordXiaJiTableViewCell : UITableViewCell

@property (nonatomic,strong)MCGetDividentsListDeatailDataModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@end


