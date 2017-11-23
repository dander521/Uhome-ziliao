//
//  MCPISubTableViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/10/23.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCPISubTableViewCell : UITableViewCell
@property (nonatomic,strong) NSDictionary *dataSource;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,assign) int rebateId;
@end
