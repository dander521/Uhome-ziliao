//
//  MCHelpCenterTableViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCHelpCenterBtn : UIButton

@property (nonatomic,strong) NSString * type;

@end
@protocol MCHelpCenterCellDelegate <NSObject>
@required

- (void)cellDidSelectWithType:(NSString *)type;

@end


@interface MCHelpCenterTableViewCell : UITableViewCell

+(CGFloat)computeHeight:(NSArray*)info;
@property (nonatomic,strong) NSArray * dataSource;
@property (nonatomic, weak) id<MCHelpCenterCellDelegate>delegate;

@end
