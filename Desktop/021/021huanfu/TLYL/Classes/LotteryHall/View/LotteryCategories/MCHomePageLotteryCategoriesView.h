//
//  MCHomePageLotteryCategoriesView.h
//  Uhome
//
//  Created by miaocai on 2017/5/27.
//  Copyright © 2017年 menhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserDefinedLotteryCategoriesModel.h"

@protocol MCHomePageLotteryCategoriesDelegate <NSObject>
@required
/*
 * 跳转自定义彩种
 */
-(void)SetUserDefinedLotteryCategories;

@end

@interface MCHomePageLotteryCategoriesView : UIView
@property (nonatomic,weak) UICollectionView *collectionView;
//collectionViewDidSelectedCallBack
@property (nonatomic,strong) void(^collectionViewDidSelectedCallBack)(MCUserDefinedLotteryCategoriesModel *model);
@property (nonatomic,strong) void(^collectionViewDidSelectedAddBtnCallBack)();
@property (nonatomic, weak) id<MCHomePageLotteryCategoriesDelegate>delegate;
-(void)relayOutUI;



@end
