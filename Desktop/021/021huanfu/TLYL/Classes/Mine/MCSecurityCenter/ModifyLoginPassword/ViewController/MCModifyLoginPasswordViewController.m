//
//  MCModifyLoginPasswordViewController.m
//  TLYL
//
//  Created by MC on 2017/9/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyLoginPasswordViewController.h"
#import "NSString+Helper.h"
#import "MCMineInfoModel.h"
#import "MCPasswordAPIModel.h"
#import "MCHasPayPwdModel.h"
#import "MCGetMerchantInfoModel.h"
#import "MCLoginViewController.h"
#import "MCUserDefinedLotteryCategoriesViewController.h"

@interface MCModifyLoginPasswordViewController ()

@property (nonatomic,strong) UITextField *oldPassWordTf;
@property (nonatomic,strong) UITextField *aNewPasswordTf;
@property (nonatomic,strong) UITextField *affirmNewPasswordTf;

@property (nonatomic,strong)MCPasswordAPIModel * apiModel;
@property (nonatomic,strong)MCHasPayPwdModel *hasPayPwdModel;

@end

@implementation MCModifyLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"修改登录密码";
    
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [self.view  addGestureRecognizer:singleTapGesture];
    
    
    [self setNav];
    
    UIView * backView = [[UIView alloc]init];
    [self.view addSubview:backView];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.cornerRadius=10;
    backView.clipsToBounds=YES;
    
    _oldPassWordTf=[[UITextField alloc]init];
    _aNewPasswordTf=[[UITextField alloc]init];
    _affirmNewPasswordTf=[[UITextField alloc]init];

    backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 150);
    
    [self setTitle:@"旧密码" andTextField:_oldPassWordTf WithPlaceholder:@"请输入旧密码" and:UIKeyboardTypeDefault andIndex:0 andBackView:backView];
    
    [self setTitle:@"设置密码" andTextField:_aNewPasswordTf WithPlaceholder:@"包含0~9、a~z的6-18位密码" and:UIKeyboardTypeDefault andIndex:1 andBackView:backView];
    
    [self setTitle:@"重复输入" andTextField:_affirmNewPasswordTf WithPlaceholder:@"请再输入一遍" and:UIKeyboardTypeDefault andIndex:2 andBackView:backView];
        
   
    
}

- (void)closeKeyboard{
    [self.view endEditing:YES];
}




-(void)setTitle:(NSString *)title andTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type andIndex:(int)index andBackView:(UIView *)backView{
    
    CGFloat padding=50;
    
    UILabel * lab=[[UILabel alloc]init];
    [backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.text=title;
    lab.textColor=RGB(46,46,46);
    lab.frame=CGRectMake(10, index*padding, 80, padding);
    
    [backView addSubview:textField];
    textField.frame=CGRectMake(90, index*padding, G_SCREENWIDTH-20-100, padding);
    textField.placeholder=placeholder;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor=[UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = RGB(40, 40, 40);
    textField.textAlignment = NSTextAlignmentLeft;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = type;
    [textField setValue:RGB(181, 181, 181) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    textField.secureTextEntry = YES;
    
    
    if (index<2) {
        UIView * line=[[UIView alloc]init];
        line.backgroundColor=RGB(213,213,213);
        line.frame=CGRectMake(10, padding*(index+1), G_SCREENWIDTH-20-10, 0.5);
        [backView addSubview:line];
    }
}

#pragma mark ====================设置导航栏========================
-(void)setNav{
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 20);
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //    [rightBtn setImage:[UIImage imageNamed:@"MCUserDefined_Sure"] forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    UIBarButtonItem *rewardItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -7;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rewardItem];
    
}

-(void)rightBtnAction{
    
    //        LogPassword	是	String	旧密码
    //        NewPassword	是	String	新密码
    
    if (_oldPassWordTf.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"原密码不能为空！"];
        return;
    }
    
    if (_aNewPasswordTf.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空！"];
        return;
    }
    
    if (_affirmNewPasswordTf.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"确认密码不能为空！"];
        return;
    }
    
    if (_oldPassWordTf.text.length<6||_oldPassWordTf.text.length>18) {
        [SVProgressHUD showErrorWithStatus:@"密码只能为6～18位字母和数字"];
        return;
    }
    
    if (_aNewPasswordTf.text.length<6||_affirmNewPasswordTf.text.length<6||_aNewPasswordTf.text.length>18||_affirmNewPasswordTf.text.length>18  ||[NSString judgePassWordLegal:_aNewPasswordTf.text] == NO ) {
        [SVProgressHUD showErrorWithStatus:@"密码只能为6～18位字母和数字"];
        return;
    }
    
    if (![_aNewPasswordTf.text isEqualToString:_affirmNewPasswordTf.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入新密码不一致"];
        return;
    }
    if ([_aNewPasswordTf.text isEqualToString:_oldPassWordTf.text]) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能和旧密码相同"];
        return;
    }
    
    
    __weak __typeof__ (self) wself = self;
    
    NSLog(@"修改登录密码");
    MCPasswordAPIModel * apiModel=[[MCPasswordAPIModel alloc]initWithType:ModifyLoginPwd];
    apiModel.LogPassword=_oldPassWordTf.text;
    apiModel.NewPassword=_aNewPasswordTf.text;
    self.apiModel=apiModel;
    [BKIndicationView showInView:self.view];
    [apiModel refreashDataAndShow];
    
    apiModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
        
    };
    
    apiModel.callBackSuccessBlock = ^(id manager) {
        
        [wself successModifyLoginPwd];
    };
    
}
-(void)successModifyLoginPwd{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSLog(@"点击了确定按钮--%@-%@", [weakAlert.textFields.firstObject text], [weakAlert.textFields.lastObject text]);
        
        [[NSUserDefaults standardUserDefaults] setObject:@"logout" forKey:@"logout"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Token"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
        [[MCGetMerchantInfoModel sharedMCGetMerchantInfoModel] clearData];
        [MCUserDefinedLotteryCategoriesViewController clearUserDefinedCZ];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:MCRefreshMineDataUI];
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[MCLoginViewController alloc] init]];
        
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)textFieldDidChange:(UITextField*)tf{
    //11位电话号码
    if (tf.text.length>17) {
        tf.text =  [tf.text substringToIndex:18];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 谓词条件限制
/**
 pattern中,输入需要验证的通过的字符
 小写a-z
 大写A-Z
 汉字\u4E00-\u9FA5
 数字\u0030-\u0039
 @param str 要过滤的字符
 @return YES 只允许输入字母和汉字
 */
- (BOOL)isInputRuleAndNumber:(NSString *)str {
    NSString *pattern = @"[a-zA-Z\u4E00-\u9FA5\\u0030-\\u0039]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
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


