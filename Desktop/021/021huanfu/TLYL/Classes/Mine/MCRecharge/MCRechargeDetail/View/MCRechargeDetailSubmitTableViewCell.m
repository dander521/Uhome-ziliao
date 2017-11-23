//
//  MCRechargeDetailSubmitTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/8/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeDetailSubmitTableViewCell.h"

#define HEIGHT_LINE  48

@interface MCRechargeDetailSubmitTableViewCell ()

@property (nonatomic,strong)UILabel *titleLab;
/*
 * 打底
 */
@property (nonatomic,strong)UIView * backView;

@property (nonatomic,strong)UIView      * lineView1;
@property (nonatomic,strong)UIView      * lineView2;


@end

@implementation MCRechargeDetailSubmitTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(144,8,215);
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.text =@"完成转账后，请填写下面的打款信息并提交";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.right.equalTo(self);
    }];
    
    
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
    _backView.frame=CGRectMake(10, 30, G_SCREENWIDTH-20, 144);
    
    
    
    
    /*
     * 名字
     */
     _userNameTextField = [[UITextField alloc] init];
    [self setTextField:_userNameTextField WithPlaceholder:@"输入真实姓名(持卡人姓名)" and:UIKeyboardTypeDefault andIndex:0];

    
    _lineView1=[[UIView alloc]init];
    [_backView addSubview:_lineView1];
    _lineView1.backgroundColor=RGB(200, 200, 200);
    _lineView1.frame=CGRectMake(0, HEIGHT_LINE, G_SCREENWIDTH, 0.5);
    
    
    
    /*
     * 金额
     */
    _moneyTextField=[[UITextField alloc] init];
    _moneyTextField.tag=1002;
    [self setTextField:_moneyTextField WithPlaceholder:@"输入转账金额(与转账金额需一致，否则影响上分)" and:UIKeyboardTypeDecimalPad andIndex:1];

    _lineView2=[[UIView alloc]init];
    [_backView addSubview:_lineView2];
    _lineView2.backgroundColor=RGB(200, 200, 200);
    _lineView2.frame=CGRectMake(0, HEIGHT_LINE*2, G_SCREENWIDTH, 0.5);
    
    
    /*
     * 时间
     */
    _timeTextField=[[UITextField alloc] init];
    _timeTextField.tag=1003;
    [self setTextField:_timeTextField WithPlaceholder:@"输入转账时间(例如：20点12分请填写2012)" and:UIKeyboardTypeNumberPad andIndex:2];
    
    
    _submitBtn=[[UIButton alloc]init];
    [_submitBtn setTitle:@"已转账，提交平台审核" forState:UIControlStateNormal];
    [self addSubview:_submitBtn];
    _submitBtn.backgroundColor=RGB(144,8,215);
    _submitBtn.titleLabel.textColor=[UIColor whiteColor];
    [_submitBtn addTarget:self action:@selector(submitToMC) forControlEvents:UIControlEventTouchUpInside];
  
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(44);
    }];
    
}
    
    
-(void)submitToMC{
    if (self.block) {
        self.block();
    }
}

-(void)setTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type andIndex:(int)index {
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
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backView.mas_top).offset(HEIGHT_LINE*index);
        make.left.equalTo(_backView.mas_left).offset(10);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.height.mas_equalTo(HEIGHT_LINE);
    }];
    
}


-(void)relayOutConstraints{
    
    
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    
}

-(void)textFieldDidChange:(UITextField *)textfield{
    //姓名
    if (textfield.tag==1001) {
        
    //金额
    }else if (textfield.tag==1002){
        
        
    //时间
    }else if (textfield.tag==1003){
        
    }
}

+(CGFloat)computeHeight:(id)info{
    
    return 30+144+44+10;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

