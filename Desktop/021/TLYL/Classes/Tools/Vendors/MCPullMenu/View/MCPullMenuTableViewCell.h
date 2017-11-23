//
//  MCPullMenuTableViewCell.h
//  TLYLSF
//
//  Created by Canny on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPullMenuCollectionViewCell.h"
#import "MCPullMenuModel.h"
#import "MCPullMenuHeader.h"

@protocol MCMenuCellDelegate <NSObject>
@required

- (void)cellDidSelectWithDic:(NSDictionary *)dic;

@end
@interface MCPullMenuTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) UICollectionView* collectionView;

@property (nonatomic, weak) id<MCMenuCellDelegate>delegate;

@property (nonatomic,strong) MCMenuDataModel * dataSource;
-(void)relayOutData:(MCMenuDataModel *)dataSource withType:(FinishOrEditType)type;

@end
