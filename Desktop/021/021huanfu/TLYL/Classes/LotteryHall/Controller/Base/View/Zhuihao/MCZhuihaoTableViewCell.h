//
//  MCZhuihaoTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCZhuiHaoModel.h"

@interface MCZhuihaoTableViewCell : UITableViewCell

@property (nonatomic,strong) MCZhuiHaoModel *dataSource;

@property (nonatomic,strong) void(^textFiledDidBecomeFisrtR)(NSString *str, CGRect rect);

@property (nonatomic,strong) void(^textFiledDidSelected)(MCZhuiHaoModel *dataSource,NSString *last);

@property (nonatomic,strong) void(^checkBoxDidSelected)(MCZhuiHaoModel *dataSource,NSString *last);

@property (nonatomic,strong) void(^checkBoxDidUnSelected)(MCZhuiHaoModel *dataSource,NSString *last);

@property (nonatomic,strong) NSString *title;
@end
