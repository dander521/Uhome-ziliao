//
//  MCSlideView.h
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MCSlideDelegate <NSObject>

@required
/*
 * 修改登录密码
 */
-(void)modifyLoginPwdWithDictionary:(NSDictionary *)dic;
/*
 * 修改资金密码
 */
-(void)modifyPayPwdWithDictionary:(NSDictionary *)dic;



@end


@interface MCSlideView : UIView

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *titleArray;

@property(nonatomic,strong)NSArray *selectedTitleArray;

@property(nonatomic,strong)UIColor *normalColor;

@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *SlideSelectedColor;

+(MCSlideView *)segmentControlViewWithFrame:(CGRect)frame;

-(void)btnTouch:(UIButton *)sender;

@property (nonatomic, weak) id<MCSlideDelegate>delegate;

@end
