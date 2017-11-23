//
//  MCMMForwordController.m
//  TLYL
//
//  Created by miaocai on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMForwordController.h"
#import "MCMMForwordModel.h"
#import "MCInputView.h"
#import "MCUserMoneyModel.h"

@interface MCMMForwordController ()

@property (nonatomic,strong) MCMMForwordModel *forwordModel;
@property (nonatomic,strong) MCUserMoneyModel * userMoneyModel;
@property (nonatomic,weak) UILabel *yueValueLabel;
@property (nonatomic,weak) UITextField *passwordTF;
@property (nonatomic,weak) UITextField *zhuanTF;
@property (nonatomic,weak) UITextField *qitaTF;
@property (nonatomic,strong) NSString *Mark;
@property (nonatomic,weak) UILabel *endDateLabDetail;
///**条件选择*/
@property (nonatomic,weak) MCInputView *viewPop;
@property (nonatomic,weak) UIView *cloverView;
@end

@implementation MCMMForwordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self shuaxinBtnClick];
    self.navigationItem.title = @"下级转账";
    self.Mark = @"转账";

    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.cloverView.hidden = YES;
    [self.viewPop hiden];
    
}
- (void)setUpUI{
    
    self.view.backgroundColor = RGB(231, 231, 231);
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH,MC_REALVALUE(40))];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIImageView *imgV = [[UIImageView alloc] init];
    [topView addSubview:imgV];
    imgV.image = [UIImage imageNamed:@"czjl-xz"];
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(MC_REALVALUE(18));
        make.top.equalTo(topView).offset(MC_REALVALUE(12));
        make.height.width.equalTo(@(MC_REALVALUE(16)));
    }];
    UILabel *yueLabel = [[UILabel alloc] init];
    yueLabel.text = @"余额";
    yueLabel.textColor = RGB(46, 46, 46);
    [topView addSubview:yueLabel];
    yueLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [yueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgV.mas_right).offset(MC_REALVALUE(6));
        make.centerY.equalTo(topView);
    }];
    UILabel *yueValueLabel = [[UILabel alloc] init];
    yueValueLabel.text = @"加载中";
    self.yueValueLabel =yueValueLabel;
    yueValueLabel.textColor = RGB(249, 84, 83);
    [topView addSubview:yueValueLabel];
    yueValueLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [yueValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yueLabel.mas_right).offset(MC_REALVALUE(5));
        make.centerY.equalTo(topView);
    }];
    
    UIButton *shuaxinBtn = [[UIButton alloc] init];
    [topView addSubview:shuaxinBtn];
    [shuaxinBtn addTarget:self action:@selector(shuaxinBtnClick) forControlEvents:UIControlEventTouchDown];
    [shuaxinBtn setImage:[UIImage imageNamed:@"shuaxinyue"] forState:UIControlStateNormal];
    [shuaxinBtn setTitle:@"刷新余额" forState:UIControlStateNormal];
    [shuaxinBtn setTitleColor:RGB(46, 46, 46) forState:UIControlStateNormal];
    shuaxinBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [shuaxinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView.mas_right).offset(-MC_REALVALUE(18));
        make.centerY.equalTo(topView);
    }];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 + 40, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(202))];
    [self.view addSubview:middleView];
    middleView.layer.cornerRadius = 6;
    middleView.clipsToBounds = YES;
    middleView.backgroundColor = [UIColor whiteColor];
    
   
    UIView *bgViewTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(49.5))];
    [middleView addSubview:bgViewTitle];
    bgViewTitle.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab =[[UILabel alloc]init];
    titleLab.textColor=RGB(46, 46, 46);
    titleLab.font=[UIFont systemFontOfSize: MC_REALVALUE(14)];
    titleLab.text =@"下级名称";
    titleLab.textAlignment=NSTextAlignmentCenter;
    [bgViewTitle  addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgViewTitle);
        make.left.equalTo(bgViewTitle).offset( MC_REALVALUE(18));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
        
    }];
    
    UILabel *titleLabDetail =[[UILabel alloc]init];
    titleLabDetail.textColor=RGB(46, 46, 46);
    titleLabDetail.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    titleLabDetail.text =self.dataSource.UserName;
    titleLabDetail.textAlignment=NSTextAlignmentRight;
    [bgViewTitle addSubview: titleLabDetail];
    [titleLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLab.mas_right).offset(MC_REALVALUE(40));
        make.centerY.equalTo(titleLab);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = RGB(213, 213, 213);
    [bgViewTitle addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewTitle.mas_bottom);
        make.right.equalTo(bgViewTitle);
        make.left.equalTo(bgViewTitle).offset(MC_REALVALUE(18));
    }];
    
    UIView *bgViewSt = [[UIView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(50), G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(49.5))];
    [middleView addSubview:bgViewSt];
    bgViewSt.backgroundColor = [UIColor whiteColor];
    UILabel *statusLab =[[UILabel alloc]init];
    statusLab.textColor=RGB(46, 46, 46);
    statusLab.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    statusLab.text =@"转账金额";
    statusLab.textAlignment=NSTextAlignmentCenter;
    [bgViewSt  addSubview:statusLab];
    
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgViewSt);
        make.left.equalTo(titleLab);
        make.height.equalTo(@(MC_REALVALUE(49.5)));
        
    }];
    
    UITextField *statusLabDetail =[[UITextField alloc]init];
    statusLabDetail.textColor=RGB(181, 181, 181);
    statusLabDetail.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    statusLabDetail.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"范围1～50000元" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(14)],NSForegroundColorAttributeName : RGB(181, 181, 181)}];
    statusLabDetail.textAlignment=NSTextAlignmentLeft;
    [bgViewSt addSubview: statusLabDetail];
    self.zhuanTF = statusLabDetail;
    [statusLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(statusLab.mas_right).offset(MC_REALVALUE(40));
        make.centerY.equalTo(statusLab);
        make.width.equalTo(@(MC_REALVALUE(126)));
        
    }];
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = RGB(213, 213, 213);
    [bgViewSt addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewSt.mas_bottom);
        make.right.left.equalTo(bgViewSt);
    }];

    
    UIView *bgViewStart = [[UIView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(100), G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(49.5))];
    [middleView addSubview:bgViewStart];
    bgViewStart.backgroundColor = [UIColor whiteColor];
    UILabel *startDateLab =[[UILabel alloc]init];
    startDateLab.textColor=RGB(46, 46, 46);
    startDateLab.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    startDateLab.text =@"资金密码";
    startDateLab.textAlignment=NSTextAlignmentCenter;
    [bgViewStart addSubview:startDateLab];
    
    [startDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgViewStart);
        make.left.equalTo(titleLab);
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = RGB(213, 213, 213);
    [bgViewSt addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.top.equalTo(bgViewStart.mas_bottom);
        make.right.left.equalTo(bgViewStart);
    }];
    UITextField *startDateLabDetail =[[UITextField alloc]init];
    startDateLabDetail.textColor=RGB(181, 181, 181);
    startDateLabDetail.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    startDateLabDetail.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"请输入您的资金密码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(14)],NSForegroundColorAttributeName : RGB(181, 181, 181)}];
    startDateLabDetail.secureTextEntry = YES;
    startDateLabDetail.textAlignment=NSTextAlignmentLeft;
    [bgViewStart addSubview: startDateLabDetail];
    self.passwordTF = startDateLabDetail;
    [startDateLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(startDateLab.mas_right).offset(MC_REALVALUE(40));
        make.centerY.equalTo(startDateLab);
        make.width.equalTo(@(MC_REALVALUE(126)));
    }];

    UIView *bgViewEnd = [[UIView alloc] initWithFrame:CGRectMake(0, MC_REALVALUE(150), G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(49.5))];
    [middleView addSubview:bgViewEnd];
    [bgViewEnd addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewClick)]];
    UILabel *endDateLab =[[UILabel alloc]init];
    endDateLab.textColor=RGB(46, 46, 46);
    endDateLab.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    endDateLab.text =@"备       注";
    endDateLab.textAlignment=NSTextAlignmentLeft;
    [bgViewEnd  addSubview:endDateLab];

    [endDateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgViewEnd);
        make.left.equalTo(titleLab);
        make.width.equalTo(@(MC_REALVALUE(56)));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
        
    }];
    
    UILabel *endDateLabDetail =[[UILabel alloc]init];
    endDateLabDetail.textColor=RGB(46, 46, 46);
    endDateLabDetail.text = @"转账";
    self.endDateLabDetail = endDateLabDetail;
    endDateLabDetail.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    endDateLabDetail.textAlignment=NSTextAlignmentLeft;
    [bgViewEnd addSubview:endDateLabDetail];
    [endDateLabDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endDateLab.mas_right).offset(MC_REALVALUE(40));
        make.centerY.equalTo(endDateLab);
        make.width.equalTo(@(MC_REALVALUE(126)));
        
    }];
    UITextField *qitaTF =[[UITextField alloc]init];
    qitaTF.textColor=RGB(181, 181, 181);
    qitaTF.font=[UIFont systemFontOfSize:MC_REALVALUE(14)];
    qitaTF.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"请输入您的备注内容" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(14)],NSForegroundColorAttributeName : RGB(181, 181, 181)}];
    qitaTF.textAlignment=NSTextAlignmentLeft;
    [bgViewEnd addSubview: qitaTF];
    self.qitaTF = qitaTF;
    qitaTF.hidden = YES;
    [qitaTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(endDateLab.mas_right).offset(MC_REALVALUE(40));
        make.centerY.equalTo(endDateLab);
        make.width.equalTo(@(MC_REALVALUE(126)));
    }];
    [qitaTF addTarget:self action:@selector(qitaTFClick) forControlEvents:UIControlEventEditingChanged];
    UIImageView *imgVe = [[UIImageView alloc] init];
    imgVe.image = [UIImage imageNamed:@"MC_right_arrow"];
    [bgViewEnd addSubview:imgVe];
    [imgVe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgViewEnd.mas_right).offset(MC_REALVALUE(-16));
        make.centerY.equalTo(bgViewEnd);
        make.width.equalTo(@(MC_REALVALUE(10)));
        make.height.equalTo(@(MC_REALVALUE(18)));
    }];
    
    UILabel *infoLabel =[[UILabel alloc]init];
    infoLabel.textColor=RGB(136, 136, 136);
    infoLabel.numberOfLines = 0;
    infoLabel.font=[UIFont systemFontOfSize:MC_REALVALUE(10)];
    infoLabel.textAlignment=NSTextAlignmentLeft;
    infoLabel.text = @"温馨提示：\n下级转账是自己的资金转入下级代理的账户，资金将不再属于您，操作之后将不能撤销，请您谨慎操作。";
    [self.view addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MC_REALVALUE(18));
        make.right.equalTo(self.view).offset(MC_REALVALUE(-18));
        make.top.equalTo(bgViewEnd.mas_bottom).offset(MC_REALVALUE(30));
        make.height.equalTo(@(MC_REALVALUE(47)));
        
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"立即转账" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(14)];
    [self.view addSubview:btn];
    btn.backgroundColor = RGB(144, 8, 216);
    btn.layer.cornerRadius = 6;
    btn.clipsToBounds = YES;
    [btn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MC_REALVALUE(13));
        make.right.equalTo(self.view).offset(MC_REALVALUE(-13));
        make.height.equalTo(@(MC_REALVALUE(40)));
        make.top.equalTo(infoLabel.mas_bottom).offset(MC_REALVALUE(30));
    }];
    self.cloverView.hidden = YES;

}
- (void)qitaTFClick{
    if (self.qitaTF.text.length > 10) {
        self.qitaTF.text = [self.qitaTF.text substringToIndex:10];
    }
}
#pragma mark --发送请求
-(void)loadData{
    MCMMForwordModel *forwordModel = [[MCMMForwordModel alloc] init];
    self.forwordModel = forwordModel;
    forwordModel.TransferMoney = self.zhuanTF.text;
    forwordModel.TargetUserID = [NSString stringWithFormat:@"%d",self.dataSource.UserID];
    forwordModel.TargetUserName = self.dataSource.UserName;
    forwordModel.Password = self.passwordTF.text;
    forwordModel.Mark = self.Mark;
    [forwordModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    
    forwordModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        [SVProgressHUD showInfoWithStatus:manager.responseMessage];
        [self.navigationController popViewControllerAnimated:YES];
    };
    forwordModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
    };
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)dealloc{
    
    NSLog(@"%@----dealloc",self);
}

// 刷新金额
- (void)shuaxinBtnClick{
    __weak typeof(self) wself = self;
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [userMoneyModel refreashDataAndShow];
    self.userMoneyModel=userMoneyModel;
    [BKIndicationView showInView:self.view];
    userMoneyModel.callBackSuccessBlock = ^(id manager) {
        [BKIndicationView dismiss];
        wself.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
        wself.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
        NSString *str = [MCMathUnits GetMoneyShowNum:manager[@"LotteryMoney"]];
        NSArray *arr = [str componentsSeparatedByString:@"."];
        if (arr.count >=2) {
          NSString *str1 = arr[1];
            if (str1.length>=4) {
               str1 = [str1 substringWithRange:NSMakeRange(0, 4)];
               str = [NSString stringWithFormat:@"%@.%@",arr[0],str1];
            }
        }
        wself.yueValueLabel.text = str;
    };
    userMoneyModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        [BKIndicationView dismiss];
    };
}
//弹出框
- (void)bgViewClick{
    self.cloverView.hidden = NO;
    if (self.dataSource.Rebate >= 1950) {
        self.viewPop.dataArray = @[@"转账",@"分红",@"奖励",@"其他",@"日工资"];
    } else {
        self.viewPop.dataArray = @[@"转账",@"分红",@"奖励",@"其他"];
    }
    [self.viewPop show];
    __weak typeof(self) weakself = self;
    self.viewPop.cellDidSelectedTop = ^(NSInteger i) {
        [weakself.viewPop hiden];
        self.cloverView.hidden = YES;
        if (i<3) {
            weakself.endDateLabDetail.text = weakself.viewPop.dataArray[i];
            self.Mark = weakself.viewPop.dataArray[i];
            weakself.qitaTF.hidden = YES;
            weakself.endDateLabDetail.hidden = NO;
        } else {
            weakself.qitaTF.hidden = NO;
            weakself.endDateLabDetail.hidden = YES;
            weakself.Mark = weakself.qitaTF.text;
            [weakself.qitaTF becomeFirstResponder];
        }
    };
    
}
//立即转账
- (void)searchBtnClick{
    
    if ([self.zhuanTF.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"金额不能为空！"];
        return;
    }
    if ([self.passwordTF.text isEqualToString:@""]) {
         [SVProgressHUD showInfoWithStatus:@"密码不能为空！"];
        return;
    }
    if (self.qitaTF.hidden == NO &&([self.qitaTF.text isEqualToString:@""] ||self.qitaTF.text == nil)) {
        [SVProgressHUD showInfoWithStatus:@"备注不能为空！"];
        return;
    }
  
    [self loadData];
    
}
- (void)tap{
    [self.viewPop hiden];
    self.cloverView.hidden = YES;
}

- (UIView *)cloverView{
    if (_cloverView == nil) {
        UIView *cloverView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
        cloverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:cloverView];
        _cloverView = cloverView;
        [cloverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
       
        
    }
    return _cloverView;
    
    
}
- (MCInputView *)viewPop{
    if (_viewPop == nil) {
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [self.view addSubview:viewStatus];
        _viewPop = viewStatus;
    }
    return _viewPop;
}
@end
