//
//  MCInBoxDetailViewController.h
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCInBoxDetailViewController : UIViewController
@property (nonatomic,assign) int ID;
@property (nonatomic,weak) UILabel *titleContentLabel;
@property (nonatomic,weak) UILabel *shouContentLabel;
@property (nonatomic,weak) UILabel *dateLabel;
@property (nonatomic,weak) UIWebView *contentWeb;
@property (nonatomic,weak) UIButton *btn;
@property (nonatomic,weak) UILabel *shouLabel;
- (void)loadData;
- (void)btnClick;
@end
