//
//  MCSettingTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MCSettingBtn : UIButton

@property (nonatomic,strong) NSString * type;

@end
@protocol MCSettingCellDelegate <NSObject>
@required

- (void)cellDidSelectWithType:(NSString *)type;

@end


@interface MCSettingTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(NSArray*)info;
@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic, weak) id<MCSettingCellDelegate>delegate;


@property (nonatomic,strong)UILabel * anqunWenTiLab;
@end
