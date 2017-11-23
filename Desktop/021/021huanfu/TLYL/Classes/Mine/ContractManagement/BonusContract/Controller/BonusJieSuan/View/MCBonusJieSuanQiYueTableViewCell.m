//
//  MCBonusJieSuanQiYueTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/22.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusJieSuanQiYueTableViewCell.h"
#import "MCBonusJieSuanQiYueCellView.h"
#import "MCBonusJieSuanYuLuanCellView.h"

@interface MCBonusJieSuanQiYueTableViewCell ()

@property (nonatomic,strong)UILabel *  Time;
@property (nonatomic,strong)UILabel * fenHong;
@end

@implementation MCBonusJieSuanQiYueTableViewCell
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
    
    CGFloat T1 = 37;
    
    
    
    
    _Time = [self GetAdaptiveLable:CGRectMake(0, 0, G_SCREENWIDTH-26, T1) AndText:@"本次分红周期：加载中..." andFont:12 andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_Time];
    
    
    UIView * view=[[UIView alloc]init];
    view.backgroundColor=[UIColor whiteColor];
    [self addSubview:view];
    view.layer.cornerRadius = 6;
    view.clipsToBounds=YES;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-35);
        make.top.equalTo(self.mas_top).offset(T1);
    }];
    
    _fenHong = [[UILabel alloc] init];
    _fenHong.text = @"应得分红：加载中...";
    _fenHong.textAlignment = NSTextAlignmentCenter;
    _fenHong.font = [UIFont systemFontOfSize:12];
    _fenHong.textColor=RGB(102,102,102);
    [self addSubview:_fenHong];
    [_fenHong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_offset(200);
        make.height.mas_equalTo(35);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
}

-(void)setDataSource:(MCGetDividendSettlementDataModel *)dataSource{
    _dataSource = dataSource;

    if (!dataSource) {
        return;
    }
    NSString * str = [NSString stringWithFormat:@"本次分红周期：%@",dataSource.DividendCycle];
    
    NSRange range = [str rangeOfString:dataSource.DividendCycle];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:NSMakeRange(range.location, range.length)];
    _Time.attributedText=attri;
    
    
    
    NSString * str2 = [NSString stringWithFormat:@"应得分红：%@",dataSource.GetBonusPreviewModels.DeservedDividend];
    
    NSRange range2 = [str2 rangeOfString:dataSource.GetBonusPreviewModels.DeservedDividend];
    NSMutableAttributedString *attri2 = [[NSMutableAttributedString alloc] initWithString:str2];
    // 设置数字为红色
    [attri2 addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:NSMakeRange(range2.location, range2.length)];
    _fenHong.attributedText=attri2;
    
     CGFloat T = 37 ,H=75,W=G_SCREENWIDTH-60,L = 20;
    UILabel * lab3=[self GetAdaptiveLable:CGRectMake(33, T, G_SCREENWIDTH-26, T) AndText:@"分红契约" andFont:12 andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lab3];
    
    
    NSString * str3 = [NSString stringWithFormat:@"%@的分红契约",_models.UserName];
    NSRange range3 = [str3 rangeOfString:_models.UserName];
    NSMutableAttributedString *attri3 = [[NSMutableAttributedString alloc] initWithString:str3];
    [attri3 addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:NSMakeRange(range3.location, range3.length)];
    lab3.attributedText=attri3;
    
    
    
    T=37+30;
    int i = 0;
    for (MCGetDividendContractListModel * model1 in dataSource.GetDividendContractList) {
        MCBonusJieSuanQiYueCellView * cell1 = [[MCBonusJieSuanQiYueCellView alloc]init];
        cell1.frame=CGRectMake(L, T+i*(75+10), W, H);
        [self addSubview:cell1];
        cell1.dataSouce=model1;
        i++;
    }
    
    
    UILabel * lab4=[self GetAdaptiveLable:CGRectMake(33, T+i*(75+10), G_SCREENWIDTH-26, 30) AndText:@"分红预览" andFont:12 andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lab4];
    NSString * str4 = [NSString stringWithFormat:@"%@的分红预览",_models.UserName];
    NSRange range4 = [str4 rangeOfString:_models.UserName];
    NSMutableAttributedString *attri4 = [[NSMutableAttributedString alloc] initWithString:str4];
    [attri4 addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:NSMakeRange(range4.location, range4.length)];
    lab4.attributedText=attri4;
    
    T=T+30;
    MCBonusJieSuanYuLuanCellView * cell1 = [[MCBonusJieSuanYuLuanCellView alloc]init];
    cell1.frame=CGRectMake(L, T+i*(75+10), W, H);
    [self addSubview:cell1];
    cell1.dataSouce=dataSource.GetBonusPreviewModels;
    [self addSubview:_fenHong];
    
}

+(CGFloat)computeHeight:(MCGetDividendSettlementDataModel *)info{
    return 37+(info.GetDividendContractList.count+1)*(75+10) +35  +30*2;
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

-(void)setModels:(MCMyXiaJiBonusContractListDeatailDataModel *)models{
    _models=models;
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

















