//
//  MCLoginViewController.m
//  TLYL
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//



#import "MCLoginViewController.h"
#import "MCWaterRippleButton.h"
#import "MCMainTabBarController.h"
#import "MCLoginModel.h"
#import "MCMineInfoModel.h"
#import "MCLotteryID.h"
#import "MCGetMerchantInfoModel.h"
#import "MCKefuViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MCFindPasswordViewController.h"
#import "MCMainNavigationController.h"
#import "MCForcedToChangePasswordViewController.h"
#import "MCGetGAModel.h"
#import "MCGetIPAdress.h"

#define AUTHURL SEVERBASEURLweb-api/api/v4/get_auth_code"

@interface MCLoginViewController ()<UITextFieldDelegate>
//用户名输入框
@property (nonatomic,weak) UITextField *userNameTF;
//密码输入框
@property (nonatomic,weak) UITextField *passWordTF;
//密码输入框
@property (nonatomic,weak) UITextField *gaCodeTF;

@property (nonatomic,weak) UIImageView *authCodeImg;
@property (nonatomic,weak) UIImageView *imgName;
@property (nonatomic,weak) UIImageView *imgPsw;
@property (nonatomic,weak) UIImageView *imgGaCode;

@property (nonatomic,weak) UIImageView *imgAuthCode;
//登录按钮
@property (nonatomic,weak) MCWaterRippleButton *loginBtn;
//底部ScrollView
@property (nonatomic,weak) UIScrollView *baseScrollV;
//loginModel登录模型的强引用
@property (nonatomic,strong) MCLoginModel *loginModel;

@property (nonatomic,strong) MCGetGAModel *gaModel;

@property (nonatomic,strong) MCGetGAModel *getGAmodel;

//getMerchantInfoModel登录模型的强引用
@property (nonatomic,strong) MCGetMerchantInfoModel *getMerchantInfoModel;
@property (nonatomic,strong) NSString *apiIdStr;
@property (nonatomic,strong) UITextField *authCodeTF;
@property (nonatomic,weak) UIView *lineGaCode;
@property (nonatomic,weak) UIView *lineAuthCode;
@end

@implementation MCLoginViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpUI];
    
    NSString *str = [MCGetIPAdress getIPAddress:YES];
    NSLog(@"str == %@",str);
}

- (void)setUpUI{

    CGFloat padding = MC_REALVALUE(76);
    UIScrollView *baseScrolV = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:baseScrolV];
    self.baseScrollV = baseScrolV;
    self.view.backgroundColor = RGB(6, 34, 50);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCLose)];
    [baseScrolV addGestureRecognizer:tap];
    UIImageView *logoImageV = [[UIImageView alloc] init];
    logoImageV.image = [UIImage imageNamed:@"loding-bg"];
    [self.baseScrollV addSubview:logoImageV];
    [logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(MC_REALVALUE(232)));
    }];
    logoImageV.userInteractionEnabled=YES;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"登录";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(16)];
    [titleLabel sizeToFit];
    [logoImageV addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@30);
    }];
    
    UIButton * forgetPasswordBtn = [[UIButton alloc]init];
    [forgetPasswordBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [logoImageV addSubview:forgetPasswordBtn];
    forgetPasswordBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(16)];
    [forgetPasswordBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetPasswordBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [forgetPasswordBtn addTarget:self action:@selector(FindPassword) forControlEvents:UIControlEventTouchUpInside];
    [forgetPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.right.equalTo(logoImageV.mas_right).offset(-18);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
    }];
    
    
    UITextField *userNameTF = [[UITextField alloc] init];
    [self.view addSubview:userNameTF];
    userNameTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName : RGB(181, 181, 181),NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(12)]}];
    userNameTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    userNameTF.delegate = self;
    
    userNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
    userNameTF.textColor = MC_ColorWithAlpha(255, 255, 255, 0.95);
    UIView *lineName = [[UIView alloc] init];
    [self.view addSubview:lineName];
    userNameTF.textColor = RGB(68, 68, 68);
    UIImageView *imgName = [[UIImageView alloc] init];
    [baseScrolV addSubview:imgName];
    imgName.image = [UIImage imageNamed:@"user-icon"];
    self.imgName = imgName;
    self.userNameTF = userNameTF;
    UITextField *passWordTF = [[UITextField alloc] init];
    [self.view addSubview:passWordTF];
    passWordTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    passWordTF.autocorrectionType = UITextAutocorrectionTypeNo;
    passWordTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName : RGB(181, 181, 181),NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(12)]}];

   
    UIButton *kefuBtn = [[UIButton alloc] init];
    [kefuBtn setTitle:@"联系在线客服" forState:UIControlStateNormal];
    [kefuBtn addTarget:self action:@selector(kefuBtnClick) forControlEvents:UIControlEventTouchDown];
    kefuBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [kefuBtn setTitleColor:[UIColor colorWithHexString:@"#9008d7"] forState:UIControlStateNormal];
    [baseScrolV addSubview:kefuBtn];
    
    //GA
    UITextField *gaCodeTF = [[UITextField alloc] init];
    [self.view addSubview:gaCodeTF];
    gaCodeTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    gaCodeTF.autocorrectionType = UITextAutocorrectionTypeNo;
    self.gaCodeTF = gaCodeTF;
    gaCodeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入GA验证码" attributes:@{NSForegroundColorAttributeName : RGB(181, 181, 181),NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(12)]}];
    UIImageView *imgGaCode = [[UIImageView alloc] init];
    baseScrolV.backgroundColor = [UIColor whiteColor];
    [baseScrolV addSubview:imgGaCode];
    imgGaCode.image = [UIImage imageNamed:@"G"];
    self.imgGaCode = imgGaCode;
    UIView *lineGaCode = [[UIView alloc] init];
    [self.view addSubview:lineGaCode];
    lineGaCode.backgroundColor = RGB(181, 181, 181);
    self.lineGaCode = lineGaCode;

    UITextField *authCodeTF = [[UITextField alloc] init];
    [self.view addSubview:authCodeTF];
    authCodeTF.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    authCodeTF.autocorrectionType = UITextAutocorrectionTypeNo;
    self.authCodeTF = authCodeTF;
    authCodeTF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSForegroundColorAttributeName : RGB(181, 181, 181),NSFontAttributeName : [UIFont systemFontOfSize:MC_REALVALUE(12)]}];
    UIImageView *imgAuthCode = [[UIImageView alloc] init];
    baseScrolV.backgroundColor = [UIColor whiteColor];
    [baseScrolV addSubview:imgAuthCode];
    imgAuthCode.image = [UIImage imageNamed:@"yanz-icon"];
    self.imgAuthCode = imgAuthCode;
    UIView *lineAuthCode = [[UIView alloc] init];
    [self.view addSubview:lineAuthCode];
    lineAuthCode.backgroundColor = RGB(181, 181, 181);
    
    [userNameTF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [userNameTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [passWordTF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [passWordTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [authCodeTF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [authCodeTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [gaCodeTF setAutocorrectionType:UITextAutocorrectionTypeNo];
    [gaCodeTF setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    passWordTF.secureTextEntry = YES;
    
    passWordTF.textColor = RGB(68, 68, 68);
    UIView *linePass = [[UIView alloc] init];
    [self.view addSubview:linePass];
    linePass.backgroundColor = RGB(181, 181, 181);
    
    UIImageView *imgPsw = [[UIImageView alloc] init];
    baseScrolV.backgroundColor = [UIColor whiteColor];
    [baseScrolV addSubview:imgPsw];
    imgPsw.image = [UIImage imageNamed:@"lock-icon"];
    self.imgPsw = imgPsw;
    self.passWordTF = passWordTF;
    MCWaterRippleButton *loginBtn = [[MCWaterRippleButton alloc] init];
    [self.view addSubview:loginBtn];
    loginBtn.layer.cornerRadius = MC_REALVALUE(22.5);
    loginBtn.layer.masksToBounds = YES;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(18)];
    [loginBtn addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = RGB(144, 8, 215);
    [loginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(16)];
    passWordTF.delegate = self;
    authCodeTF.delegate = self;
    UIImageView *authCodeImg = [[UIImageView alloc] init];
    [baseScrolV addSubview:authCodeImg];

    [self authAPIID];

    authCodeImg.userInteractionEnabled = YES;
    [authCodeImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chageAuthImg)]];
    self.authCodeImg = authCodeImg;
    [userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(padding + 55);
        make.right.equalTo(self.view.mas_right).offset(-padding);
        make.top.equalTo(logoImageV.mas_bottom).offset(MC_REALVALUE(40));
        make.height.equalTo(@(MC_REALVALUE(50)));
    }];
    
    
    [passWordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameTF.mas_left);
        make.right.equalTo(userNameTF.mas_right);
        make.top.equalTo(userNameTF.mas_bottom);
        make.height.equalTo(userNameTF.mas_height);
    }];

    [linePass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passWordTF.mas_bottom);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.equalTo(@(0.5));
    }];

    [imgPsw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(passWordTF.mas_left).offset(-MC_REALVALUE(23));
        make.centerY.equalTo(passWordTF.mas_centerY);
        make.height.width.equalTo(@(MC_REALVALUE(25)));
    }];

    [authCodeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameTF.mas_left);
        make.right.equalTo(userNameTF.mas_right).offset(MC_REALVALUE(-80));
        make.top.equalTo(passWordTF.mas_bottom);
        make.height.equalTo(userNameTF.mas_height);
    }];
    
    [lineAuthCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(authCodeTF.mas_bottom);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.equalTo(@(0.5));
    }];

    [imgAuthCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(authCodeTF.mas_left).offset(-MC_REALVALUE(23));
        make.centerY.equalTo(authCodeTF.mas_centerY);
        make.height.width.equalTo(@(MC_REALVALUE(25)));
    }];

    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgName.mas_left);
        make.right.equalTo(userNameTF.mas_right);
        make.top.equalTo(lineAuthCode.mas_bottom).offset(MC_REALVALUE(50));
        make.height.equalTo(@(45));
    }];
    [kefuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(loginBtn.mas_bottom).offset(MC_REALVALUE(50));
        
    }];
 
    [imgName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(userNameTF.mas_left).offset(-MC_REALVALUE(23));
        make.centerY.equalTo(userNameTF.mas_centerY);
        make.height.width.equalTo(@(MC_REALVALUE(25)));
    }];
    lineName.backgroundColor = RGB(181, 181, 181);
    [lineName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userNameTF.mas_bottom);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.equalTo(@(0.5));
    }];
    [authCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(authCodeTF.mas_right);
        make.right.equalTo(passWordTF.mas_right);
        make.height.equalTo(authCodeTF);
        make.top.equalTo(authCodeTF);
    }];
}
- (void)chageAuthImg{
//    self.authCodeImg.image = nil;
     [self authAPIID];
  
    
}
- (void)tapCLose{
    [self.view endEditing:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


#pragma mark - touch event


- (void)lineBtnClick{
    
    
}
- (void)kefuBtnClick{
    
    MCKefuViewController *vc = [[MCKefuViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
}
- (void)forgetBtnClick{
    
    
}
- (void)authAPIID{

    NSURL *url=[NSURL URLWithString: [NSString stringWithFormat:@"%@web-api/api/v4/get_auth_code",SEVERBASEURL]];
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    typeof(self) weakSelf = self;
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            self.authCodeImg.image = image;
        });
        NSHTTPURLResponse *re = (NSHTTPURLResponse *)response;
        NSDictionary *dict = [re allHeaderFields];
        NSString *str = dict[@"Set-Cookie"];
        NSString *str1 = [str componentsSeparatedByString:@"JSESSIONID="][1];
        NSString *str2 =  [str1 componentsSeparatedByString:@"; Path="][0];
        weakSelf.apiIdStr = str2;
        [[NSUserDefaults standardUserDefaults] setObject:str1 forKey:@"cookie_id"];
        
      
    } ];
    [dataTask resume];
}
- (void)imageViewTapGestureRecognizer{
    
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

-(void)FindPassword{

    MCFindPasswordViewController * vc = [[MCFindPasswordViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: vc];
    [self presentViewController:nav animated:NO completion:nil];

}
- (void)loadGACode{
    
    MCGetGAModel *gaModel = [[MCGetGAModel alloc]init];
    gaModel.UserName = self.userNameTF.text;
    self.gaModel = gaModel;
    [BKIndicationView showInView:self.view];
    [gaModel refreashDataAndShow];
    
    __weak typeof(self)wself = self;
    CGFloat padding = MC_REALVALUE(76);
    gaModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
       
    };
    gaModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
      wself.getGAmodel = [MCGetGAModel mj_objectWithKeyValues:manager.ResponseRawData];
     
        if ([wself.getGAmodel.VerificationMode containsString:@"1"]) {
            wself.gaCodeTF.hidden = NO;
            wself.imgGaCode.hidden = NO;
            wself.lineGaCode.hidden = NO;
            wself.gaCodeTF.text = @"";
            [wself.gaCodeTF mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(wself.userNameTF.mas_left);
                make.right.equalTo(wself.userNameTF.mas_right);
                make.top.equalTo(wself.passWordTF.mas_bottom);
                make.height.equalTo(wself.userNameTF.mas_height);
            }];

            [wself.lineGaCode mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(wself.gaCodeTF.mas_bottom);
                make.left.equalTo(self.view).offset(padding);
                make.right.equalTo(self.view).offset(-padding);
                make.height.equalTo(@(0.5));
            }];

            [wself.imgGaCode mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(wself.gaCodeTF.mas_left).offset(-MC_REALVALUE(23));
                make.centerY.equalTo(wself.gaCodeTF.mas_centerY);
                make.height.width.equalTo(@(MC_REALVALUE(25)));
            }];
            //
            [wself.authCodeTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wself.userNameTF.mas_left);
            make.right.equalTo(wself.userNameTF.mas_right).offset(MC_REALVALUE(-80));
            make.top.equalTo(wself.gaCodeTF.mas_bottom);
            make.height.equalTo(wself.userNameTF.mas_height);
            }];

            [wself.lineAuthCode mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wself.authCodeTF.mas_bottom);
            make.left.equalTo(self.view).offset(padding);
            make.right.equalTo(self.view).offset(-padding);
            make.height.equalTo(@(0.5));
            }];

            [wself.imgAuthCode mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(wself.authCodeTF.mas_left).offset(-MC_REALVALUE(23));
            make.centerY.equalTo(wself.authCodeTF.mas_centerY);
            make.height.width.equalTo(@(MC_REALVALUE(25)));
            }];
            
            
        } else {
            wself.gaCodeTF.hidden = YES;
            wself.imgGaCode.hidden = YES;
            wself.lineGaCode.hidden = YES;
            [wself.authCodeTF mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(wself.userNameTF.mas_left);
                make.right.equalTo(wself.userNameTF.mas_right).offset(MC_REALVALUE(-80));
                make.top.equalTo(wself.passWordTF.mas_bottom);
                make.height.equalTo(wself.userNameTF.mas_height);
            }];
            
            [wself.lineAuthCode mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(wself.authCodeTF.mas_bottom);
                make.left.equalTo(self.view).offset(padding);
                make.right.equalTo(self.view).offset(-padding);
                make.height.equalTo(@(0.5));
            }];
            
            [wself.imgAuthCode mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(wself.authCodeTF.mas_left).offset(-MC_REALVALUE(23));
                make.centerY.equalTo(wself.authCodeTF.mas_centerY);
                make.height.width.equalTo(@(MC_REALVALUE(25)));
            }];
        }
    };
}
- (void)loginButtonClick:(UIButton *)btn{
    
    [self.view endEditing:YES];
    MCLoginModel *loginModel = [[MCLoginModel alloc]initWithUserName:self.userNameTF.text passWord:self.passWordTF.text];
    if (![self.authCodeTF.text isEqualToString:@""]) {
         loginModel.authCode = self.authCodeTF.text;
    }
    if (![self.gaCodeTF.text isEqualToString:@""]&&self.gaCodeTF.hidden == NO) {
        loginModel.GAKey = self.getGAmodel.VerificationKey;
         loginModel.GACode = self.gaCodeTF.text;
    }
    self.loginModel = loginModel;

    [loginModel refreashDataAndShow];
    __weak __typeof(self)wself = self;
    loginModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {

        [wself shakeAnimationForView:wself.baseScrollV];

    };
    loginModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        //重新登录  我的页面布局要重新请求计算
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MCRefreshMineDataUI];
        //登录密码为默认密码的用户，登录时缺少强制修改登录密码的功能。
        if ([wself.passWordTF.text isEqualToString:@"a123456"]) {
            MCForcedToChangePasswordViewController * vc = [[MCForcedToChangePasswordViewController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: vc];
            [wself presentViewController:nav animated:NO completion:nil];
            return ;
        }
        if (wself.presented == YES) {
            [wself dismissViewControllerAnimated: YES completion:nil];
        } else {

            [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[MCMainTabBarController alloc] init]];
            
        }

        MCGetMerchantInfoModel *model = [MCGetMerchantInfoModel sharedMCGetMerchantInfoModel];
        
        [model refreashDataAndShow];
        self.getMerchantInfoModel = model;
        model.callBackFailedBlock = ^(id manager, NSString *errorCode) {
            
            
        };
        
        model.callBackSuccessBlock = ^(id manager) {
            
        };
    };
 
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    self.imgName.image = [UIImage imageNamed:@"user-icon"];
    self.imgPsw.image = [UIImage imageNamed:@"lock-icon"];
    self.imgAuthCode.image = [UIImage imageNamed:@"yanz-icon"];
     self.imgGaCode.image = [UIImage imageNamed:@"G"];
    if (textField == self.userNameTF) {
        self.imgName.image = [UIImage imageNamed:@"user-sr-icon"];
    } else if(textField == self.passWordTF){
        self.imgPsw.image = [UIImage imageNamed:@"lock-sr-icon"];
    }else if(textField == self.authCodeTF){
        self.imgAuthCode.image = [UIImage imageNamed:@"yanz-sr-icon"];
    }else{
        self.imgGaCode.image = [UIImage imageNamed:@"Gz"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString  *name = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (textField == self.userNameTF&&![name isEqualToString:@""]) {
        [self loadGACode];
    }
    self.imgName.image = [UIImage imageNamed:@"user-icon"];
    self.imgPsw.image = [UIImage imageNamed:@"lock-icon"];
    self.imgAuthCode.image = [UIImage imageNamed:@"yanz-icon"];
}
- (void)shakeAnimationForView:(UIView *) view

{
    CALayer *viewLayer = view.layer;
    
    CGPoint position = viewLayer.position;
    
    CGPoint x = CGPointMake(position.x + 5, position.y);
    
    CGPoint y = CGPointMake(position.x - 5, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    [animation setAutoreverses:YES];
    
    [animation setDuration:.03];
    
    [animation setRepeatCount:4];
    
    [viewLayer addAnimation:animation forKey:nil];
    
}

@end
