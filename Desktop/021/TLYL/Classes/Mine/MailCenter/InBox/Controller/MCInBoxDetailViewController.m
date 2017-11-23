//
//  MCInBoxDetailViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/13.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCInBoxDetailViewController.h"
#import "MCInboxDetailModel.h"
#import "MCSendMessageViewController.h"

@interface MCInBoxDetailViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) MCInboxDetailModel *inboxDModel;

@property (nonatomic,strong) MCInboxDetailModel *model;
@property (nonatomic,weak) UIView *topView;
@property (nonatomic,weak) UILabel *titleLabel;
@end

@implementation MCInBoxDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"信件详情";
    self.view.backgroundColor = RGB(231, 231, 231);
    [self setUpUI];
    [self loadData];
  
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}
- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, MC_REALVALUE(48))];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor whiteColor];
    self.topView = topView;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"主   题:";
    [topView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(MC_REALVALUE(18));
        make.top.equalTo(topView).offset(MC_REALVALUE(10));
    }];
    
    UILabel *titleContentLabel = [[UILabel alloc] init];
    [topView addSubview:titleContentLabel];
    titleContentLabel.textColor = RGB(102, 102, 102);
    titleContentLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [titleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(MC_REALVALUE(5));
        make.centerY.equalTo(titleLabel);
    }];
    titleContentLabel.text = @"加载中";
    self.titleContentLabel = titleContentLabel;
    UILabel *shouLabel = [[UILabel alloc] init];
    shouLabel.text = @"发件人:";
    [topView addSubview:shouLabel];
    self.shouLabel= shouLabel;
    [shouLabel sizeToFit];
    shouLabel.textColor = [UIColor orangeColor];
    shouLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [shouLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(MC_REALVALUE(18));
        make.top.equalTo(titleLabel.mas_bottom).offset(MC_REALVALUE(5));
        make.height.equalTo(@(MC_REALVALUE(15)));
        make.width.equalTo(@(MC_REALVALUE(60)));
        
    }];
    
    UILabel *shouContentLabel = [[UILabel alloc] init];
    [topView addSubview:shouContentLabel];
    self.shouContentLabel = shouContentLabel;
    shouContentLabel.text = @"加载中";
    shouContentLabel.textColor = RGB(102, 102, 102);
    shouContentLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [shouContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleContentLabel);
        make.top.equalTo(shouLabel);
    }];
    UILabel *dateLabel = [[UILabel alloc] init];
    [topView addSubview:dateLabel];
    dateLabel.text = @"加载中";
    self.dateLabel = dateLabel;
    dateLabel.textColor = RGB(141, 141, 141);
    dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(MC_REALVALUE(-18));
        make.centerY.equalTo(shouLabel);
    }];
    
    UIWebView *contentWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64 + MC_REALVALUE(48), G_SCREENWIDTH, G_SCREENHEIGHT - MC_REALVALUE(48))];
    [self.view addSubview:contentWeb];
    [contentWeb stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#E7E7E7'"];
    self.contentWeb = contentWeb;
    contentWeb.scrollView.bounces = NO;
    contentWeb.delegate = self;

    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    btn.backgroundColor = RGB(144, 8, 215);
    [btn setTitle:@"回复邮件" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = MC_REALVALUE(17);
    btn.clipsToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@(MC_REALVALUE(126)));
        make.bottom.equalTo(self.view.mas_bottom).offset(MC_REALVALUE(-24));
    }];
    self.btn = btn;
   
}
//回复邮件
- (void)btnClick{
   
    MCSendMessageViewController *vc = [[MCSendMessageViewController alloc] init];
    [vc.tableViewDataArray addObject:self.model];
    [self.navigationController pushViewController:vc animated:YES];
    [self performSelector:@selector(tabBarSelected) withObject:nil afterDelay:0.3f];
   

}
- (void)tabBarSelected{
   
    [self.tabBarController setSelectedIndex:2];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCInBoxDetailViewController" object:self.model];
}
#pragma mark --发送请求
-(void)loadData{
    
    __weak typeof(self) weakself = self;
    MCInboxDetailModel *inboxDModel = [[MCInboxDetailModel alloc] init];
    self.inboxDModel = inboxDModel;
    inboxDModel.ID = self.ID;
    [inboxDModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
     self.btn.hidden = YES;
    inboxDModel.callBackSuccessBlock = ^(NSDictionary *manager) {
        weakself.btn.hidden = NO;
        MCInboxDetailModel *model = [MCInboxDetailModel mj_objectWithKeyValues:manager];
        weakself.model = model;
        weakself.titleContentLabel.text = model.Title;
        weakself.shouContentLabel.text = model.SendPerson;
        weakself.dateLabel.text = model.SendDateTime;
        [BKIndicationView showInView:self.view];
        [weakself.contentWeb loadHTMLString:model.Content baseURL:nil];
        if (weakself.model.SendPersonLevel == 3) {
            weakself.btn.hidden = YES;
            weakself.shouContentLabel.text = @"系统消息";

        }else if(weakself.model.SendPersonLevel == 2){
            weakself.shouContentLabel.text = @"上级";
            weakself.btn.hidden = NO;
        }else{
            weakself.btn.hidden = NO;
        }
       
        
    };
    
    inboxDModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [SVProgressHUD dismiss];
    };
    
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [BKIndicationView showInView:self.view];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#E7E7E7'"];
    [BKIndicationView dismiss];
}
@end
