//
//  MCBindingPhoneViewController.m
//  TLYL
//
//  Created by MC on 2017/9/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBindingPhoneViewController.h"
#import "NSString+Helper.h"
#import "MCModifyUserInfoModel.h"
#import "MCMineInfoModel.h"
#import "MCContractMgtTool.h"

@interface MCBindingPhoneViewController ()

@property (nonatomic,strong) UITextField *phoneTf;

@property (nonatomic,strong)MCModifyUserInfoModel * modifyUserInfoModel;

@end

@implementation MCBindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"绑定手机";
    
    
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
    
    _phoneTf=[[UITextField alloc]init];
    [self setTitle:@"绑定手机" andTextField:_phoneTf WithPlaceholder:@"请填写您的手机号码" and:UIKeyboardTypeNumberPad andIndex:0 andBackView:backView];
    
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
    if (_phoneTf.text.length>0) {
        if (![_phoneTf.text isValidateMobile]) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号！"];
            return;
        }
    }else{
        [SVProgressHUD showErrorWithStatus:@"手机号码为空！"];
        return;
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
   
        phone=_phoneTf.text;
    
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


-(void)textFieldDidChange:(UITextField*)tf{
//11位电话号码
    if (tf.text.length>10) {
        tf.text =  [tf.text substringToIndex:11];
    }
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
