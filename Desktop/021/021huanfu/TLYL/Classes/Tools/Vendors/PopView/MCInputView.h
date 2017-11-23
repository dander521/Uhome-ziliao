//
//  MCInputView.h
//  TLYL
//
//  Created by miaocai on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCInputView : UIView

@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) void(^cellDidSelected)(NSInteger);
@property (nonatomic,strong) void(^cellDidSelectedTop)(NSInteger);
@property (nonatomic,strong) void(^cellDidSelectedBlock)(NSDictionary*);
- (void)show;
- (void)hiden;
@end
