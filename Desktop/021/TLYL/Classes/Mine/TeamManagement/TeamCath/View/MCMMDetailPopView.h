//
//  MCMMDetailPopView.h
//  TLYL
//
//  Created by miaocai on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCTeamCModel.h"

@interface MCMMDetailPopView : UIView

@property (nonatomic,strong) MCTeamCModel *dataSource;
@property (nonatomic,strong) NSArray *arrData;
@property (nonatomic,strong) void(^cancelBtnBlock)();
@property (nonatomic,strong) void(^continueBtnBlock)();
- (void)show;
- (void)hidden;
@end
