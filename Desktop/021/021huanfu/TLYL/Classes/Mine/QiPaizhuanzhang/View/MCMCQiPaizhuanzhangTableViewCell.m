//
//  MCMCQiPaizhuanzhangTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMCQiPaizhuanzhangTableViewCell.h"
#import "MCInputView.h"
#import "UIView+MCParentController.h"
#import "MCMathUnits.h"

#define UILABEL_LINE_SPACE 5
#define UILABEL_Kern_SPACE 0.1
#define Tip @"温馨提示：\n户内转账是自己的资金转入不同的平台，资金还是属于用户本人的，没有手续费和次数限制，您可以随意进行转账操作。"
@interface MCMCQiPaizhuanzhangTableViewCell ()

@property (weak, nonatomic)  UILabel     * ziJinQuXiangLab;
@property (nonatomic,strong) MCInputView * viewPop;
@property (nonatomic,strong) UIButton    * zhuanZhangBtn;



@end

@implementation MCMCQiPaizhuanzhangTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

//zhuangzhangArrow
- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    UIView * upview=[[UIView alloc]init];
    [self addSubview:upview];
    upview.backgroundColor=[UIColor whiteColor];
    upview.frame=CGRectMake(13, 0, G_SCREENWIDTH-26, 150);
    upview.layer.cornerRadius=6;
    upview.clipsToBounds=YES;
    
    CGFloat L = 80;
    
    /*
     * 资金去向
     */
    UIButton * btn =[[UIButton alloc]init];
    btn.frame=CGRectMake(L, 0, G_SCREENWIDTH-26-L, 50);
    [upview addSubview:btn];
    [btn addTarget:self action:@selector(selectedZiJinQuXiang) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * ziJinQuXiangLab=[[UILabel alloc]init];
    _ziJinQuXiangLab=ziJinQuXiangLab;
    ziJinQuXiangLab.textAlignment=NSTextAlignmentLeft;
    [btn addSubview:ziJinQuXiangLab];
    ziJinQuXiangLab.textColor=RGB(46,46,46);
    ziJinQuXiangLab.font=[UIFont systemFontOfSize:14];
    ziJinQuXiangLab.frame=CGRectMake(0, 0, G_SCREENWIDTH-26-L, 50);
    ziJinQuXiangLab.attributedText = [self selectedType:ZhuanzhangType_LottoryToQiPai];

    
    [self setTitle:@"资金去向" andTextField:nil WithPlaceholder:@"" and:UIKeyboardTypeDecimalPad andIndex:0 andBackView:upview];
    
    UITextField * moneyTextField=[[UITextField alloc]init];
    _moneyTextField=moneyTextField;
    _moneyTextField.tag=1001;
    [self setTitle:@"转账金额" andTextField:moneyTextField WithPlaceholder:@"请输入你的转账金额" and:UIKeyboardTypeDecimalPad andIndex:1 andBackView:upview];
    
    UITextField * passwordTextField=[[UITextField alloc]init];
    _passwordTextField=passwordTextField;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.tag=1002;
    [self setTitle:@"资金密码" andTextField:passwordTextField WithPlaceholder:@"请输入您的资金密码" and:UIKeyboardTypeDefault andIndex:2 andBackView:upview];
    

    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text=Tip;
    infoLabel.font=[UIFont systemFontOfSize:10];
    infoLabel.numberOfLines=0;
    infoLabel.textAlignment = NSTextAlignmentLeft;
    infoLabel.textColor = RGB(136,136,136);
    [self addSubview:infoLabel];
    CGFloat H =[self getSpaceLabelHeight:Tip withFont:[UIFont systemFontOfSize:10] withWidth:G_SCREENWIDTH-28];
    infoLabel.frame = CGRectMake(14, 180, G_SCREENWIDTH-28, H );
    [self setLabelSpace:infoLabel withValue:Tip withFont:[UIFont systemFontOfSize:10]];
    
    _zhuanZhangBtn=[[UIButton alloc]init];
    [self setFooter:_zhuanZhangBtn];
    _zhuanZhangBtn.frame=CGRectMake(10, 180+H+20, G_SCREENWIDTH-20, 40);
    
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    singleTapGesture.numberOfTapsRequired = 1;
    singleTapGesture.cancelsTouchesInView = NO;
    [self  addGestureRecognizer:singleTapGesture];
    
}

- (MCInputView *)viewPop{
    if (_viewPop == nil) {
        
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [[UIView MCcurrentViewController].navigationController.view addSubview:viewStatus];
        _viewPop = viewStatus;
    }
    return _viewPop;
}

-(void)selectedZiJinQuXiang{
    
    __weak __typeof__ (self) wself = self;
    self.viewPop.dataArray = @[@"彩票-->棋牌",@"棋牌-->彩票"];
    [self.viewPop show];
    self.viewPop.cellDidSelected = ^(NSInteger i) {
        [wself.viewPop hiden];
        if (i==0) {
            wself.ziJinQuXiangLab.attributedText=[wself selectedType:ZhuanzhangType_LottoryToQiPai];
            wself.Type=ZhuanzhangType_LottoryToQiPai;
            if (wself.sBlock) {
                wself.sBlock(ZhuanzhangType_LottoryToQiPai);
            }
            
        }else{
            wself.ziJinQuXiangLab.attributedText=[wself selectedType:ZhuanzhangType_QiPaiToLottory];
            wself.Type=ZhuanzhangType_QiPaiToLottory;
            if (wself.sBlock) {
                wself.sBlock(ZhuanzhangType_QiPaiToLottory);
            }
        }
    };

}

-(NSAttributedString *)selectedType:(Zhuanzhang_Type)Type{
    NSString * str1=@"",*str2=@"";
    if (Type==ZhuanzhangType_LottoryToQiPai) {
        str1=@"彩票 ";
        str2=@" 棋牌";
    }else if (Type==ZhuanzhangType_QiPaiToLottory){
        str1=@"棋牌 ";
        str2=@" 彩票";
    }
     NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str1];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"zhuangzhangArrow"];
    attch.bounds = CGRectMake(0, 0, 10, 7);
    // 创建带有图片的富文本
    NSAttributedString *string1 = [NSAttributedString attributedStringWithAttachment:attch];
    [attri appendAttributedString:string1];
    NSAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attri appendAttributedString:string2];
    return attri;
}

-(void)setTitle:(NSString *)title andTextField:(UITextField*)textField WithPlaceholder:(NSString *)placeholder and:(UIKeyboardType)type andIndex:(int)index andBackView:(UIView *)backView{
    
    CGFloat padding=50;
    
    UILabel * lab=[[UILabel alloc]init];
    [backView addSubview:lab];
    lab.font=[UIFont systemFontOfSize:14];
    lab.text=title;
    lab.textColor=RGB(46,46,46);
    lab.frame=CGRectMake(10, index*padding, 80, padding);
    
    if (textField) {
        [backView addSubview:textField];
        textField.frame=CGRectMake(80, index*padding, G_SCREENWIDTH-20-100, padding);
        textField.placeholder=placeholder;
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor=[UIColor clearColor];
        textField.font = [UIFont systemFontOfSize:14];
        textField.textColor = RGB(40, 40, 40);
        textField.textAlignment = NSTextAlignmentLeft;
        textField.returnKeyType = UIReturnKeyDone;
        textField.keyboardType = type;
        [textField setValue:RGB(190, 190, 190) forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    }
    
    
    if (index<2) {
        UIView * line=[[UIView alloc]init];
        line.backgroundColor=RGB(213,213,213);
        line.frame=CGRectMake(10, padding*(index+1), G_SCREENWIDTH-20-10, 0.5);
        [backView addSubview:line];
    }
    
    if (index==0) {
        UIImageView * arrow=[[UIImageView alloc]init];
        [backView addSubview:arrow];
        arrow.image=[UIImage imageNamed:@"person-icon-more"];
        arrow.userInteractionEnabled=NO;
        arrow.frame=CGRectMake(G_SCREENWIDTH-26-10-9, index*padding+(50-16)/2.0, 9, 16);
    }
}
-(void)textFieldDidChange:(UITextField *)textField{
    textField.text= [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    if (textField.tag==1001) {
        
        if (textField.text.length == 1 && [textField.text isEqualToString:@"."]) {
            textField.text = @"0.";
        }
        NSArray *arr = [textField.text componentsSeparatedByString:@"."];
        if (arr.count >1) {
            
            NSString *str = arr[1];
            if (str.length > 2) {
                str = [str substringWithRange:NSMakeRange(0, 2)];
            }
            textField.text = [NSString stringWithFormat:@"%@.%@",arr[0],str];

        }
        
        double max = [textField.text doubleValue];
        double TTT = max-_DrawMaxMoney;
        if (TTT>=0.001) {
            max = _DrawMaxMoney;
            textField.text =[self GetSNum:_DrawMaxMoney];
        }
       

    }else if(textField.tag==1002){

    }
}
//1.999->1.99
-(NSString *)GetSNum:(double)num{
    
    NSString * Snum = [NSString stringWithFormat:@"%.5f",num];
    NSArray * numArr=[Snum componentsSeparatedByString:@"."];
    if (numArr.count<2) {
        return [NSString stringWithFormat:@"%f",num];;
    }
    NSString * xiaoshu=numArr[1];
    if (xiaoshu.length<=2) {
        return [NSString stringWithFormat:@"%f",num];
    }
    xiaoshu=[xiaoshu substringToIndex:2];
    NSString *xiaoshu1=[xiaoshu substringToIndex:1];
    NSString *xiaoshu2=[xiaoshu substringFromIndex:1];
    if ([xiaoshu1 isEqualToString:@"0"]&&[xiaoshu2 isEqualToString:@"0"]) {
        return [NSString stringWithFormat:@"%@",numArr[0]];
    }
    if ([xiaoshu2 isEqualToString:@"0"]) {
        return [NSString stringWithFormat:@"%@.%@",numArr[0],xiaoshu1];
    }
    return [NSString stringWithFormat:@"%@.%@",numArr[0],xiaoshu];
}


#pragma mark - gesture actions
- (void)closeKeyboard:(UITapGestureRecognizer *)recognizer {
    [self endEditing:YES];
    [self.viewPop hiden];
}




-(void)setFooter:(UIButton *)btn{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即转账" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.backgroundColor=RGB(143, 0, 210);
    [self addSubview:btn];
    [btn addTarget:self action:@selector(goToZhuanZhang) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=5.0;
    btn.clipsToBounds=YES;
}

-(void)goToZhuanZhang{
    if (_moneyTextField.text.length<1) {
        [SVProgressHUD showInfoWithStatus:@"请输入转账金额！"];
        return;
    }
    
    float max = [_moneyTextField.text floatValue];
    if (max>_DrawMaxMoney) {
        if (_Type==ZhuanzhangType_LottoryToQiPai) {
            [SVProgressHUD showInfoWithStatus:@"彩票账户余额不足！"];
        }else if (_Type==ZhuanzhangType_QiPaiToLottory){
            [SVProgressHUD showInfoWithStatus:@"棋牌账户余额不足！"];
        }
        return;
    }

    if (_passwordTextField.text.length<1) {
        [SVProgressHUD showInfoWithStatus:@"请输入资金密码！"];
        return;
    }
    
    if (self.gBlock) {
        self.gBlock();
    }
}

+(CGFloat)computeHeight:(id)info{
    return G_SCREENHEIGHT-64-40-10;
}
//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@UILABEL_Kern_SPACE
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}


//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@UILABEL_Kern_SPACE
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
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
