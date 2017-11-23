//
//  MCWageRecordXiaJiCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCWageRecordXiaJiCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSString *IsSelf;// 查询类型（0：自身日工资，1：直属下级日工资）
@property(nonatomic,strong)NSString *UserID;// 搜索用户名时不传，其他情况传    String    当前登录用户ID
@property(nonatomic,strong)NSString *User_Name;// 搜索用户名时传，不搜则不传    String    搜索用户名称
@property(nonatomic,strong)NSString *BeginTime;//
@property(nonatomic,strong)NSString *EndTime;//
@property(nonatomic,strong)NSString *CurrentPageIndex;//
@property(nonatomic,strong)NSString *CurrentPageSize;//

#pragma mark-下拉刷新
- (void)refreashDataFromSearchBar;

@end
