//
//  MCQiPaiTeamReportTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiTeamReportTableViewCell.h"
#import "MCDataTool.h"

@interface MCQiPaiTeamReportTableViewCell ()

@property (nonatomic,strong)UIImageView * logoImgV;
@property (nonatomic,strong)UILabel * timeLab;

//投注金额：20000.00       中奖金额：20000.00
//房      费：20000.00    对战盈亏：20000.00
//电子盈亏：1956～0.0      查看战队：战队

//投注金额：20000.00
@property (nonatomic,strong)UILabel * tzMoneyLabel;
//房      费：20000.00
@property (nonatomic,strong)UILabel * homeMoney;
//电子盈亏：1956～0.
@property (nonatomic,strong)UILabel * dianZiYinKuiMoney;


//中奖金额：20000.00
@property (nonatomic,strong)UILabel * zhongJiangMoney;
//对战盈亏：20000.00
@property (nonatomic,strong)UILabel * duiZhanMoney;
//查看战队：战队
@property (nonatomic,strong)UILabel * lookZhanDuiLab;


@end

@implementation MCQiPaiTeamReportTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    CGFloat font =12;
    if (G_SCREENWIDTH<370) {
        font=10;
    }
    
    UIView * back=[[UIView alloc]init];
    [self addSubview:back];
    back.backgroundColor=[UIColor whiteColor];
    back.frame=CGRectMake(13, 0, G_SCREENWIDTH-26, 175);
    back.layer.cornerRadius=6;
    back.clipsToBounds=YES;
    
    /*
     * logo
     */
    _logoImgV=[[UIImageView alloc]init];
    _logoImgV.backgroundColor=[UIColor whiteColor];
    [back addSubview:_logoImgV];
    _logoImgV.layer.cornerRadius=11;
    _logoImgV.clipsToBounds=YES;
    _logoImgV.image=[UIImage imageNamed:@"report_hjicon"];
    _logoImgV.frame=CGRectMake(22, 16, 22, 22);
    
    /*
     * 时间
     */
    _timeLab =[[UILabel alloc]init];
    _timeLab.textColor=RGB(46,46,46);
    _timeLab.font=[UIFont systemFontOfSize:font];
    _timeLab.text =@"合计";
    _timeLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_timeLab];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_logoImgV.mas_centerY).offset(0);
        make.left.equalTo(_logoImgV.mas_right).offset(7);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
        
    }];
    
    
    
    
    UIView * centerView=[[UIView alloc]init];
    [self addSubview:centerView];
    centerView.backgroundColor=RGB(246,243,248);
    centerView.frame=CGRectMake(33, 49, G_SCREENWIDTH-60, 110);
    centerView.layer.cornerRadius=5;
    centerView.clipsToBounds=YES;
    
    CGFloat H = 30;
    CGFloat L = 60;
    if (G_SCREENWIDTH<370) {
        L=50;
    }
    CGFloat W = (G_SCREENWIDTH-60)/2.0-22-L;
    //投注金额：20000.00
    UILabel * tzMoney=[self GetAdaptiveLable:CGRectMake(22, 10, L, H) AndText:@"投注金额:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:tzMoney];
    UILabel * tzMoneyLabel=[self GetAdaptiveLable:CGRectMake(22+L, 10, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:tzMoneyLabel];
    _tzMoneyLabel=tzMoneyLabel;
    
    
    
    //房      费：20000.00
    UILabel * home=[self GetAdaptiveLable:CGRectMake(22, 10+H, L, H) AndText:@"房      费:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:home];
    UILabel * homeMoney=[self GetAdaptiveLable:CGRectMake(22+L, 10+H, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:homeMoney];
    _homeMoney=homeMoney;
    
    //电子盈亏：1956～0.
    UILabel * dianZiYinKui=[self GetAdaptiveLable:CGRectMake(22, 10+H*2, L, H) AndText:@"电子盈亏:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:dianZiYinKui];
    UILabel * dianZiYinKuiMoney=[self GetAdaptiveLable:CGRectMake(22+L, 10+H*2, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:dianZiYinKuiMoney];
    _dianZiYinKuiMoney=dianZiYinKuiMoney;
    
    
    
    
    
    //中奖金额：20000.00
    UILabel * zhongJiang=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0, 10, L, H) AndText:@"中奖金额:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:zhongJiang];
    UILabel * zhongJiangMoney=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0+L, 10, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(249,84,83) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:zhongJiangMoney];
    _zhongJiangMoney=zhongJiangMoney;
    
    //对战盈亏：20000.00
    UILabel * duiZhan=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0, 10+H, L, H) AndText:@"对战盈亏:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:duiZhan];
    UILabel * duiZhanMoney=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0+L, 10+H, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:duiZhanMoney];
    _duiZhanMoney=duiZhanMoney;
    
//    //查看战队：战队
//    UILabel * lookZhanDui=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0, 10+H*2, L, H) AndText:@"查看战队:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
//    [centerView addSubview:lookZhanDui];
//    UILabel * lookZhanDuiLab=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0+L, 10+H*2, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(144,8,215) andTextAlignment:NSTextAlignmentLeft];
//    [centerView addSubview:lookZhanDuiLab];
//    _lookZhanDuiLab=lookZhanDuiLab;
    
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


+(CGFloat)computeHeight:(id)info{
    
    return 175+10;
}

-(void)setDataSource:(MCQiPaiTeamReportDataModel *)dataSource{
    
    if (!dataSource) {
        return;
    }
    
    //投注金额：20000.00
    _tzMoneyLabel.text=dataSource.GamePay;
    //房      费：20000.00
    _homeMoney.text=dataSource.RoomFee;
    //电子盈亏：1956～0.
    _dianZiYinKuiMoney.text=dataSource.SystemIncome;
    
    
    //中奖金额：20000.00
    _zhongJiangMoney.text=dataSource.GameGet;
    //对战盈亏：20000.00
    _duiZhanMoney.text=dataSource.PlayIncome;
//    //查看战队：战队
//    _lookZhanDuiLab.text=@"战队";
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



















