//
//  MCLotteryRecordCollectionViewCell.h
//  TLYL
//
//  Created by Canny on 2017/9/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCLotteryRecordCollectionViewCell : UICollectionViewCell

//type 1:紫色底  白字  2：带边框的 紫色字 3.pks专用
-(void)relayOutCellWithDataSource:(id)dataSource andType:(NSInteger )type andIndex:(NSInteger )index;

@end
