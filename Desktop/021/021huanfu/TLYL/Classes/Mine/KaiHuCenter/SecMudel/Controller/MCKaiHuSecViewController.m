//
//  MCKaiHuSecViewController.m
//  TLYL
//
//  Created by miaocai on 2017/11/2.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCKaiHuSecViewController.h"
#import "MCRegisterSubbyLinkModel.h"
#import "MCMMFandianModel.h"
#import "MCInputView.h"
#import "MCMineInfoModel.h"
#import "MCPeiEFrtViewController.h"
#import "MCKHCenterPopVIew.h"

@interface MCKaiHuSecViewController ()
@property (nonatomic,weak) UIButton *btn;
@property (nonatomic,weak) UIButton *btnRt;
@property (nonatomic,weak) UIButton *btnLf;
@property (nonatomic,weak) UIButton *btnfandian;
@property (nonatomic,weak) UITextField *tfTuanDdui;
@property (nonatomic,weak) UITextField *tfQQ;
@property (nonatomic,strong)MCRegisterSubbyLinkModel *regSubModel;
@property (nonatomic,assign) int Rebate;
@property (nonatomic,assign) BOOL IsAgent;
@property (nonatomic,strong) MCMMFandianModel *fandianModel;
@property (nonatomic,strong) NSArray *dataArr;
///**条件选择*/
@property (nonatomic,weak) MCInputView *viewPop;
@property (nonatomic,weak) UIView *cloverView;
@property (nonatomic,strong) MCMineInfoModel *infoModel;
@property (nonatomic,weak) NSMutableArray *arrD;
@property (nonatomic,weak) NSMutableArray *arrH;
@property (nonatomic,weak) MCKHCenterPopVIew *coverView;
@end

@implementation MCKaiHuSecViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"开户中心";
    self.view.backgroundColor = RGB(231, 231, 231);
    [self addNavRightBtn];
    [self setUpUI];
    [self loadData];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.hidesBottomBarWhenPushed = NO;
}
#pragma mark -- set UI
- (void)addNavRightBtn {
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"配额" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(18)];
    self.btn =btn;
    [btn sizeToFit];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(allBtnClick) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)setUpUI{
    //2个按钮
    UIButton *btnLf = [[UIButton alloc] init];
    [self.view addSubview:btnLf];
    [btnLf addTarget:self action:@selector(btnLfClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnLf setBackgroundImage:[UIImage imageNamed:@"dl-wxz"] forState:UIControlStateNormal];
    [btnLf setBackgroundImage:[UIImage imageNamed:@"dl-xz"] forState:UIControlStateSelected];
    [btnLf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MC_REALVALUE(100));
        make.top.equalTo(self.view).offset(MC_REALVALUE(41) + 64);
        make.height.width.equalTo(@(MC_REALVALUE(50)));
    }];
    UILabel *labelLf = [[UILabel alloc] init];
    [self.view addSubview:labelLf];
    labelLf.text = @"代理";
    labelLf.textColor = RGB(46, 46, 46);
    labelLf.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [labelLf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btnLf);
        make.top.equalTo(btnLf.mas_bottom).offset(MC_REALVALUE(8));
    }];
    
    UIButton *btnRt = [[UIButton alloc] init];
    [self.view addSubview:btnRt];
    [btnRt addTarget:self action:@selector(btnRtClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnRt setBackgroundImage:[UIImage imageNamed:@"hy-wxz"] forState:UIControlStateNormal];
    [btnRt setBackgroundImage:[UIImage imageNamed:@"hy-xz"] forState:UIControlStateSelected];
    [btnRt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(MC_REALVALUE(-100));
        make.top.equalTo(self.view).offset(MC_REALVALUE(41) + 64);
        make.height.width.equalTo(@(MC_REALVALUE(50)));
    }];
    UILabel *labelRt = [[UILabel alloc] init];
    [self.view addSubview:labelRt];
    labelRt.text = @"会员";
    labelRt.textColor = RGB(46, 46, 46);
    labelRt.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [labelRt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btnRt);
        make.top.equalTo(btnLf.mas_bottom).offset(MC_REALVALUE(8));
    }];
    
    UIView *middleView = [[UIView alloc] init];
    middleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:middleView];
    middleView.layer.cornerRadius = 6;
    middleView.layer.masksToBounds = YES;
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(MC_REALVALUE(13));
        make.right.equalTo(self.view).offset(MC_REALVALUE(-13));
        make.height.equalTo(@(MC_REALVALUE(151)));
        make.top.equalTo(labelLf.mas_bottom).offset(MC_REALVALUE(42));
    }];

    
    UILabel *labelfandian = [[UILabel alloc] init];
    [middleView addSubview:labelfandian];
    labelfandian.text = @"返点设置";
    labelfandian.textAlignment = NSTextAlignmentRight;
    labelfandian.textColor = RGB(46, 46, 46);
    labelfandian.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [labelfandian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView).offset(MC_REALVALUE(0));
        make.left.equalTo(middleView).offset(MC_REALVALUE(0));
        make.width.equalTo(@(MC_REALVALUE(75)));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    
    UIButton *btnfandian = [[UIButton alloc] init];
    [middleView addSubview:btnfandian];
    [btnfandian setTitle:@"1956~0" forState:UIControlStateNormal];
    [btnfandian setTitleColor:RGB(46, 46, 46) forState:UIControlStateNormal];
    [btnfandian addTarget:self action:@selector(btnfandianClick) forControlEvents:UIControlEventTouchUpInside];
    btnfandian.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnfandian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelfandian).offset(MC_REALVALUE(0));
        make.right.equalTo(middleView).offset(MC_REALVALUE(0));
        make.left.equalTo(labelfandian.mas_right).offset(MC_REALVALUE(40));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    self.btnfandian = btnfandian;
    UIImageView *img = [[UIImageView alloc] init];
    [btnfandian addSubview:img];
    img.image = [UIImage imageNamed:@"矩形-11-拷贝-3"];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnfandian);
        make.right.equalTo(btnfandian).offset(MC_REALVALUE(-16));
        make.width.equalTo(@(MC_REALVALUE(10)));
        make.height.equalTo(@(MC_REALVALUE(16)));
        
    }];
    
    UILabel *labelname = [[UILabel alloc] init];
    [middleView addSubview:labelname];
    labelname.text = @"团队名称";
    labelname.textColor = RGB(46, 46, 46);
    labelname.textAlignment = NSTextAlignmentRight;
    labelname.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [labelname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnfandian.mas_bottom).offset(MC_REALVALUE(0));
        make.left.equalTo(middleView).offset(MC_REALVALUE(0));
        make.width.equalTo(@(MC_REALVALUE(75)));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    UIView *line1View = [[UIView alloc] init];
    line1View.backgroundColor = RGB(181, 181, 181);
    [middleView addSubview:line1View];
    [line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(middleView);
        make.left.equalTo(middleView).offset(MC_REALVALUE(20));
        make.height.equalTo(@(MC_REALVALUE(0.5)));
        make.top.equalTo(labelfandian.mas_bottom);
    }];
    UITextField *tfname = [[UITextField alloc] init];
    [middleView addSubview:tfname];
    tfname.textAlignment = NSTextAlignmentLeft;
    tfname.keyboardType = UIKeyboardTypeASCIICapable;
    tfname.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"4~25位中英文数字字符均可" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(14)],NSForegroundColorAttributeName : RGB(181, 181, 181)}];
    tfname.textColor = RGB(46, 46, 46);
    tfname.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [tfname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelname).offset(MC_REALVALUE(0));
        make.right.equalTo(middleView).offset(MC_REALVALUE(0));
        make.left.equalTo(labelname.mas_right).offset(MC_REALVALUE(40));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    self.tfTuanDdui = tfname;
    
    UILabel *labelqq = [[UILabel alloc] init];
    [middleView addSubview:labelqq];
    labelqq.text = @"联系QQ";
    labelqq.textColor = RGB(46, 46, 46);
    labelqq.textAlignment = NSTextAlignmentRight;
    labelqq.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [labelqq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelname.mas_bottom).offset(MC_REALVALUE(0));
        make.left.equalTo(middleView).offset(MC_REALVALUE(0));
        make.width.equalTo(@(MC_REALVALUE(75)));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    UIView *line2View = [[UIView alloc] init];
    line2View.backgroundColor = RGB(181, 181, 181);
    [middleView addSubview:line2View];
    [line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(middleView);
        make.left.equalTo(middleView).offset(MC_REALVALUE(20));
        make.height.equalTo(@(MC_REALVALUE(0.5)));
        make.top.equalTo(labelname.mas_bottom);
    }];
    UITextField *tfqq = [[UITextField alloc] init];
    [middleView addSubview:tfqq];
    tfqq.textAlignment = NSTextAlignmentLeft;
    tfqq.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入团队联系QQ" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(14)],NSForegroundColorAttributeName : RGB(181, 181, 181)}];
    tfqq.textColor = RGB(46, 46, 46);
    tfqq.keyboardType = UIKeyboardTypeNumberPad;
    tfqq.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [tfqq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labelqq).offset(MC_REALVALUE(0));
        make.right.equalTo(middleView).offset(MC_REALVALUE(0));
        make.left.equalTo(labelqq.mas_right).offset(MC_REALVALUE(40));
        make.height.equalTo(@(MC_REALVALUE(49.5)));
    }];
    self.tfQQ = tfqq;

    
    UIButton *btnKai = [[UIButton alloc] init];
    [self.view addSubview:btnKai];
    [btnKai addTarget:self action:@selector(btnKaiClick) forControlEvents:UIControlEventTouchUpInside];
    [btnKai setTitle:@"立即开户" forState:UIControlStateNormal];
    [btnKai setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    btnKai.backgroundColor = RGB(144, 8, 215);
    btnKai.layer.cornerRadius = 6;
    btnKai.clipsToBounds = YES;
    btnKai.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [btnKai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleView.mas_bottom).offset(MC_REALVALUE(108));
        make.right.equalTo(middleView).offset(MC_REALVALUE(0));
        make.left.equalTo(middleView).offset(MC_REALVALUE(0));
        make.height.equalTo(@(MC_REALVALUE(40)));
    }];
    self.btnRt = btnRt;
    self.btnLf = btnLf;
    btnLf.selected = YES;
    
    UILabel *labelnifo = [[UILabel alloc] init];
    [self.view addSubview:labelnifo];
    labelnifo.numberOfLines = 0;
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"注意事项：\n生成链接不会立即扣减配额，只有用户使用该链接注册成功的时候，\n才会扣减配额；请确保您的配额充足，配额不足将造成用户注册不成功！"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [attributedString length])];
    labelnifo.attributedText = attributedString;
    [self.view addSubview:labelnifo];
    labelnifo.textColor = RGB(136, 136, 136);
    labelnifo.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
    [labelnifo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfqq.mas_bottom).offset(MC_REALVALUE(24));
        make.left.right.equalTo(middleView);
    }];
    self.IsAgent = YES;
}

#pragma mark -- 数据请求
- (void)laodData{
    MCRegisterSubbyLinkModel *regSubModel = [[MCRegisterSubbyLinkModel alloc] init];
    self.regSubModel = regSubModel;
    regSubModel.Rebate = self.Rebate;
    regSubModel.IsAgent = self.IsAgent;
    regSubModel.TeamName = self.tfTuanDdui.text;
    regSubModel.QQ = self.tfQQ.text;
    [regSubModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    regSubModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        
        self.tfTuanDdui.text = @"";
        self.tfQQ.text = @"";
        [SVProgressHUD showInfoWithStatus:manager.responseMessage];
        self.coverView.dingDanNumberLabel.text = @"恭喜您！注册链接添加成功！";
        self.coverView.dingDanDetailLabel.text = manager.ResponseRawData[@"RegistUrl"];
        [self.coverView show];
    };
    regSubModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
    };
}

#pragma mark -- 父类数据请求
- (void)loadData{
    MCMineInfoModel *infoModel = [[MCMineInfoModel alloc] init];
    self.infoModel = infoModel;
    [infoModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    __weak typeof(self) weakself = self;
    infoModel.callBackSuccessBlock = ^(NSDictionary *manager) {
        [BKIndicationView dismiss];
        MCMineInfoModel *info = [MCMineInfoModel mj_objectWithKeyValues:manager];
        NSString *myUserId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        int HRebate = [info.HuiRebate intValue];
        int QRebate = [info.MaxAllowRebate intValue];
        int XRebate = [info.GapRebate intValue];
        int QARebate = [info.AgentRebate intValue];
        int UserLevel = [info.UserLevel intValue];
        int MyRebate = [info.MyRebate intValue];
        int Dfandian = 0;
        int Hfandian = 0;
        int m=  MIN(QRebate, MyRebate);
        int rebate = MIN(m, HRebate);
        bool pingji = YES;
        if (pingji) {
            Hfandian = rebate; //@ 会员返点限制
            Dfandian = MIN(MyRebate, QARebate); //代理返点限制
            if (UserLevel == 1 || UserLevel == 2){  //登录用户等级为一级，二级，开户返点最高为1958
                Hfandian = MIN(Hfandian, 1958);
                Dfandian = MIN(Dfandian, 1958);
            }else{  //当前登录为三级及以下，最高只能开到1956
                Hfandian = MIN(Hfandian, 1956);
                Dfandian = MIN(Dfandian, 1956);
            }
        } else {
            Hfandian = (rebate == MyRebate) ? rebate - XRebate : rebate; //@ 会员返点限制
            Dfandian = MyRebate > QARebate ? QARebate : MyRebate - XRebate; //代理返点限制
        }
        NSNumber *min_Rebate = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
        NSMutableArray *arrD = [NSMutableArray array];
        NSMutableArray *arrH = [NSMutableArray array];
        self.arrD = arrD;
        self.arrH =arrH;
        for (NSInteger i = Dfandian; [min_Rebate integerValue]<=i; i--) {
            
            NSString * str = [NSString stringWithFormat:@"%ld~%.1f",i,(i-[min_Rebate integerValue])/20.0];
            i = i - 1;
            [arrD addObject:str];
        }
        
        for (NSInteger j = Hfandian; [min_Rebate integerValue]<= j; j--) {
            NSString * str = [NSString stringWithFormat:@"%ld~%.1f",j,(j-[min_Rebate integerValue])/20.0];
            j = j - 1;
            [arrH addObject:str];
        }
        self.IsAgent = YES;
        if (self.IsAgent) {
            weakself.dataArr = arrD;
        } else {
            weakself.dataArr = arrH;
        }
        if (weakself.dataArr.count >0) {
            [self.btnfandian setTitle:weakself.dataArr[0] forState:UIControlStateNormal];
            self.Rebate =[weakself.dataArr[0] intValue];
        }
        
    };
    infoModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        [BKIndicationView dismiss];
        
    };
    
}
#pragma mark -- 点击事件
//设置返点
- (void)btnfandianClick{
    self.cloverView.hidden = NO;
    if (self.dataArr.count == 0) {
        return;
    }
    self.viewPop.dataArray = self.dataArr;
    [self.viewPop show];
    __weak typeof(self) weakself = self;
    self.viewPop.cellDidSelectedTop = ^(NSInteger i) {
        [weakself.viewPop hiden];
        weakself.cloverView.hidden = YES;
        [weakself.btnfandian setTitle:weakself.viewPop.dataArray[i] forState:UIControlStateNormal];
        weakself.Rebate =[weakself.viewPop.dataArray[i] intValue];
        
    };
    
}
// 立即开户
- (void)btnKaiClick{
    if (self.btnLf.selected == NO && self.btnRt.selected == NO) {
        [SVProgressHUD showInfoWithStatus:@"请选择注册用户类型！"];
        return;
    }
    if ([self.tfTuanDdui.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"团队名称不能为空！"];
        return;
    }
    if ([self.tfQQ.text isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:@"联系QQ不能为空！"];
        return;
    }
  
    if (self.tfTuanDdui.text.length <4 || self.tfTuanDdui.text.length>25) {
        [SVProgressHUD showInfoWithStatus:@"团队名称由4-25个汉字、数字或字母组成"];
        return;
    }
    if (self.tfQQ.text.length <5) {
        [SVProgressHUD showInfoWithStatus:@"联系QQ不能少于5位！"];
        return;
    }
    if (self.btnRt.selected == YES) {
        self.IsAgent = NO;
    }
    if (self.btnLf.selected == YES) {
        self.IsAgent = YES;
    }
    [self laodData];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing: YES];
}
//代理
- (void)btnLfClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.btnRt.selected = !btn.selected;
    self.dataArr = self.arrD;
}
// 会员
- (void)btnRtClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.btnLf.selected = !btn.selected;
    self.dataArr = self.arrH;
}
// 配额
- (void)allBtnClick{
    MCPeiEFrtViewController *peieVC = [[MCPeiEFrtViewController alloc] init];
    [self.navigationController pushViewController:peieVC animated:YES];
}
- (void)tapClick{
    [self.viewPop hiden];
    self.cloverView.hidden = YES;
    
}
#pragma mark -- setter and getter 
- (UIView *)cloverView{
    if (_cloverView == nil) {
        UIView *cloverView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
        cloverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:cloverView];
        _cloverView = cloverView;
        [cloverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
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

- (MCKHCenterPopVIew *)coverView{
    if (_coverView == nil) {
        MCKHCenterPopVIew *coverView = [[MCKHCenterPopVIew alloc] init];
        __weak typeof(self) weakself = self;
        [self.view addSubview:coverView];
        _coverView = coverView;
        __weak MCKHCenterPopVIew *weakClo = coverView;
        coverView.cancelBtnBlock  = ^{
            [weakClo hidden];
 
        };
    }
    return _coverView;
    
    
}
@end
