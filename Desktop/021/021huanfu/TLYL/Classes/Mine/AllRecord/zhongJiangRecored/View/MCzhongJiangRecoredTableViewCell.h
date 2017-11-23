//
//  MCzhongJiangRecoredTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserWinRecordModel.h"

@interface MCzhongJiangRecoredTableViewCell : UITableViewCell

@property (nonatomic,strong)MCUserWinRecordDetailDataModel * dataSource;

+(CGFloat)computeHeight:(id)info;

@end
