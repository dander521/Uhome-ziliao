//
//  MCBaseSelectedView.h
//  TLYL
//
//  Created by MC on 2017/10/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MCBaseSelectedViewActionHandler)(NSInteger type);

@interface MCBaseSelectedView : UIView

@property (nonatomic,copy)MCBaseSelectedViewActionHandler block;

-(void)reloadData;

#pragma mark-刷新头像
-(void)refreashImgVIcon;
@end
