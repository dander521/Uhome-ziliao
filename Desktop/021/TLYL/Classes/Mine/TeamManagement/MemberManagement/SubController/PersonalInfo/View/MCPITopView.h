//
//  MCPITopView.h
//  TLYL
//
//  Created by miaocai on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUrStatusModel.h"

@interface MCPITopView : UIView

@property (nonatomic,strong) MCUrStatusModel *dataSource;
@property (nonatomic,strong) NSString *userName;
@end


