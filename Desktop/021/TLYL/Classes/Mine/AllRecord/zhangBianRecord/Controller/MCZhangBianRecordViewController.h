//
//  MCZhangBianRecordViewController.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCZhangBianRecordViewController : UIViewController

@property (nonatomic,strong)NSString * Source;
@property (nonatomic,assign)BOOL IsHistory;//    IsHistory	是	Boolean	是否为历史记录
@property (nonatomic,strong)NSString * statTime;//    statTime	是	String	开始时间
@property (nonatomic,strong)NSString * endTime;//    endTime	是	String	结束时间
@property (nonatomic,strong)NSString * CurrentPageIndex;//    CurrentPageIndex	是	Int	当前页下标
@property (nonatomic,strong)NSString * CurrentPageSize;//    CurrentPageSize	是	Int	当前页请求条目数

@property (nonatomic,assign)BOOL mmViewContoller;
@property (nonatomic,strong) NSString *subUserID;
@property (nonatomic,strong) NSString *subUserName;

@end
