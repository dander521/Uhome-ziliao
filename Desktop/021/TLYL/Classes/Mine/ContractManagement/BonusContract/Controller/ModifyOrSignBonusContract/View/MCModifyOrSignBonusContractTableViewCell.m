//
//  MCModifyOrSignBonusContractTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyOrSignBonusContractTableViewCell.h"
#import "MCContractMgtTool.h"
#import "MCContractContentModelsData.h"

@interface MCModifyOrSignBonusContractTableViewCell()
//消费额：                            活跃人数：
//亏损额：                            分红比例：
@property (nonatomic,strong)UITextField * BetMoneyTf;
@property (nonatomic,strong)UITextField * LossMoneyTf;
@property (nonatomic,strong)UITextField * ActivePersonNumTf;
@property (nonatomic,strong)UITextField * DividendRatioTf;

@end

@implementation MCModifyOrSignBonusContractTableViewCell
#pragma mark View creation & layout

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        [self createUI];
    }
    return self;
}


-(void)createUI{
    
    self.backgroundColor=[UIColor clearColor];

    
    UIView * back = [[UIView alloc]init];
    back.frame=CGRectMake(0, 0, G_SCREENWIDTH-26, 75);
    back.layer.cornerRadius = 5;
    back.clipsToBounds=YES;
    [self addSubview:back];
    back.backgroundColor=[UIColor whiteColor];
    
    
    CGFloat lab_H = 15 , L_lab_W = 70 ,R_lab_W = 70 ,lab_T = 13 ,R_appading = 30;

    if (G_SCREENWIDTH<370) {
        L_lab_W = 60;
        R_appading = 10;
    }
    //消费额:
    UILabel * BetMoney = [self GetAdaptiveLable:CGRectMake(0, lab_T, L_lab_W, lab_H) AndText:@"消费额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentRight];
    [back addSubview:BetMoney];
    
    _BetMoneyTf = [self GetTfWithkeyboardType:UIKeyboardTypeNumberPad];
    [back addSubview:_BetMoneyTf];
    [_BetMoneyTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(BetMoney.mas_centerY);
        make.left.equalTo(BetMoney.mas_right).offset(0);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    

    //亏损额:
    UILabel *LossMoneyMin = [self GetAdaptiveLable:CGRectMake(0, 41, L_lab_W, lab_H) AndText:@"亏损额：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentRight];
    [back addSubview:LossMoneyMin];
    _LossMoneyTf = [self GetTfWithkeyboardType:UIKeyboardTypeNumberPad];
    [back addSubview:_LossMoneyTf];
    [_LossMoneyTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(LossMoneyMin.mas_centerY);
        make.left.equalTo(LossMoneyMin.mas_right).offset(0);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    
    //活跃人数:
    UILabel *ActivePersonNum = [self GetAdaptiveLable:CGRectMake(G_SCREENWIDTH-26-R_appading-76-R_lab_W, lab_T, R_lab_W, lab_H) AndText:@"活跃人数：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentRight];
    [back addSubview:ActivePersonNum];
    _ActivePersonNumTf = [self GetTfWithkeyboardType:UIKeyboardTypeNumberPad];
    [back addSubview:_ActivePersonNumTf];
    [_ActivePersonNumTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ActivePersonNum.mas_centerY);
        make.left.equalTo(ActivePersonNum.mas_right).offset(0);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    
    //分红比例:
    UILabel *DividendRatio = [self GetAdaptiveLable:CGRectMake(G_SCREENWIDTH-26-R_appading-76-R_lab_W, 41, R_lab_W, lab_H) AndText:@"分红比例：" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentRight];
    [back addSubview:DividendRatio];
    _DividendRatioTf = [self GetTfWithkeyboardType:UIKeyboardTypeDecimalPad];
    [back addSubview:_DividendRatioTf];
    [_DividendRatioTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(DividendRatio.mas_centerY);
        make.left.equalTo(DividendRatio.mas_right).offset(0);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(20);
    }];
    UILabel * percent = [self GetAdaptiveLable:CGRectMake(76-15, 0, 15, 20) AndText:@"%" andFont:12 andTextColor:RGB(249,84,83) andTextAlignment:NSTextAlignmentLeft];
    [_DividendRatioTf addSubview:percent];
    
    
    
}


-(void)setDataSource:(MCGetMyAndSubSignBounsContractDetailDataModel *)dataSource{
    
    _dataSource=dataSource;
    
    _BetMoneyTf.text = dataSource.BetMoneyMin;
    _LossMoneyTf.text = dataSource.LossMoneyMin;
    _ActivePersonNumTf.text = dataSource.ActivePersonNum;
    NSString * DividendRatio = [MCContractMgtTool getNPercentNumber:dataSource.DividendRatio];
    _DividendRatioTf.text = DividendRatio;
   
}

-(void)setRow:(NSInteger)row{
    _row=row;
}

+(CGFloat)computeHeight:(id)info{
    return 75+10;
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andFont:(CGFloat)font  andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment;
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.text = contentStr;
    contentLbl.textAlignment = textAlignment;
    contentLbl.font = [UIFont systemFontOfSize:font];
    contentLbl.textColor=textColor;
    contentLbl.clipsToBounds=YES;
    
    return contentLbl;
}

-(UITextField *)GetTfWithkeyboardType:(UIKeyboardType)keyboardType{
    
    UITextField * textField=[[UITextField alloc]init];
    textField.layer.cornerRadius=3;
    textField.clipsToBounds=YES;
    textField.layer.borderWidth=0.5f;
    textField.layer.borderColor=RGB(181,181,181).CGColor;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = keyboardType;//UIKeyboardTypeDecimalPad
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    textField.font=[UIFont systemFontOfSize:12];
    textField.textColor=RGB(249,84,83);
    [textField setValue:[UIFont systemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    textField.inputAccessoryView = [self addToolbar];
    return textField;
    
}
- (UIToolbar *)addToolbar{
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, G_SCREENWIDTH, 35)];
    toolbar.tintColor = RGB(144,8,215);
    toolbar.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}

-(void)textFieldDone{
    
    [_BetMoneyTf resignFirstResponder];
    [_LossMoneyTf resignFirstResponder];
    [_ActivePersonNumTf resignFirstResponder];
    [_DividendRatioTf resignFirstResponder];

}

-(void)textFieldDidChange:(UITextField *)textField{

    MCContractContentModelsData * data = [MCContractContentModelsData sharedMCContractContentModelsData];
    
//    DividendRatio    是    Number    分红比例（传参时需要在界面基础上除以100，例如5%，则传0.05）
//    BetMoneyMin    是    Number    最小消费额
//    BetMoneyMax    是    Number    最大消费额（如未填值，则默认为 999999999）
//    LossMoneyMin    是    Number    最小亏损额
//    LossMoneyMax    是    Number    最大亏损额（如未填值，则默认为 999999999）
//    ActivePersonNum    是    Number    活跃人数
    
    
    if (textField.text.length>1) {
        if ([[textField.text substringToIndex:1] isEqualToString:@"0"]) {
            if ([textField.text containsString:@"."]) {
                
            }else{
                textField.text=[textField.text substringFromIndex:1];
                NSLog(@"-----%@-----%@",[textField.text substringToIndex:1],[textField.text substringFromIndex:1]);
            }
        }
    }
    
    //消费额：
    if (textField == _BetMoneyTf) {
        if ([textField.text doubleValue]>999999999) {
            textField.text=@"999999999";
        }
        
    //亏损额
    }else if (textField == _LossMoneyTf){
        if ([textField.text doubleValue]>999999999) {
            textField.text=@"999999999";
        }
        
    //活跃人数：
    }else if (textField == _ActivePersonNumTf){
       
        
    //分红比例：
    }else if (textField == _DividendRatioTf){
        
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
        
        float max = [textField.text floatValue];
        if (max>= 100) {
            max = 100;
            textField.text = @"100";
        }
    }
    
    /*
     * 更新数据
     */
    int i = 0;
    for (MCGetMyAndSubSignBounsContractDetailDataModel * model in data.dataSource) {
        if (i == _row) {
            
            model.BetMoneyMin = _BetMoneyTf.text;
            model.LossMoneyMin = _LossMoneyTf.text;
            model.ActivePersonNum = _ActivePersonNumTf.text;
            model.DividendRatio = [MCContractMgtTool getDecimalsNumber:_DividendRatioTf.text];
            
        }
        i++;
    }
}


@end







































