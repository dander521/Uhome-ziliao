//
//  MCMCZhuihaoRecordSubDetailUITableViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserChaseRecordDetailModel.h"
@interface MCMCZhuihaoRecordSubDetailUITableViewCell : UITableViewCell

@property (nonatomic,strong)MCUserChaseRecordDetailSubDataModel * dataSource;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier BallCount:(int)ballCount ;

@property (nonatomic,strong)NSString * LotteryCode;
@property (nonatomic,strong) NSString * BetRebate;
@end
