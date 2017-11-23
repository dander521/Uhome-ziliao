

//
//  MCPayPasswordCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLoginPasswordCollectionViewCell.h"
#import "UIView+MCParentController.h"
#import "NSString+Helper.h"

#define HEIGHT_LINE 55

@interface MCLoginPasswordCollectionViewCell()

/*
 * 打底
 */
@property (nonatomic,strong)UIView * backView;

/*
 * 旧密码
 */
@property (nonatomic,strong)UITextField * oldPasswordTf;

/*
 * 新密码
 */
@property (nonatomic,strong)UITextField * aNewPassWordTf;

/*
 * 确认新密码
 */
@property (nonatomic,strong)UITextField * affirmNewPasswordTf;


/*
 * 确定
 */
@property (nonatomic,strong)UIButton * confirmBtn;
@end

@implementation MCLoginPasswordCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    _lab_title.text =dataSource;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    
    /*
     * 打底
     */
    _backView=[[UIView alloc]init];
    [self addSubview:_backView];
    _backView.backgroundColor=[UIColor whiteColor];
    _backView.layer.cornerRadius=5;
    _backView.clipsToBounds=YES;
    _backView.layer.borderColor = RGB(200, 200, 200).CGColor;
    _backView.layer.borderWidth = 0.5;
    _backView.frame=CGRectMake(10, 30, G_SCREENWIDTH-20, 165);
    
    
    
    /*
     * 旧密码
     */
    _oldPasswordTf = [[UITextField alloc] init];
    [self setTextField:_oldPasswordTf WithPlaceholder:@"请输入旧登录密码" and:UIKeyboardTypeDefault];
    [_oldPasswordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(0);
        make.left.equalTo(_backView.mas_left).offset(0);
        make.right.equalTo(_backView.mas_right).offset(0);
        make.height.mas_equalTo(HEIGHT_LINE);
    }];
    
   
    
    
    UIView *line1=[[UIView alloc]init];
    [_backView addSubview:line1];
    line1.backgroundColor=RGB(200, 200, 200);
    line1.frame=CGRectMake(0, HEIGHT_LINE, G_SCREENWIDTH, 0.5);
    
    
    
    /*
     * 新资金密码
     */
    _aNewPassWordTf=[[UITextField alloc] init];
    [self setTextField:_aNewPassWordTf WithPlaceholder:@"请输入新登录密码" and:UIKeyboardTypeDefault];
    
    [_aNewPassWordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.left.equalTo(_backView.mas_left).offset(0);
        make.right.equalTo(_backView.mas_right).offset(0);
        make.height.mas_equalTo(HEIGHT_LINE);
    }];
    
    UIView * line2=[[UIView alloc]init];
    [_backView addSubview:line2];
    line2.backgroundColor=RGB(200, 200, 200);
    line2.frame=CGRectMake(0, HEIGHT_LINE*2, G_SCREENWIDTH, 0.5);
    
    
    /*
     * 确认新资金密码
     */
    _affirmNewPasswordTf=[[UITextField alloc] init];
    [self setTextField:_affirmNewPasswordTf WithPlaceholder:@"请确认新登录密码" and:UIKeyboardTypeDefault];
    
    [_affirmNewPasswordTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.left.equalTo(_backView.mas_left).offset(0);
        make.right.equalTo(_backView.mas_right).offset(0);
        make.height.mas_equalTo(HEIGHT_LINE);
    }];
    
    
    //添加
    _confirmBtn=[[UIButton alloc]init];
    [self setFooter:_confirmBtn];
    
    
    UILabel * lab_tip=[[UILabel alloc]init];
    lab_tip.font=[UIFont systemFontOfSize:12];
    lab_tip.textColor=RGB(177, 177, 177);
    [self addSubview:lab_tip];
    lab_tip.text=@"*6-16位字符，可以使用字母或数字";
    lab_tip.textAlignment=NSTextAlignmentCenter;
    [lab_tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
}

-(void)textFieldDidChange:(UITextField *)textField{
    if (textField.text.length>15) {
        textField.text =  [textField.text substringToIndex:16];
    }
}


-(void)setTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type{
    textField.placeholder=placeholder;
    textField.borderStyle = UITextBorderStyleNone;
    textField.backgroundColor=[UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = RGB(177, 177, 177);
    textField.textAlignment = NSTextAlignmentCenter;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = type;
    [textField setValue:RGB(177, 177, 177) forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [_backView addSubview:textField];
    
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    textField.secureTextEntry = YES;
}



/*
 * 添加
 */
-(void)action_Add{
    //    1.判断旧密码（长度，规则，是否相等）
    //    2.判断新密码是否符合规则
    //    3.判断输入的两次新密码是否相同
    //    4.判断新旧密码是否相同
    //    5.发送请求
//    1、其他两项输入正确，不输新密码，点击“确定”，应提示：新密码不能为空；
//    2、其他两项输入正确，不输确认密码，点击“确定”，应提示：确认密码不能为空；
//    3、其他两项输入正确，不输原密码，点击“确定”，应提示：原密码不能为空；
//    4、原资金密码输入错误，点击“确定”，应提示：原密码错误；
    
    if (_oldPasswordTf.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"原密码不能为空！"];
        return;
    }
    
    if (_aNewPassWordTf.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能为空！"];
        return;
    }
    
    if (_affirmNewPasswordTf.text.length<1) {
        [SVProgressHUD showErrorWithStatus:@"确认密码不能为空！"];
        return;
    }
    
    if (_oldPasswordTf.text.length<6||_oldPasswordTf.text.length>16) {
        [SVProgressHUD showErrorWithStatus:@"密码只能为6～16位字母和数字"];
        return;
    }
    
    if (_aNewPassWordTf.text.length<6||_affirmNewPasswordTf.text.length<6||_aNewPassWordTf.text.length>16||_affirmNewPasswordTf.text.length>16  ||[NSString judgePassWordLegal:_aNewPassWordTf.text] == NO ) {
        [SVProgressHUD showErrorWithStatus:@"密码只能为6～16位字母和数字"];
        return;
    }

    if (![_aNewPassWordTf.text isEqualToString:_affirmNewPasswordTf.text]) {
        [SVProgressHUD showErrorWithStatus:@"两次输入新密码不一致"];
        return;
    }
    if ([_aNewPassWordTf.text isEqualToString:_oldPasswordTf.text]) {
        [SVProgressHUD showErrorWithStatus:@"新密码不能和旧密码相同"];
        return;
    }
    if (self.block) {
        NSDictionary * dic=@{@"LogPassword":_oldPasswordTf.text,@"NewPassword":_aNewPassWordTf.text};
        self.block(dic);
    }
    
}


-(void)setFooter:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [_btn_Save setTitle:@"保存" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"Button_Determin_Right"] forState:UIControlStateNormal];
    //    [_btn_Save setBackgroundColor:RGB(80, 141, 207)];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(action_Add) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=10.0;
    btn.clipsToBounds=YES;
    
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(_backView.mas_bottom).offset(30);
        make.height.mas_equalTo(50);
    }];
}
@end

