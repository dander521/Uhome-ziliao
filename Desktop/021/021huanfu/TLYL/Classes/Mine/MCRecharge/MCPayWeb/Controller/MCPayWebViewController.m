//
//  MCPayWebViewController.m
//  TLYL
//
//  Created by MC on 2017/7/28.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPayWebViewController.h"


@interface MCPayWebViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@end

@implementation MCPayWebViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [BKIndicationView dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];

    

}

-(void)createUI{
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.left.and.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    self.webView=webView;
    
    // 2.创建URL
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURL *url = [self GetNSURLWithURL:_url];
    
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [webView loadRequest:request];
    // 5.最后将webView添加到界面
    webView.delegate = self;
    
    
    //创建UIActivityIndicatorView背底半透明View
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, G_SCREENHEIGHT)];
    [view setTag:103];
    [view setBackgroundColor:RGB(150, 150, 150)];
    [view setAlpha:0.9];
    [self.view addSubview:view];
    
    _activityIndicator =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    _activityIndicator.color = RGB(143, 0, 210);
    _activityIndicator.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    [_activityIndicator setCenter:view.center];
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:_activityIndicator];

    

}


//1.转换编码
-(NSURL *)GetNSURLWithURL:(NSString *)sUrl{
    sUrl = [sUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:[MCPayWebViewController returnFormatString:sUrl]];
    return url;
}

//2.除去空格
+(NSString *)returnFormatString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" "withString:@" "];
}




/*浏览器后退*/
- (void)clickGoBackBtn{
    if(self.webView.canGoBack){
        [self.webView goBack];
    }
}
/*浏览器前进*/
- (void)clickGoForwardBtn{
    if(self.webView.canGoForward){
        [self.webView goForward];
    }
}
#pragma mark - UIWebViewDelegate代理方法
#pragma mark 开始加载
//是否允许加载网页，也可获取js要打开的url，通过截取此url可与js交互
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{

    return YES;
}
//开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //显示网络请求加载
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    [_activityIndicator startAnimating];
}
//网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //隐藏网络请求加载图标
    [UIApplication sharedApplication].networkActivityIndicatorVisible = false;



    [_activityIndicator stopAnimating];
    UIView *view=(UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    

    //取得html内容
    self.title=[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"%@",[self.webView stringByEvaluatingJavaScriptFromString:@"document.title"]);
}
//网页加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{


    [_activityIndicator stopAnimating];
    UIView *view=(UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"系统提示"
//                                                    message:@"网络连接发生错误!"
//                                                   delegate:self
//                                          cancelButtonTitle:nil
//                                          otherButtonTitles:@"确定", nil];
//    [alert show];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
