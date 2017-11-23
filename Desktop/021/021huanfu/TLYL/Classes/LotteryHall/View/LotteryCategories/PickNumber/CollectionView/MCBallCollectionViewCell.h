//
//  MCBallCollectionViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBallCollectionModel.h"


@interface MCBallCollectionViewCell : UICollectionViewCell
/**号码球数据源*/
@property (nonatomic,strong) MCBallCollectionModel *dataSource;
/**号码球按钮*/
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
/**ssc号码球胆拖投注标记*/
@property (assign, nonatomic) BOOL ballItemSelected;
/**号码球按钮被电击回掉*/
@property (nonatomic,strong) void(^selectedBall)(MCBallCollectionModel *model);

/**号码球按钮被电击回掉1*/
@property (nonatomic,strong) void(^selectedBallK3TongXuan)(MCBallCollectionModel *model);

/** 组选包胆号码球按钮被电击回掉1*/
@property (nonatomic,strong) void(^selectedBallZuXuanBaoDan)(MCBallCollectionModel *model);

@end













