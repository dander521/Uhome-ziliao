//
//  MCDailyReportTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCDailyReportTableViewCell.h"
#import "MCDataTool.h"

@interface MCDailyReportTableViewCell ()

@property (nonatomic,strong)UIImageView * logoImgV;
@property (nonatomic,strong)UILabel * timeLab;

//充值总额：20000.00
@property (nonatomic,strong)UILabel * chongzhiMoneyLabel;
//购彩总额：20000.00
@property (nonatomic,strong)UILabel * caiGouMoney;
//自身返点：1956～0.0
@property (nonatomic,strong)UILabel * myRebate;
//其他收入：2000.00
@property (nonatomic,strong)UILabel * otherMoney;

//提款总额：20000.00
@property (nonatomic,strong)UILabel * withdrawMoney;
//奖金总额：20000.00
@property (nonatomic,strong)UILabel * jiangJinMoney;
//下级返点：1956～0.0
@property (nonatomic,strong)UILabel * xiaJiRebateMoney;
//盈利总额：200000.00
@property (nonatomic,strong)UILabel * yinLiMoney;

@end

@implementation MCDailyReportTableViewCell

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
    back.frame=CGRectMake(13, 0, G_SCREENWIDTH-26, 205);
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
    _timeLab.text =@"加载中";
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
    centerView.frame=CGRectMake(33, 49, G_SCREENWIDTH-60, 140);
    centerView.layer.cornerRadius=5;
    centerView.clipsToBounds=YES;
    
    CGFloat H = 30;
    CGFloat L = 60;
    if (G_SCREENWIDTH<370) {
        L=50;
    }
    CGFloat W = (G_SCREENWIDTH-60)/2.0-22-L;
    //充值总额：20000.00
    UILabel * chongzhiLabel=[self GetAdaptiveLable:CGRectMake(22, 10, L, H) AndText:@"充值总额:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:chongzhiLabel];
    UILabel * chongzhiMoneyLabel=[self GetAdaptiveLable:CGRectMake(22+L, 10, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:chongzhiMoneyLabel];
    _chongzhiMoneyLabel=chongzhiMoneyLabel;
    
    
    
    //购彩总额：20000.00
    UILabel * caiGou=[self GetAdaptiveLable:CGRectMake(22, 10+H, L, H) AndText:@"购彩总额:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:caiGou];
    UILabel * caiGouMoney=[self GetAdaptiveLable:CGRectMake(22+L, 10+H, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:caiGouMoney];
    _caiGouMoney=caiGouMoney;
    
    //自身返点：1956～0.0
    UILabel * mRebate=[self GetAdaptiveLable:CGRectMake(22, 10+H*2, L, H) AndText:@"自身返点:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:mRebate];
    UILabel * myRebate=[self GetAdaptiveLable:CGRectMake(22+L, 10+H*2, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:myRebate];
    _myRebate=myRebate;
    
    
    //其他收入：2000.00
    UILabel * otherM=[self GetAdaptiveLable:CGRectMake(22, 10+H*3, L, H) AndText:@"其他收入:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:otherM];
    UILabel * otherMoney=[self GetAdaptiveLable:CGRectMake(22+L, 10+H*3, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:otherMoney];
    _otherMoney=otherMoney;
    
    
    
    //提款总额：20000.00
    UILabel * withdraw=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0, 10, L, H) AndText:@"提款总额:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:withdraw];
    UILabel * withdrawMoney=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0+L, 10, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:withdrawMoney];
    _withdrawMoney=withdrawMoney;
    
    //奖金总额：20000.00
    UILabel * jiangJin=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0, 10+H, L, H) AndText:@"奖金总额:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:jiangJin];
    UILabel * jiangJinMoney=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0+L, 10+H, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:jiangJinMoney];
    _jiangJinMoney=jiangJinMoney;
    
    //下级返点：1956～0.0
    UILabel * xiaJiRebate=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0, 10+H*2, L, H) AndText:@"下级返点:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:xiaJiRebate];
    UILabel * xiaJiRebateMoney=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0+L, 10+H*2, W, H) AndText:@"加载中" andFont:12 andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:xiaJiRebateMoney];
    _xiaJiRebateMoney=xiaJiRebateMoney;
    
    
    //盈利总额：200000.00
    UILabel * yinLi=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0, 10+H*3, L, H) AndText:@"盈利总额:" andFont:font andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:yinLi];
    UILabel * yinLiMoney=[self GetAdaptiveLable:CGRectMake((G_SCREENWIDTH-60)/2.0+L, 10+H*3, W, H) AndText:@"加载中" andFont:font andTextColor:RGB(249,84,83) andTextAlignment:NSTextAlignmentLeft];
    [centerView addSubview:yinLiMoney];
    _yinLiMoney=yinLiMoney;
    
     
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
    
    return 205+10;
}

-(void)setDataSource:(MCGetMyReportlstModel *)dataSource{
    
    if (!dataSource) {
        return;
    }
    //充值总额：20000.00
    _chongzhiMoneyLabel.text=dataSource.RechargeMoney;
    //购彩总额：20000.00
    _caiGouMoney.text=dataSource.BetMoney;
    //自身返点：1956～0.0
    _myRebate.text=dataSource.SelfRebateMoney;
    //其他收入：2000.00
    _otherMoney.text=dataSource.OtherMoney;
    //提款总额：20000.00
    _withdrawMoney.text=dataSource.DrawingsMoney;
    //奖金总额：20000.00
    _jiangJinMoney.text=dataSource.WinMoney;
    //下级返点：1956～0.0
    _xiaJiRebateMoney.text=dataSource.SubRebateMoney;
    //盈利总额：200000.00
    _yinLiMoney.text=dataSource.GainMoney;
    
    _timeLab.text=dataSource.HisTime;
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


















