//
//  MCPullMenuCollectionViewCell.h
//  TLYLSF
//
//  Created by Canny on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPullMenuModel.h"
#import "MCPullMenuHeader.h"

@interface MCPullMenuCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) MCPullMenuCollectionCellModel * dataSource;

-(void)relayOutData:(MCPullMenuCollectionCellModel *)dataSource withType:(FinishOrEditType)type;

@end
