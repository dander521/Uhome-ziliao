//
//  MCMemberMViewController.h
//  TLYL
//
//  Created by miaocai on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseDataViewController.h"
#import "MCTopSelectedView.h"
static NSMutableArray *_gTopArray;

@interface MCMemberMViewController : MCBaseDataViewController

@property (nonatomic,strong) NSString *LikeUserName;

@property (nonatomic,strong) NSString *subUserID;
/**开始查询时间*/
@property (nonatomic,strong) NSString *BeginDate;
/**结束查询时间*/
@property (nonatomic,strong) NSString *EndDate;

@property (nonatomic,assign) BOOL firstSubViewController;
/**类型（1:全部下级 2-直属下级）*/
@property (nonatomic,assign) int TreeType;
@end
