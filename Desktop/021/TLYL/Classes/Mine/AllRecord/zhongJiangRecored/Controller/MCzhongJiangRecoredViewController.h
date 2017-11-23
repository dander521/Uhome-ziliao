//
//  MCzhongJiangRecoredViewController.h
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCzhongJiangRecoredViewController : UIViewController

@property (nonatomic,strong)NSString *LotteryCode;//    是    Int / String    彩种编码（查询全部时，传空字符串）
@property (nonatomic,assign)BOOL IsHistory ;//   是    Boolean    当前库（false），历史库（true）
@property (nonatomic,strong)NSString *OrderState ;//   是    Int    固定传 16777216
@property (nonatomic,strong)NSString * statTime;//    statTime    是    String    开始时间
@property (nonatomic,strong)NSString * endTime;//    endTime    是    String    结束时间
@property (nonatomic,strong)NSString *CurrentPageIndex ;//   是    Int    当前页下标
@property (nonatomic,strong)NSString *CurrentPageSize ;//   是    Int    当前页请求条目数

@end
