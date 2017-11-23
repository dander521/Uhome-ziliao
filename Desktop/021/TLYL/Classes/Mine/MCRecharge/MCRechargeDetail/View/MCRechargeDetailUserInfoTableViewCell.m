//
//  MCRechargeDetailUserInfoTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/8/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeDetailUserInfoTableViewCell.h"
#import "MCPayWebViewController.h"
#import "UIView+MCParentController.h"

@interface MCRechargeDetailUserInfoTableViewCell ()
@property (nonatomic,strong)UIView * backView;
//收款人
@property (nonatomic,strong)UILabel * userLab;
//收款银行
@property (nonatomic,strong)UILabel * bankLab;

//开户银行
@property (nonatomic,strong)UILabel * kaiHuLab;

//收款卡号
@property (nonatomic,strong)UILabel * numberLab;
//充值金额
@property (nonatomic,strong)UILabel * moneyLab;

//支付宝链接
@property (nonatomic,strong)UIButton * zhiFuBaoBtn;

@property (nonatomic,assign)BOOL isHave;
@end

@implementation MCRechargeDetailUserInfoTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    _isHave=NO;
    
    
}
-(void)setLab:(UILabel *)lab andIndex:(int)index andText:(NSString *)text{
    
    UILabel * LeftLab=[[UILabel alloc]init];
    [_backView addSubview:LeftLab];
    LeftLab.text=text;
    LeftLab.textColor=RGB(102, 102, 102);
    LeftLab.font=[UIFont systemFontOfSize:14];
    [LeftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(10);
        make.top.equalTo(_backView.mas_top).offset(30*index);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(75);
    }];
    
    [_backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.backgroundColor=[UIColor clearColor];
    lab.textColor=RGB(144,8,215);
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(LeftLab.mas_right).offset(0);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.top.equalTo(LeftLab.mas_top).offset(0);
        make.bottom.equalTo(LeftLab.mas_bottom).offset(0);
    }];
    
    UIButton *copyBtn = [[UIButton alloc] init];
    copyBtn.tag=index+100;
    [copyBtn setTitle:@"复制" forState:UIControlStateNormal];
    copyBtn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [_backView addSubview:copyBtn];
    [copyBtn setTitleColor:RGB(144,8,215) forState:UIControlStateNormal];
    copyBtn.layer.borderWidth = 1.0f;
    copyBtn.layer.borderColor = RGB(144,8,215).CGColor;
    copyBtn.layer.cornerRadius = 2;
    [copyBtn addTarget:self action:@selector(BtnCopyClick:) forControlEvents:UIControlEventTouchUpInside];
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.centerY.equalTo(LeftLab.mas_centerY).offset(0);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(24);
    }];
    
    
}
-(void)setFooter:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"支付宝转账" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.backgroundColor=RGB(144,8,215);
//    [btn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"Button_Determin_Right"] forState:UIControlStateNormal];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(zhiFuBaoRecharge) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=10.0;
    btn.clipsToBounds=YES;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(50);
    }];
}
- (void)BtnCopyClick:(UIButton *)btn{
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string =@"";
    
    if (_isHave) {
        if (btn.tag==100) {
            
            string=_userLab.text;
            
        }else if (btn.tag==101){
            
            string=_bankLab.text;
            
        }else if (btn.tag==102){
            
            string=_kaiHuLab.text;
            
        }else if (btn.tag==103){
            
            string=_numberLab.text;
        }else if (btn.tag==104){
            
            string=_moneyLab.text;
        }
    }else{
        if (btn.tag==100) {
            
            string=_userLab.text;
            
        }else if (btn.tag==101){
            
            string=_bankLab.text;
            
        }else if (btn.tag==102){
            
            string=_numberLab.text;
            
        }else if (btn.tag==103){
            
            string=_moneyLab.text;
        }
    }

    [pab setString:string];
    
   
    
    if (pab == nil) {
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setDataSource:(MCRechargeModel*)dataSource{
    NSDictionary * dic=[MCRechargeDetailUserInfoTableViewCell isHaveKaiHuBank:dataSource];
    
    _backView=[[UIView alloc]init];
    [self addSubview:_backView];
    _backView.backgroundColor=[UIColor whiteColor];
    _backView.clipsToBounds=YES;
    _backView.layer.cornerRadius=5;
//    @"paybank":paybank,
//    @"kaiHubank":kaiHubank,
//    @"isHave":isHave
    if ([dic[@"isHave"] intValue]==1) {
        _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 120+30);
        _isHave=YES;
    }else{
        _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, 120);
        _isHave=NO;
    }
    
    
    UILabel * userLab =[[UILabel alloc]init];
    [self setLab:userLab andIndex:0 andText:@"收 款 人："];
    _userLab=userLab;
    
    UILabel * bankLab=[[UILabel alloc]init];
    [self setLab:bankLab andIndex:1 andText:@"收款银行："];
    _bankLab=bankLab;
    
    if ([dic[@"isHave"] intValue]==1) {
        UILabel * kaiHuLab=[[UILabel alloc]init];
        [self setLab:kaiHuLab andIndex:2 andText:@"开户银行："];
        _kaiHuLab=kaiHuLab;
    }
    int index = [dic[@"isHave"] intValue]==1?3:2;
    UILabel * numberLab =[[UILabel alloc]init];
    [self setLab:numberLab andIndex:index andText:@"收款账号："];
    _numberLab=numberLab;
    
    
    UILabel * moneyLab=[[UILabel alloc]init];
    [self setLab:moneyLab andIndex:(index+1) andText:@"充值金额："];
    _moneyLab=moneyLab;
    
    _zhiFuBaoBtn =[[UIButton alloc]init];
    [self setFooter:_zhiFuBaoBtn];
    
    
    
    _dataSource=dataSource;
    _userLab.text=_dataSource.PayBankName;
    _bankLab.text=dic[@"paybank"];
    _kaiHuLab.text=dic[@"kaiHubank"];
    _numberLab.text=_dataSource.PayBankAccount;
    _moneyLab.text=_dataSource.PayMoney;
    if ([_dataSource.BankCode isEqualToString:@"cmb"]) {
        _zhiFuBaoBtn.hidden=NO;
    }else{
        _zhiFuBaoBtn.hidden=YES;
    }
    
}

+(NSDictionary *)isHaveKaiHuBank:(MCRechargeModel*)dataSource{
    
    NSDictionary * dic;
    NSString * paybank=@"";
    NSString * kaiHubank=@"";
    NSString * isHave=@"0";
    MCRechargeModel * model=dataSource;
    NSString * payBank = model.PayBank;
    if (payBank.length<1) {
        
    }else{
        paybank=payBank;
        
        NSArray * arr=[payBank componentsSeparatedByString:@","];
        if (arr.count<2) {
            paybank=arr[0];
        }else{
            paybank=arr[0];
            NSString * kaihu=arr[1];
            if (kaihu.length>0) {
                isHave =@"1";
                kaiHubank=kaihu;
            }
        }
    }
    dic=@{
          @"paybank":paybank,
          @"kaiHubank":kaiHubank,
          @"isHave":isHave
          };
    return dic;
}
+(CGFloat)computeHeight:(id)info{
    /*
     * 开户行的显示规则是这样的：在 add_recharge_info 这个接口中，会返回 PayBank 这个字段，这个字段可能有3种情况，一种为空（针对在线充值类），一种只包含“收款银行”，一种同时包含了“收款银行”和“开户银行”。
     举例如下： PayBank:"工商银行,安徽阜阳"，逗号前为收款银行，逗号后为开户银行。
     程序中逻辑为：①判断是否有逗号，有则用逗号分隔，无则直接赋值为“收款银行”；②有逗号，则分隔后取下标为0的作为“收款银行”；③下标为1的判断是否有值，有则显示到“开户银行”，无则不显示。（因为有的时候会返回“工商银行, ”这样的字段）
     */
    CGFloat H=120+10;
    MCRechargeModel * model=info;
    NSString * payBank = model.PayBank;
    if (payBank.length<1) {
        
    }else{
        
        NSArray * arr=[payBank componentsSeparatedByString:@","];
        if (arr.count<2) {
            
        }else{
            NSString * kaihu=arr[1];
            if (kaihu.length>0) {
                H=H+30;
            }
        }
    }
    
    
    //招商银行  提供单独的支付宝支付
    if ([model.BankCode isEqualToString:@"cmb"]) {
        return H+70;
    }
    
    return H;
}

-(void)zhiFuBaoRecharge{
    MCPayWebViewController * vc = [[MCPayWebViewController alloc]init];
    
    vc.url=@"https://shenghuo.alipay.com/send/payment/fill.htm";
    [[UIView MCcurrentViewController].navigationController pushViewController:vc animated:YES];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
