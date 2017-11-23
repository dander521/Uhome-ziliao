//
//  MCKefuViewController.m
//  TLYL
//
//  Created by miaocai on 2017/8/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKefuViewController.h"
#import <WebKit/WebKit.h>
#import "MCKefuModel.h"

@interface MCKefuViewController ()<WKNavigationDelegate>
@property (nonatomic,strong) MCKefuModel *model;
@end

@implementation MCKefuViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"联系客服";
    MCKefuModel *model = [[MCKefuModel alloc] init];
    self.model = model;
    [model refreashDataAndShow];
    WKWebView *web = [[WKWebView alloc] initWithFrame:self.view.bounds];
    web.navigationDelegate = self;
    [self.view addSubview:web];
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0, 20, 40, 40);
    btn.layer.cornerRadius = 20;
    btn.clipsToBounds = YES;
    [btn setBackgroundImage:[UIImage imageNamed:@"Sign out"] forState:UIControlStateNormal];
    btn.backgroundColor = RGB(68, 68, 68);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [BKIndicationView showInView:self.view];
    model.callBackSuccessBlock = ^(id manager) {
        
        if ([manager[@"ServiceUrl"] isEqualToString:@""]) {
            [SVProgressHUD showInfoWithStatus:@"客服不可用"];
            return;
        } else {
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:manager[@"ServiceUrl"]]]];
        }
    };
    if ([self.title isEqualToString:@"联系客服"]) {
        btn.hidden = YES;
    } else {
        btn.hidden = NO;
    }
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [BKIndicationView showInView:self.view];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    [BKIndicationView dismiss];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (error.code == -1001 ||error.code == 4) {
        
        [BKIndicationView dismiss];
        [SVProgressHUD showInfoWithStatus:@"页面加载超时！"];
    } else {
        [BKIndicationView dismiss];
    }
    
    
}
- (void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    }


@end
