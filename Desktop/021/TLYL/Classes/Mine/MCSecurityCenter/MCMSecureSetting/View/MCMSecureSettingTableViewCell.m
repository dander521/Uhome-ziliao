//
//  MCMSecureSettingTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMSecureSettingTableViewCell.h"
#import "MCSecurityPickView.h"
#import "MCSecurityAllQuestionModel.h"


@interface MCMSecureSettingTableViewCell ()
<
UITextFieldDelegate
>

@property (nonatomic,assign)NSInteger t;
@property (nonatomic,strong)MCSecurityAllQuestionModel * securityAllQuestionModel;

@end

@implementation MCMSecureSettingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    _question1Btn=[[QuestionBtn alloc]init];
    _answer1Tf=[[UITextField alloc]init];
    [self setQTitle:@"问题一" andQuestionBtn:_question1Btn andATitle:@"答案" andAnswerTf:_answer1Tf WithAPlaceholder:@"请输入答案" andAType:UIKeyboardTypeDefault andIndex:0];
    
    _question2Btn=[[QuestionBtn alloc]init];
    _answer2Tf=[[UITextField alloc]init];
    [self setQTitle:@"问题二" andQuestionBtn:_question2Btn  andATitle:@"答案" andAnswerTf:_answer2Tf WithAPlaceholder:@"请输入答案" andAType:UIKeyboardTypeDefault andIndex:1];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Notification_SelectionQuestion:) name:@"Notification_SelectionQuestion" object:nil];
    
    
    UIButton * resetBtn = [[UIButton alloc]init];
    [self addSubview:resetBtn];
//    _resetBtn=resetBtn;
    resetBtn.backgroundColor=RGB(255,168,0);
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resetBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    resetBtn.layer.cornerRadius=6;
    resetBtn.clipsToBounds=YES;
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_answer2Tf.mas_bottom).offset(30);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo((G_SCREENWIDTH-20)/2.0-10);
        make.height.mas_equalTo(40);
    }];
    [resetBtn addTarget:self action:@selector(reset) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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
        make.top.equalTo(_answer2Tf.mas_bottom).offset(30);
        make.right.equalTo(self.mas_right).offset(-10);
        make.width.mas_equalTo((G_SCREENWIDTH-20)/2.0-10);
        make.height.mas_equalTo(40);
    }];
    [finishBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   
}

-(void)finish{
    if (self.block) {
        self.block();
    }
}
-(void)reset{
    
    [_question1Btn setTitle:@"请选择问题" forState:UIControlStateNormal];
    [_question2Btn setTitle:@"请选择问题" forState:UIControlStateNormal];
    _answer1Tf.text=@"";
    _answer2Tf.text=@"";
    if (self.ResetBlock) {
        self.ResetBlock();
    }
}
-(void)setQTitle:(NSString *)Qtitle andQuestionBtn:(UIButton*)questionBtn andATitle:(NSString *)Atitle andAnswerTf:(UITextField*)answerTf WithAPlaceholder:(NSString *)answer_placeholder andAType:(UIKeyboardType)Atype andIndex:(int)index{
    
    UIView * backView = [[UIView alloc]init];
    [self addSubview:backView];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.cornerRadius=6;
    backView.clipsToBounds=YES;
    
    backView.frame=CGRectMake(10, 20+(100+10)*index, G_SCREENWIDTH-20, 100);

    /*
     * 箭头
     */
    UIImageView * imgV_arrow1=[[UIImageView alloc]init];
    [backView addSubview:imgV_arrow1];
    imgV_arrow1.image=[UIImage imageNamed:@"person-icon-more"];
    imgV_arrow1.frame=CGRectMake(G_SCREENWIDTH-20-17-9,(50-16)/2.0,9,16);
    
    UIView * line=[[UIView alloc]init];
    line.backgroundColor=RGB(213,213,213);
    line.frame=CGRectMake(20, 50, G_SCREENWIDTH-20-20, 1);
    [backView addSubview:line];
    
    [self setTf:nil andPlaceholder:nil andType:Atype andTitle:Qtitle andBackView:backView andIndex:0];
    questionBtn.frame=CGRectMake(90, 0, G_SCREENWIDTH-20-100, 50);
    [backView addSubview:questionBtn];
    [questionBtn setTitleColor:RGB(46,46,46) forState:UIControlStateNormal];
    [questionBtn setTitle:@"请选择问题" forState:UIControlStateNormal];
    questionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    questionBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    questionBtn.tag=6000+index;
    [questionBtn addTarget:self action:@selector(selectedQuestion:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setTf:answerTf andPlaceholder:answer_placeholder andType:Atype andTitle:Atitle andBackView:backView andIndex:1];
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
//    NSMutableArray * marr=[[NSMutableArray alloc]initWithArray:@[_question1Btn.titleLabel.text,_question2Btn.titleLabel.text,_question3Btn.titleLabel.text] ];
    NSMutableArray * marr=[[NSMutableArray alloc]initWithArray:@[_question1Btn.titleLabel.text,_question2Btn.titleLabel.text] ];

    [marr removeObjectAtIndex:_t];
    picker.hadSelectedQuestionArray = marr;
    [picker show];
}

-(void)setTf:(UITextField *)textField andPlaceholder:(NSString*)placeholder andType:(UIKeyboardType)type andTitle:(NSString *)title andBackView:(UIView *)backView andIndex:(int)index{
    
    CGFloat padding=50;
    
    UILabel * lab=[[UILabel alloc]init];
    [backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.text=title;
    lab.textColor=RGB(46,46,46);
    lab.frame=CGRectMake(20, index*padding, 80, padding);

    if (textField) {
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
//        textField.secureTextEntry = YES;
        [backView addSubview:textField];
    }
    
}

#pragma mark - gesture actions
- (void)closeWTT:(UITapGestureRecognizer *)recognizer {
  
    [self endEditing:YES];

}

-(void)setDataSource:(NSArray<MCSecurityQuestionModel *> *)dataSource{
    _dataSource=dataSource;
}

+(CGFloat)computeHeight:(id)info{
    return 40+110*2 + 180;
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
    }else if (_t==1){
        [_question2Btn setTitle:model.Question forState:UIControlStateNormal];
        _question2Btn.model=model;
    }
}


@end
















