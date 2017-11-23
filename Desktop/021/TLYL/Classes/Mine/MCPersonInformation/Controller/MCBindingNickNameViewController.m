//
//  MCBindingNickNameViewController.m
//  TLYL
//
//  Created by MC on 2017/9/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBindingNickNameViewController.h"
#import "MCModifyNickNameModel.h"
#import "MCMineInfoModel.h"
#import "MCContractMgtTool.h"

@interface MCBindingNickNameViewController ()

@property (nonatomic,strong) UITextField * tf;

@property (nonatomic,strong)MCModifyNickNameModel * modifyNickNameModel;
@end

@implementation MCBindingNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=RGB(231, 231, 231);
    self.title=@"用户昵称";
    
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
    
    _tf = [[UITextField alloc]init];
    [self setTitle:@"" andTextField:_tf WithPlaceholder:@"请输入您的个性昵称" and:UIKeyboardTypeDefault andIndex:0 andBackView:backView];
    
}

- (void)closeKeyboard{
    [self.view endEditing:YES];
}
-(void)setTitle:(NSString *)title andTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type andIndex:(int)index andBackView:(UIView *)backView{
    
    CGFloat padding=50;
    
    [backView addSubview:textField];
    textField.frame=CGRectMake(10, index*padding, G_SCREENWIDTH-20, padding);
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
    if (_tf.text.length>0) {
        if (_tf.text.length>25||_tf.text.length<4) {
            [SVProgressHUD showErrorWithStatus:@"用户昵称应在4~25个字符之间！"];
            return;
        }

    }else{
        [SVProgressHUD showErrorWithStatus:@"昵称为空！"];
        return;
    }
    if (![MCContractMgtTool GetNetworkStatus]) {
        [SVProgressHUD showInfoWithStatus:@"网络异常！"];
        return;
    }

    NSString *NickName = @"";
    
    NickName=_tf.text;
    
    MCModifyNickNameModel * modifyNickNameModel=[[MCModifyNickNameModel alloc]init];
    self.modifyNickNameModel=modifyNickNameModel;
    
    modifyNickNameModel.NickName=NickName;
    [BKIndicationView showInView:self.view];
    [modifyNickNameModel refreashDataAndShow];
    
    
    
    
    modifyNickNameModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
    };
    
    modifyNickNameModel.callBackSuccessBlock = ^(ApiBaseManager * manager) {
        if (manager.responseMessage) {
            NSLog(@"%@-----manager",manager.responseMessage);
            [SVProgressHUD showSuccessWithStatus:manager.responseMessage];
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
}


-(void)textFieldDidChange:(UITextField*)tf{
    tf.text =  [tf.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (tf.text.length>25) {
        tf.text=[tf.text substringToIndex:25];
    }
//    用户昵称应在4~25个字符之间
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
