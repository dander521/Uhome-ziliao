//
//  MCMineTableviewCell.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineTableviewCell.h"
#import "MCMineInfoModel.h"

#define HEIGHTCELL  55 

@interface MCMineTableviewCell ()

@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) UIButton * qipaibaobiao;
@property (nonatomic,strong) UIButton * contract;
@property (nonatomic,strong) UIView  *line_daiLiGuanLi;
@property (nonatomic,strong) UIView  *line_contract;

@property (nonatomic,strong)UILabel * sub_title_lab;
@end

@implementation MCMineTableviewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    
    self.backgroundColor=[UIColor  clearColor];

    _backView=[[UIView alloc]init];
    [self addSubview:_backView];
    _backView.backgroundColor=[UIColor whiteColor];
    _backView.layer.masksToBounds = YES;
    _backView.layer.cornerRadius = 6.0;
    _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, HEIGHTCELL*7);

    UIButton * btn1=[[UIButton alloc]init];
    [_backView addSubview:btn1];
    btn1.tag=2001;
    btn1.frame=CGRectMake(0, 0, G_SCREENWIDTH-20, HEIGHTCELL);
    [self setCellWithImgV:@"person-icon-capital" andMineTitle:@"资金明细" andSubTitle:@"充值记录、提款记录、转账记录" andHaveLine:YES andBsaeBtn:btn1];
    [btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn2=[[UIButton alloc]init];
    [_backView addSubview:btn2];
    btn2.frame=CGRectMake(0, HEIGHTCELL, G_SCREENWIDTH-20, HEIGHTCELL);
    btn2.tag=2002;
    [self setCellWithImgV:@"person-icon-record" andMineTitle:@"我的报表" andSubTitle:@"近期个人报表" andHaveLine:YES andBsaeBtn:btn2];
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * btn3=[[UIButton alloc]init];
    [_backView addSubview:btn3];
    btn3.tag=2003;
    btn3.frame=CGRectMake(0, HEIGHTCELL*2, G_SCREENWIDTH-20, HEIGHTCELL);
    [self setCellWithImgV:@"person-icon-discount" andMineTitle:@"优惠活动" andSubTitle:@"最新返利活动，不容错过" andHaveLine:YES andBsaeBtn:btn3];
    [btn3 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * btn4=[[UIButton alloc]init];
    [_backView addSubview:btn4];
    btn4.tag=2004;
    btn4.frame=CGRectMake(0, HEIGHTCELL*3, G_SCREENWIDTH-20, HEIGHTCELL);
    [self setCellWithImgV:@"person-icon-kaihu" andMineTitle:@"精准开户" andSubTitle:@"代理开户、链接开户" andHaveLine:YES andBsaeBtn:btn4];
    [btn4 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

    UIButton * btn5=[[UIButton alloc]init];
    [_backView addSubview:btn5];
    btn5.tag=2005;
    btn5.frame=CGRectMake(0, HEIGHTCELL*4, G_SCREENWIDTH-20, HEIGHTCELL);
    [self setCellWithImgV:@"person-icon-manage" andMineTitle:@"代理管理" andSubTitle:@"团队管理、团队报表" andHaveLine:YES andBsaeBtn:btn5];
    [btn5 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * btn6=[[UIButton alloc]init];
    btn6.tag=2006;
    [_backView addSubview:btn6];
    btn6.frame=CGRectMake(0, HEIGHTCELL*5, G_SCREENWIDTH-20, HEIGHTCELL);
    [self setCellWithImgV:@"person-icon-contract" andMineTitle:@"契约管理" andSubTitle:@"查看契约内容" andHaveLine:YES andBsaeBtn:btn6];
    [btn6 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    _contract=btn6;
   
    
    UIButton * btn7=[[UIButton alloc]init];
    btn7.tag=2007;
    [_backView addSubview:btn7];
    btn7.frame=CGRectMake(0, HEIGHTCELL*6, G_SCREENWIDTH-20, HEIGHTCELL);
    [self setCellWithImgV:@"person-icon-qipaibaobiao" andMineTitle:@"棋牌报表" andSubTitle:@"棋牌个人报表、棋牌团队报表" andHaveLine:NO andBsaeBtn:btn7];
    [btn7 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    _qipaibaobiao=btn7;
   
}

-(void)clickBtn:(UIButton*)btn{
    NSString *type=@"";
    if (btn.tag==2001) {
        type=@"资金明细";
    }else if (btn.tag==2002){
        type=@"我的报表";
    }else if (btn.tag==2003){
        type=@"优惠活动";
    }else if (btn.tag==2004){
        type=@"精准开户";
    }else if (btn.tag==2005){
        type=@"代理管理";
    }else if (btn.tag==2006){
        type=@"契约管理";
    }else if (btn.tag==2007){
        type=@"棋牌报表";
    }
    
    if ([self.delegate respondsToSelector:@selector(cellDidSelectWithType:)]) {
        [self.delegate cellDidSelectWithType:type];
    }
}

-(void)setCellWithImgV:(NSString*)logo andMineTitle:(NSString*)minetitle andSubTitle:(NSString *)subTitle andHaveLine:(BOOL)haveLine  andBsaeBtn:(UIButton*)btn{
    
    UIImageView * imgV=[[UIImageView alloc]init];
    [btn addSubview:imgV];
    imgV.image=[UIImage imageNamed:logo];
    imgV.userInteractionEnabled=NO;
    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn.mas_left).offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(btn.mas_centerY);
    }];
    
    
    UILabel *maintitleLab= [UILabel new];
    maintitleLab.layer.masksToBounds = YES;
    maintitleLab.textColor=RGB(46, 46, 46);
    maintitleLab.font = [UIFont systemFontOfSize:12];
    maintitleLab.numberOfLines=1;
    maintitleLab.text = minetitle;
    maintitleLab.textAlignment=NSTextAlignmentLeft;
    [btn addSubview:maintitleLab];
    [maintitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_top).offset(10);
        make.left.equalTo(imgV.mas_right).offset(10);
        make.width.mas_equalTo(G_SCREENWIDTH-50);
    }];
    
    
    UILabel *subtitleLab= [UILabel new];
    subtitleLab.layer.masksToBounds = YES;
    subtitleLab.textColor=RGB(153, 153, 153);
    subtitleLab.font = [UIFont systemFontOfSize:12];
    subtitleLab.numberOfLines=1;
    subtitleLab.text = subTitle;
    subtitleLab.textAlignment=NSTextAlignmentLeft;
    [btn addSubview:subtitleLab];
    [subtitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maintitleLab.mas_bottom).offset(5);
        make.left.equalTo(maintitleLab.mas_left).offset(0);
        make.width.mas_equalTo(G_SCREENWIDTH-50);
    }];
    if ([subTitle containsString:@"充值记录、提款记录"]) {
        _sub_title_lab =subtitleLab;
    }
    
    UIImageView * arrow=[[UIImageView alloc]init];
    [btn addSubview:arrow];
    arrow.image=[UIImage imageNamed:@"person-icon-more"];
    arrow.userInteractionEnabled=NO;
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_right).offset(-10);
        make.width.mas_equalTo(9);
        make.height.mas_equalTo(16);
        make.centerY.equalTo(btn.mas_centerY);
    }];
    
    
    /*
     * 画线
     */
    
    if (haveLine==YES) {
        UIView *lineView=[[UIView alloc]init];
        lineView.backgroundColor=RGB(200, 200, 200);
        [btn addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(maintitleLab.mas_left).offset(0);
            make.right.equalTo(btn.mas_right).offset(0);
            make.height.mas_equalTo(0.5);
            make.bottom.equalTo(btn.mas_bottom);
        }];
        if ([minetitle isEqualToString:@"代理管理"]) {
            _line_daiLiGuanLi=lineView;
        }else if ([minetitle isEqualToString:@"契约管理"]){
            _line_contract=lineView;
        }
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}
+(CGFloat)computeHeight:(id)info{
    //Mode从商户信息的接口获取，UserType从用户详情获取（0代表正式账户，1代表试玩账户）
    int Mode = (int)[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode];
    MCMineInfoModel *mineInfoModel =[MCMineInfoModel sharedMCMineInfoModel];

    int H = 7;
    
    if (((Mode & 32) != 32) || ([mineInfoModel.UserType intValue] ==1) ) {
        //隐藏转账和棋牌项
        H = 6;
    }else{
        //显示转账和棋牌项
        
    }
    if ((mineInfoModel.IsDividend==NO)&&(mineInfoModel.IsDayWages==NO)) {
        H=H-1;
    }
    
//    IsDividend    Boolean    是否签约分红
//    IsDayWages    Boolean    是否签约日工资
    
    return HEIGHTCELL*H+20;
}



-(void)refreashCellListUI{
    BOOL isHaveQiPai=YES,isHaveContract=YES;
    int Mode = (int)[[NSUserDefaults standardUserDefaults] objectForKey:MerchantMode];
    MCMineInfoModel *mineInfoModel =[MCMineInfoModel sharedMCMineInfoModel];
    if (((Mode & 32) != 32) || ([mineInfoModel.UserType intValue] ==1) ) {
        //隐藏转账和棋牌项
        isHaveQiPai=NO;
        _sub_title_lab.text=@"充值记录、提款记录";
    }else{
        //显示转账和棋牌项
        _sub_title_lab.text=@"充值记录、提款记录、转账记录";
    }
    if ((mineInfoModel.IsDividend==NO)&&(mineInfoModel.IsDayWages==NO)) {
        isHaveContract=NO;
    }
    if (isHaveContract==NO&&isHaveQiPai==NO) {
        _line_daiLiGuanLi.hidden=YES;
        _contract.hidden=YES;
        _qipaibaobiao.hidden=YES;
        _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, HEIGHTCELL*5);

    }else if (isHaveContract==YES&&isHaveQiPai==NO){
        _line_daiLiGuanLi.hidden=NO;
        _line_contract.hidden=YES;
        _contract.hidden=NO;
        _qipaibaobiao.hidden=YES;
        _contract.frame=CGRectMake(0, HEIGHTCELL*5, G_SCREENWIDTH-20, HEIGHTCELL);
        _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, HEIGHTCELL*6);

    }else if (isHaveContract==NO&&isHaveQiPai==YES){
        _line_daiLiGuanLi.hidden=NO;
        _contract.hidden=YES;
        _qipaibaobiao.hidden=NO;
        _qipaibaobiao.frame=CGRectMake(0, HEIGHTCELL*5, G_SCREENWIDTH-20, HEIGHTCELL);
        _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, HEIGHTCELL*6);

    }else{
        _line_daiLiGuanLi.hidden=NO;
        _line_contract.hidden=NO;
        _contract.hidden=NO;
        _qipaibaobiao.hidden=NO;
        _contract.frame=CGRectMake(0, HEIGHTCELL*5, G_SCREENWIDTH-20, HEIGHTCELL);
        _qipaibaobiao.frame=CGRectMake(0, HEIGHTCELL*6, G_SCREENWIDTH-20, HEIGHTCELL);
        _backView.frame=CGRectMake(10, 10, G_SCREENWIDTH-20, HEIGHTCELL*7);

    }

}

@end







































