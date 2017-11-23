//
//  MCZhuihaoRecordTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserChaseRecordModel.h"

@interface MCZhuihaoRecordTableViewCell : UITableViewCell

@property (nonatomic,strong)MCUserChaseRecordDataModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@end
