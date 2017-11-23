//
//  MCFindPasswordTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/24.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCFindPasswordTableViewCell.h"
#import "MCSecurityPickView.h"
#import "MCSecurityAllQuestionModel.h"

@interface MCFindPasswordTableViewCell ()
<
UITextFieldDelegate
>

@property (nonatomic,assign)NSInteger t;
@property (nonatomic,strong)MCSecurityAllQuestionModel * securityAllQuestionModel;

@end

@implementation MCFindPasswordTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    CGFloat H = 44;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Notification_SelectionQuestion:) name:@"Notification_SelectionQuestion" object:nil];
    
    UIView * view1=[[UIView alloc]init];
    [self addSubview:view1];
    view1.backgroundColor=[UIColor whiteColor];
    view1.layer.cornerRadius=3;
    view1.layer.borderWidth = 0.5f;
    view1.layer.borderColor = RGB(213,213,213).CGColor;
    view1.frame=CGRectMake(13, 18, G_SCREENWIDTH-26, H);
    
    
    _userNameTf = [[UITextField alloc]init];
    [view1 addSubview:_userNameTf];
    _userNameTf.delegate=self;
    _userNameTf.placeholder=@"请输入用户名";
    _userNameTf.borderStyle = UITextBorderStyleNone;
    _userNameTf.backgroundColor=[UIColor clearColor];
    _userNameTf.font = [UIFont systemFontOfSize:14];
    _userNameTf.textColor = RGB(40, 40, 40);
    _userNameTf.textAlignment = NSTextAlignmentLeft;
    _userNameTf.returnKeyType = UIReturnKeyDone;
    _userNameTf.keyboardType = UIKeyboardTypeDefault;
    [_userNameTf setValue:RGB(181, 181, 181) forKeyPath:@"_placeholderLabel.textColor"];
    [_userNameTf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_userNameTf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [_userNameTf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_userNameTf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_userNameTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view1.mas_centerY);
        make.left.equalTo(view1.mas_left).offset(20);
        make.right.equalTo(view1.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    
    UIView * view2=[[UIView alloc]init];
    [self addSubview:view2];
    view2.backgroundColor=[UIColor whiteColor];
    view2.layer.cornerRadius=3;
    view2.layer.borderWidth = 0.5f;
    view2.layer.borderColor = RGB(213,213,213).CGColor;
    view2.frame=CGRectMake(13, 70, G_SCREENWIDTH-26, H);
    
    
    _question1Btn=[[QuestionBtn alloc]init];
    [view2 addSubview:_question1Btn];
    [_question1Btn setTitleColor:RGB(46,46,46) forState:UIControlStateNormal];
    [_question1Btn setTitle:@"请通过密保问题找回密码" forState:UIControlStateNormal];
    _question1Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _question1Btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    _question1Btn.tag=6000;
    [_question1Btn addTarget:self action:@selector(selectedQuestion:) forControlEvents:UIControlEventTouchUpInside];
    [_question1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2.mas_centerY);
        make.left.equalTo(view2.mas_left).offset(20);
        make.right.equalTo(view2.mas_right).offset(-10);
        make.height.mas_equalTo(40);
    }];
    
    //箭头
    UIImageView * imgV_arrow1=[[UIImageView alloc]init];
    [view2 addSubview:imgV_arrow1];
    imgV_arrow1.image=[UIImage imageNamed:@"person-icon-more"];
    [imgV_arrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view2.mas_centerY);
        make.right.equalTo(view2.mas_right).offset(-13);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(9);
    }];
    
    UIView * view3=[[UIView alloc]init];
    [self addSubview:view3];
    view3.backgroundColor=[UIColor whiteColor];
    view3.layer.cornerRadius=3;
    view3.layer.borderWidth = 0.5f;
    view3.layer.borderColor = RGB(213,213,213).CGColor;
    view3.frame=CGRectMake(13, 122, G_SCREENWIDTH-26, H);
    
    _answer1Tf = [[UITextField alloc]init];
    [view3 addSubview:_answer1Tf];
    _answer1Tf.delegate=self;
    _answer1Tf.placeholder=@"请输入密保答案";
    _answer1Tf.borderStyle = UITextBorderStyleNone;
    _answer1Tf.backgroundColor=[UIColor clearColor];
    _answer1Tf.font = [UIFont systemFontOfSize:14];
    _answer1Tf.textColor = RGB(40, 40, 40);
    _answer1Tf.textAlignment = NSTextAlignmentLeft;
    _answer1Tf.returnKeyType = UIReturnKeyDone;
    _answer1Tf.keyboardType = UIKeyboardTypeDefault;
    [_answer1Tf setValue:RGB(181, 181, 181) forKeyPath:@"_placeholderLabel.textColor"];
    [_answer1Tf setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    [_answer1Tf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [_answer1Tf setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_answer1Tf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_answer1Tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view3.mas_centerY);
        make.left.equalTo(view3.mas_left).offset(20);
        make.right.equalTo(view3.mas_right).offset(-20);
        make.height.mas_equalTo(40);
    }];
    

    UIButton * finishBtn = [[UIButton alloc]init];
    [self addSubview:finishBtn];
    _finishBtn=finishBtn;
    finishBtn.backgroundColor=RGB(144,8,215);
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    finishBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    finishBtn.layer.cornerRadius=6;
    finishBtn.clipsToBounds=YES;
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(13);
        make.right.equalTo(self.mas_right).offset(-13);
        make.height.mas_equalTo(40);
    }];
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)finish{
    if (self.block) {
        self.block();
    }
}



#pragma mark-点击选择问题
-(void)selectedQuestion:(QuestionBtn *)btn{
    
    __weak __typeof__ (self) wself = self;
    
    MCSecurityAllQuestionModel * securityAllQuestionModel=[MCSecurityAllQuestionModel sharedMCSecurityAllQuestionModel];
    if (securityAllQuestionModel.dataSource.count>0) {
        self.dataSource=securityAllQuestionModel.dataSource;
        [self showPickView:btn];
    }else{
        _securityAllQuestionModel=securityAllQuestionModel;
        [securityAllQuestionModel refreashDataAndShow];
        
        securityAllQuestionModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSString *errorCode) {
            
        };
        
        securityAllQuestionModel.callBackSuccessBlock = ^(id manager) {
            NSMutableArray * marr=[[NSMutableArray alloc]init];
            for (NSDictionary * dic in manager) {
                [marr addObject:[MCSecurityQuestionModel mj_objectWithKeyValues:dic]];
            }
            wself.securityAllQuestionModel.dataSource=marr;
            wself.dataSource=marr;
            [wself showPickView:btn];
        };
        
    }
}

-(void)showPickView:(QuestionBtn *)btn{
    _t = btn.tag-6000;
    MCSecurityPickView *picker = [[MCSecurityPickView alloc]init];
    picker.dataSource =self.dataSource;
    picker.hadSelectedQuestionArray = @[];
    [picker show];
}

#pragma mark - gesture actions
- (void)closeWTT:(UITapGestureRecognizer *)recognizer {
    
    [self endEditing:YES];
    
}

-(void)setDataSource:(NSArray<MCSecurityQuestionModel *> *)dataSource{
    _dataSource=dataSource;
}

+(CGFloat)computeHeight:(id)info{
    return 250;
}

-(void)textFieldDidChange:(UITextField *)textField{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)Notification_SelectionQuestion:(NSNotification *)notification
{
    MCSecurityQuestionModel * model = notification.object;
    if (_t==0) {
        [_question1Btn setTitle:model.Question forState:UIControlStateNormal];
        _question1Btn.model=model;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)aTextfield {
     [aTextfield resignFirstResponder];//关闭键盘
    return YES;
}


@end

















