//
//  MCMineTableviewCell.h
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMineCellModel.h"
@protocol MCMineCellDelegate <NSObject>
@required

- (void)cellDidSelectWithType:(NSString *)type;

@end
@interface MCMineTableviewCell : UITableViewCell

+(CGFloat)computeHeight:(id)info;


@property (nonatomic, weak) id<MCMineCellDelegate>delegate;


@property (nonatomic,strong) id dataSource;

-(void)refreashCellListUI;
@end
