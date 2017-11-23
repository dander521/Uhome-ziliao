//
//  MCRechargePayAliTestViewController.m
//  TLYL
//
//  Created by MC on 2017/9/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargePayAliTestViewController.h"

@interface MCRechargePayAliTestViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation MCRechargePayAliTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self loadLocalHTMLFileToUIWebView];
    
}

-(void)createUI{
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT-64)];
    self.webView=webView;
    [self.view addSubview:webView];
    
}


- (void)loadLocalHTMLFileToUIWebView{
    
    self.title=@"支付宝充值演示";
    
    
        // 获取本地html文件文件路径
        NSString *localHTMLPageName = @"alipayHelp";
        NSString *path = [[NSBundle mainBundle] pathForResource:localHTMLPageName ofType:@"html"];
        // 从html文件中读取html字符串
        NSString *htmlString = [NSString stringWithContentsOfFile:path
                                                         encoding:NSUTF8StringEncoding
                                                            error:NULL];
        
        [SVProgressHUD showWithStatus:@"正在加载"];
        
        //        NSData *strData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
        self.webView.delegate = self;
        // 加载本地HTML字符串
        [self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
        
        //        [self.webView loadData:strData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[[NSBundle mainBundle] bundleURL]];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

