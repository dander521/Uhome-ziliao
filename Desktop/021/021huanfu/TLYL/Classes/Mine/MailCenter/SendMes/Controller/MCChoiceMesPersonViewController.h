//
//  MCChoiceMesPersonViewController.h
//  TLYL
//
//  Created by miaocai on 2017/11/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBaseDataViewController.h"

@interface MCChoiceMesPersonViewController : MCBaseDataViewController
@property (nonatomic,strong) void(^selectedPersonBlock)(NSArray *,BOOL);
@end
