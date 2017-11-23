//
//  MCSettingFooterView.h
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MCSettingFooterDelegate <NSObject>
@required
/*
 *  退出登录
 */
-(void)performLogOut;

@end

@interface MCSettingFooterView : UIView

@property (nonatomic, weak) id<MCSettingFooterDelegate>delegate;

+(CGFloat)computeHeight:(id)info;

@end
