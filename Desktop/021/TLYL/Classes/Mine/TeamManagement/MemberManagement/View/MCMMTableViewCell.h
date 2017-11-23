//
//  MCMMTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCMMlistModel.h"

@interface MCMMTableViewCell : UITableViewCell
@property (nonatomic,strong)void(^btnClickBlock)(NSInteger index);
@property (nonatomic,strong) MCMMlistModel *dataSource;
@property (nonatomic,strong) UIButton *fandianBtn;
@property (nonatomic,strong) UIView *bgViewFandian;
@end
