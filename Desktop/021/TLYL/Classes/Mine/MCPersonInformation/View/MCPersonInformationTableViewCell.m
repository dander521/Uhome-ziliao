//
//  MCPersonInformationTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPersonInformationTableViewCell.h"
#import "MCMineInfoModel.h"

@interface MCPersonInformationTableViewCell ()

/*
 * 用户名
 */
@property (nonatomic,strong)UIButton * userNameBtn;
/*
 * 用户昵称
 */
@property (nonatomic,strong)UIButton * nickNameBtn;
/*
 * 真实姓名
 */
@property (nonatomic,strong)UIButton * realNameBtn;

/*
 * 手机号
 */
@property (nonatomic,strong)UIButton * phoneBtn;
/*
 * 邮箱
 */
@property (nonatomic,strong)UIButton * emailBtn;

/*
 * 用户返点
 */
@property (nonatomic,strong)UITextField * MyRebateTf;

@end

@implementation MCPersonInformationTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    
    

}


-(void)loadUI{
    MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];

    /*
     * 打底
     */
    UIView *backView=[[UIView alloc]init];
    [self addSubview:backView];
    backView.backgroundColor=[UIColor whiteColor];
    backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 300);
    backView.layer.cornerRadius=10;
    backView.clipsToBounds=YES;
    
    /*
     * 用户名
     */
    _userNameBtn = [[UIButton alloc] init];
    [self setTitle:@"用户名称" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:0 andBackView:backView andMCButton:_userNameBtn andBtnTitle:@"未设置" andArrow:NO];
    [_userNameBtn setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"] forState:UIControlStateNormal];
    _userNameBtn.userInteractionEnabled=NO;
    _userNameBtn.tag=1001;
    
    /*
     * 用户昵称
     */
    _nickNameBtn = [[UIButton alloc] init];
    _nickNameBtn.tag=1002;
    if (mineInfoModel.UserNickName.length>0) {
        [self setTitle:@"用户昵称" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:1 andBackView:backView andMCButton:_nickNameBtn andBtnTitle:mineInfoModel.UserNickName andArrow:YES];
//        _nickNameBtn.userInteractionEnabled=NO;
    }else{
        [self setTitle:@"用户昵称" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:1 andBackView:backView andMCButton:_nickNameBtn andBtnTitle:@"未设置" andArrow:YES];
    }
    
    /*
     * 真实姓名
     */
    _realNameBtn = [[UIButton alloc] init];
    _realNameBtn.userInteractionEnabled=NO;
    _realNameBtn.tag=1003;
    [self setTitle:@"真实姓名" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:2 andBackView:backView andMCButton:_realNameBtn andBtnTitle:@"添加银行卡时完善" andArrow:NO];
    if (mineInfoModel.UserRealName.length>0) {
        [_realNameBtn setTitle:[NSString stringWithFormat:@"%@**",[mineInfoModel.UserRealName substringToIndex:1]] forState:UIControlStateNormal];
    }
    
    
    /*
     * 手机号
     */
    _phoneBtn = [[UIButton alloc] init];
    _phoneBtn.tag=1004;
    NSString * phone=@"";
    if (mineInfoModel.Mobile.length>0) {
        if (mineInfoModel.Mobile.length>5) {
            phone=[NSString stringWithFormat:@"%@****%@",[mineInfoModel.Mobile substringToIndex:3],[mineInfoModel.Mobile substringFromIndex:(mineInfoModel.Mobile.length-2)]];
        }else{
            phone=mineInfoModel.Mobile;
        }
        [self setTitle:@"绑定手机" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:3 andBackView:backView andMCButton:_phoneBtn andBtnTitle:phone andArrow:NO];
        _phoneBtn.userInteractionEnabled=NO;
    }else{
        [self setTitle:@"绑定手机" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:3 andBackView:backView andMCButton:_phoneBtn andBtnTitle:@"未设置" andArrow:YES];
    }

    
    /*
     * 邮箱
     */
    _emailBtn=[[UIButton alloc] init];
    _emailBtn.tag=1005;
    if (mineInfoModel.EMail.length>0) {
        NSString * email=@"";
        if([mineInfoModel.EMail rangeOfString:@"@"].location !=NSNotFound){
            NSArray * arr=[mineInfoModel.EMail componentsSeparatedByString:@"@"];
            if ([arr[0] length]>3) {
                email=[NSString stringWithFormat:@"%@****@%@",[arr[0] substringToIndex:3],arr[1]];
            }else if([arr[0] length]==3){
                email=[NSString stringWithFormat:@"%@****@%@",[arr[0] substringToIndex:2],arr[1]];
            }else if([arr[0] length]==2){
                email=[NSString stringWithFormat:@"%@****@%@",[arr[0] substringToIndex:1],arr[1]];
            }else if([arr[0] length]==1){
                email=[NSString stringWithFormat:@"****@%@",arr[1]];
            }
            
        }else{
            email=mineInfoModel.EMail;
        }
        
        [self setTitle:@"绑定邮箱" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:4 andBackView:backView andMCButton:_emailBtn andBtnTitle:email andArrow:NO];
        _emailBtn.userInteractionEnabled=NO;
    }else{
        [self setTitle:@"绑定邮箱" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:4 andBackView:backView andMCButton:_emailBtn andBtnTitle:@"未设置" andArrow:YES];
    }
    
    _MyRebateTf=[[UITextField alloc]init];
    [self setTitle:@"用户返点" andTextField:_MyRebateTf WithPlaceholder:@"" and:UIKeyboardTypeDefault andIndex:5 andBackView:backView andMCButton:nil andBtnTitle:@"加载中..." andArrow:NO];
    NSNumber *min_Rebate = [[NSUserDefaults standardUserDefaults] objectForKey:MerchantMinRebate];
    NSString * str = [NSString stringWithFormat:@"%@~%.1f",mineInfoModel.MyRebate,([mineInfoModel.MyRebate intValue]-[min_Rebate integerValue])/20.0];
    _MyRebateTf.text=str;
    _MyRebateTf.userInteractionEnabled=NO;
}
-(void)setTitle:(NSString *)title andTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type andIndex:(int)index andBackView:(UIView *)backView andMCButton:(UIButton *)btn1  andBtnTitle:(NSString *)btnTitle andArrow:(BOOL)isHave{
    
    CGFloat padding=50;
    
    UILabel * lab=[[UILabel alloc]init];
    [backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.text=title;
    lab.textColor=RGB(46,46,46);
    lab.frame=CGRectMake(10, index*padding, 80, padding);
    
    CGFloat R = 0;
    if (isHave) {
        UIImageView * arrow=[[UIImageView alloc]init];
        [backView addSubview:arrow];
        arrow.image=[UIImage imageNamed:@"person-icon-more"];
        arrow.userInteractionEnabled=NO;
        arrow.frame=CGRectMake(G_SCREENWIDTH-20-10-9, index*padding+(50-16)/2.0, 9, 16);
        R = 9+10;
    }else{
        R=0;
    }
    
    if (textField) {
        [backView addSubview:textField];
        textField.frame=CGRectMake(80, index*padding, G_SCREENWIDTH-20-80-10-R, padding);
        textField.placeholder=placeholder;
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor=[UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:14];
        textField.textColor = RGB(102,102,102);
        textField.textAlignment = NSTextAlignmentRight;
        textField.returnKeyType = UIReturnKeyDone;
        textField.keyboardType = type;
        [textField setValue:RGB(190, 190, 190) forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
//        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    }else if (btn1){
        
        [backView addSubview:btn1];
        [btn1 setTitle:btnTitle forState:UIControlStateNormal];
        btn1.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn1 setTitleColor:RGB(102,102,102) forState:UIControlStateNormal];
        btn1.frame=CGRectMake(80, index*padding, G_SCREENWIDTH-20-80-10-R, padding);
        btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [btn1 addTarget:self action:@selector(GoToController:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (index<5) {
        UIView * line=[[UIView alloc]init];
        line.backgroundColor=RGB(213,213,213);
        line.frame=CGRectMake(10, padding*(index+1), G_SCREENWIDTH-20-10, 0.5);
        [backView addSubview:line];
    }
}

-(void)GoToController:(UIButton *)btn{
    if (self.block) {
        self.block(btn.tag);
    }
}

-(void)relayOutConstraints{
   
    
}

-(void)setDataSource:(id)dataSource{
    
    [self loadUI];
    
    _dataSource=dataSource;

}



+(CGFloat)computeHeight:(id)info{
    
    return 50*6+10;
    
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
































