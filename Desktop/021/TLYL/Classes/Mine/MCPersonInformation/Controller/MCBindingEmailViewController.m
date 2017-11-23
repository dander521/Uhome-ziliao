//
//  MCBindingEmailViewController.m
//  TLYL
//
//  Created by MC on 2017/9/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBindingEmailViewController.h"
#import "MCMineInfoModel.h"
#import "MCModifyUserInfoModel.h"
#import "MCContractMgtTool.h"

@interface MCBindingEmailViewController ()

@property (nonatomic,strong) UITextField * tf;

@property (nonatomic,strong) MCModifyUserInfoModel * modifyUserInfoModel;

@end

@implementation MCBindingEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"电子邮箱";
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [self.view  addGestureRecognizer:singleTapGesture];
    
    [self setNav];
    
    UIView * backView = [[UIView alloc]init];
    [self.view addSubview:backView];
    backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 50);
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.cornerRadius=6;
    backView.clipsToBounds=YES;
    
    _tf =[[UITextField alloc]init];
    [self setTitle:@"邮箱账户" andTextField:_tf WithPlaceholder:@"请输入邮箱账户" and:UIKeyboardTypeEmailAddress andIndex:0 andBackView:backView];
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
    if (_tf.text.length>0) {
        if (![self isValidateEmail:_tf.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的邮箱！"];
                            return;
            
        }
    }else{
//        [SVProgressHUD showErrorWithStatus:@"邮箱为空！"];
//        return;
    }
    if (![MCContractMgtTool GetNetworkStatus]) {
        [SVProgressHUD showInfoWithStatus:@"网络异常！"];
        return;
    }
    
    NSString *email = @"";
    NSString *phone = @"";
    
    MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    
    
    
    if(mineInfoModel.EMail.length>0){
        email=mineInfoModel.EMail;
    }
    
    if(mineInfoModel.Mobile.length>0){
        phone= mineInfoModel.Mobile;
    }
    
    email=_tf.text;
    
    MCModifyUserInfoModel * modifyUserInfoModel=[[MCModifyUserInfoModel alloc]init];
    self.modifyUserInfoModel=modifyUserInfoModel;
    
    modifyUserInfoModel.MobilePhone=phone;
    modifyUserInfoModel.EMail=email;
    [BKIndicationView showInView:self.view];
    [modifyUserInfoModel refreashDataAndShow];
    
    
    
    
    modifyUserInfoModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
    };
    
    modifyUserInfoModel.callBackSuccessBlock = ^(ApiBaseManager * manager) {
        if (manager.responseMessage) {
            NSLog(@"%@-----manager",manager.responseMessage);
            [SVProgressHUD showSuccessWithStatus:manager.responseMessage];
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    
    
}
//利用正则表达式验证
- (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


-(void)textFieldDidChange:(UITextField*)tf{
    
    
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
