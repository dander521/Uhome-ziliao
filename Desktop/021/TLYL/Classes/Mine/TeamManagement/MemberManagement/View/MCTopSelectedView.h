//
//  MCTopSelectedView.h
//  TLYL
//
//  Created by miaocai on 2017/10/30.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTopSelectedView : UIView
@property(nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) void(^topSectedBlock)(NSInteger index);
@end
