//
//  MCAlertView.h
//  
//
//  Created by menhao on 17/6/12.
//
//

#import <UIKit/UIKit.h>

@interface MCAlertView : UIView

@property (nonatomic,weak) UITextField *btTF;

@property (nonatomic,weak)  UIButton *msBtn;

@property (nonatomic,weak)  UIButton *moneyBtn;

@property (nonatomic,weak)  UILabel *titleSelectedInfoLabel;

@property (nonatomic,strong) void(^moshiBlock)();

@property (nonatomic,strong) void(^fandianBlock)();

@property (nonatomic,assign)BOOL isShowMSPop;

@property (nonatomic,assign)BOOL isShowMoneyPop;
- (void)showStackWindow;

- (void)hideStackWindow;

- (void)showStackWindowWithHeight:(CGFloat)height;

+ (instancetype)alertInstance;

//此方法专门在键盘谈起的时候调用
-(void)popViewHidden;


@end
