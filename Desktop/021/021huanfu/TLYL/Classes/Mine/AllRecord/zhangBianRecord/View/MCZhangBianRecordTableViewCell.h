//
//  MCZhangBianRecordTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserAccountRecordModel.h"

@interface MCZhangBianRecordTableViewCell : UITableViewCell

@property (nonatomic,strong)MCUserAccountRecordDetailDataModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong)UIView  * line;

@end
