//
//  MCPullMenuSelectedCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPullMenuHeader.h"

@interface MCPullMenuSelectedCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) NSDictionary * dataSource;

-(void)relayOutData:(NSDictionary *)dataSource withType:(FinishOrEditType)type;
-(void)setCellSelected:(BOOL)selected;
@end
