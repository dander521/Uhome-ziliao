//
//  MCHelpCenterDetailViewController.m
//  TLYL
//
//  Created by MC on 2017/11/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCHelpCenterDetailViewController.h"
#import "MCDataTool.h"
@interface MCHelpCenterDetailViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation MCHelpCenterDetailViewController



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
    
    self.title=self.helpTitle;
    NSString *localHTMLPageName;
    // 获取本地html文件文件路径
    if ([self.helpTitle isEqualToString:@"资料绑定"]) {
        localHTMLPageName =@"com_bund_info";
    }else if ([self.helpTitle isEqualToString:@"忘记密码"]){
        localHTMLPageName =@"com_forget_pwd";
    }else if ([self.helpTitle isEqualToString:@"账户安全"]){
        localHTMLPageName =@"com_account_safe";
    }else if ([self.helpTitle isEqualToString:@"账户回收"]){
        localHTMLPageName =@"com_account_recycle";
        
        
    }else if ([self.helpTitle isEqualToString:@"充值不到账"]){
        localHTMLPageName =@"charge_failed";
    }else if ([self.helpTitle isEqualToString:@"充值到账时间"]){
        localHTMLPageName =@"charge_arrived_time";
        
        
        
    }else if ([self.helpTitle isEqualToString:@"如何提款"]){
        localHTMLPageName =@"withdrawal_how_to";
    }else if ([self.helpTitle isEqualToString:@"提款时间"]){
        localHTMLPageName =@"withdrawal_time";
    }else if ([self.helpTitle isEqualToString:@"提款要求"]){
        localHTMLPageName =@"withdrawal_rules";
    }else if ([self.helpTitle isEqualToString:@"提款安全"]){
        localHTMLPageName =@"withdrawal_safe";
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:localHTMLPageName ofType:@"html"];
    // 从html文件中读取html字符串
    NSString *htmlString = [NSString stringWithContentsOfFile:path
                                                     encoding:NSUTF8StringEncoding
                                                        error:NULL];
    
    [BKIndicationView showInView:self.view];
    
    //        NSData *strData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    self.webView.delegate = self;
    // 加载本地HTML字符串
    [self.webView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];

    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [BKIndicationView dismiss];
    
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

