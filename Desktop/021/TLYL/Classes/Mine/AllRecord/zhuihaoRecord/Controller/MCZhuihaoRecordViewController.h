//
//  MCZhuihaoRecordViewController.h
//  TLYL
//
//  Created by MC on 2017/10/17.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCZhuihaoRecordViewController : UIViewController
@property (nonatomic,strong)NSString * LotteryCode;//    LotteryCode	是	Int /String	彩种编码 / 查全部时传 空字符串
@property (nonatomic,assign)BOOL IsHistory;//    IsHistory	是	Boolean	是否为历史记录
@property (nonatomic,strong)NSString * statTime;//    statTime	是	String	开始时间
@property (nonatomic,strong)NSString * endTime;//    endTime	是	String	结束时间
@property (nonatomic,strong)NSString * CurrentPageIndex;//    CurrentPageIndex	是	Int	当前页下标
@property (nonatomic,strong)NSString * CurrentPageSize;//    CurrentPageSize	是	Int	当前页请求条目数
@end
