//
//  MCSelectedBottomTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/7/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCSelectedBottomTableViewCell : UITableViewCell

@property (nonatomic,strong)id dataSource;
+(CGFloat)computeHeight:(id)info;

@end
