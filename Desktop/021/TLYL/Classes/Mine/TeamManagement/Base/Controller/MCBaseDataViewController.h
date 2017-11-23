//
//  MCBaseDataViewController.h
//  TLYL
//
//  Created by miaocai on 2017/10/23.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCNoDataWindow.h"
#import "MCErrorWindow.h"
#import "MCNONetWindow.h"
#import "MCBaseDataModel.h"

@interface MCBaseDataViewController : UIViewController


@property (nonatomic,strong) MCNoDataWindow *noDataWin;
@property (nonatomic,strong) MCErrorWindow *errDataWin;
@property (nonatomic,strong) MCNONetWindow *errNetWin;

- (void)loadData;
- (void)showExDataView;
- (void)hiddenExDataView;

@end
