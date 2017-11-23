//
//  MCFilterCollectionViewCell.h
//  TLYL
//
//  Created by miaocai on 2017/6/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCfilterBallModel : NSObject
@property (nonatomic,assign) BOOL selected;
@property (nonatomic,strong) NSString *info;
@end
@interface MCFilterCollectionViewCell : UICollectionViewCell
/**数据源*/
@property (nonatomic,strong) MCfilterBallModel *dataSource;
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@end
