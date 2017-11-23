//
//  MCBonusRecordMySelfCollectionViewCell.h
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCBonusRecordMySelfCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) NSString * CurrentPageIndex;
@property(nonatomic, strong) NSString * CurrentPageSize    ;
@property(nonatomic, strong) NSString * IsSelf;//查询类型（0：自身分红，1：直属下级分红）
@property(nonatomic, strong) NSString * GetUserType;//下级类型（0：全部，1：会员，2：代理）
@property(nonatomic, strong) NSString * UserName;//默认传空串，当搜索用户名时传所搜用户名
@property(nonatomic, strong) NSString * UserID;//搜索用户名时不传，其他情况传    String    当前登录用户ID
@property(nonatomic, strong) NSString * BeginTime;
@property(nonatomic, strong) NSString * EndTime;

#pragma mark-下拉刷新
- (void)refreashDataFromSearchBar;
@end
