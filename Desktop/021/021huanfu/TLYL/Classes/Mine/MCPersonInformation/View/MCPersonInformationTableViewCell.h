//
//  MCPersonInformationTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GoToVC)(NSInteger type);
@interface MCPersonInformationTableViewCell : UITableViewCell


+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong) id dataSource;

@property (nonatomic,copy)GoToVC block;

@end
