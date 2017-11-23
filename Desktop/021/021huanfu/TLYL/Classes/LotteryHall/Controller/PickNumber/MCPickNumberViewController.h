//
//  MCPickNumberViewController.h
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseLotteryHallViewController.h"


@interface MCPickNumberViewController : MCBaseLotteryHallViewController

/**分组保存选中的号码球*/
@property (nonatomic,strong) NSMutableArray *selectedArrary;

@end
