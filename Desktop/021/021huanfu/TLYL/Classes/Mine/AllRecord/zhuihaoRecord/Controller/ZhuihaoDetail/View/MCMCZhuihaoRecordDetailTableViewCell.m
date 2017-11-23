//
//  MCMCZhuihaoRecordDetailTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMCZhuihaoRecordDetailTableViewCell.h"
#import "MCDataTool.h"
#import "MCMCZhuihaoRecordSubDetailViewController.h"
#import "UIView+MCParentController.h"

@interface MCMCZhuihaoRecordDetailTableViewCell ()

@property (nonatomic,strong)UIImageView * logoImgV;
@property (nonatomic,strong)UILabel * wfNameLab;
@property (nonatomic,strong)UILabel * czNameLab;
@property (nonatomic,strong)UIButton * stopBtn;
@property (nonatomic,strong)UILabel * stateLab;

@property (nonatomic,strong)UILabel * orderLab;
@property (nonatomic,strong)UILabel * startQiHaoLab;
@property (nonatomic,strong)UILabel * stopQiHaoLab;
@property (nonatomic,strong)UILabel * contentLab;
@property (nonatomic,strong)UILabel * zijinMoShiLab;
@property (nonatomic,strong)UILabel * zhuiHaoShezhiLab;
@property (nonatomic,strong)UILabel * zhuiHaoJinELab;
@property (nonatomic,strong)UILabel * zhongjiangJinELab;


@property (nonatomic,strong)UIButton * orderCopyBtn;


@property (nonatomic,strong)UILabel *  haoDetailLabel;
@property (nonatomic,strong)UIScrollView *bgview;

@property (nonatomic,strong)UIView * downView;
@end

@implementation MCMCZhuihaoRecordDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    /*
     * logo
     */
    _logoImgV=[[UIImageView alloc]init];
    _logoImgV.backgroundColor=[UIColor clearColor];
    [self addSubview:_logoImgV];
    _logoImgV.layer.cornerRadius=30;
    _logoImgV.clipsToBounds=YES;
    _logoImgV.frame=CGRectMake(21, 29, 60, 60);
    
    _czNameLab =[[UILabel alloc]init];
    _czNameLab.textColor=RGB(46,46,46);
    _czNameLab.font=[UIFont boldSystemFontOfSize:15];
    _czNameLab.text =@"加载中";
    _czNameLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_czNameLab];
    [_czNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(45);
        make.left.equalTo(self.mas_left).offset(90);
    }];
    
    _wfNameLab=[[UILabel alloc]init];
    _wfNameLab.textColor=RGB(46,46,46);
    _wfNameLab.font=[UIFont systemFontOfSize:12];
    _wfNameLab.text =@"加载中";
    _wfNameLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_wfNameLab];
    [_wfNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(48);
        make.left.equalTo(_czNameLab.mas_right).offset(5);
    }];
    
    _stopBtn=[[UIButton alloc]init];
    [self addSubview:_stopBtn];
    _stopBtn.backgroundColor=RGB(144,8,215);
    _stopBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    _stopBtn.layer.cornerRadius=3;
    _stopBtn.clipsToBounds=YES;
    [_stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_stopBtn setTitle:@"停追" forState:UIControlStateNormal];
    [_stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(49);
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(21);
    }];
    [_stopBtn addTarget:self action:@selector(actionStop) forControlEvents:UIControlEventTouchUpInside];
    
    //正在追号
    _stateLab =[[UILabel alloc]init];
    _stateLab.textColor=RGB(255,168,0);
    _stateLab.font=[UIFont systemFontOfSize:12];
    _stateLab.text =@"加载中";
    _stateLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_stateLab];
    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(65);
        make.left.equalTo(_czNameLab.mas_left);
        make.width.mas_equalTo(100);
    }];
    
   
    _orderLab =[[UILabel alloc]init];
    [self setText1:@"订单编号：" andLab2:_orderLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:0 andL:21];
    
    _startQiHaoLab=[[UILabel alloc]init];
    [self setText1:@"开始期号：" andLab2:_startQiHaoLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:1 andL:21];
    _stopQiHaoLab=[[UILabel alloc]init];
    [self setText1:@"结束期号：" andLab2:_stopQiHaoLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:2 andL:21];
    _contentLab=[[UILabel alloc]init];
    [self setText1:@"追号状态：" andLab2:_contentLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:3 andL:21];
    _zijinMoShiLab=[[UILabel alloc]init];
    [self setText1:@"资金模式：" andLab2:_zijinMoShiLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:4 andL:21];
    _zhuiHaoShezhiLab=[[UILabel alloc]init];
    [self setText1:@"中奖停追：" andLab2:_zhuiHaoShezhiLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:4 andL:(G_SCREENWIDTH-20)/2.0];
    _zhuiHaoJinELab=[[UILabel alloc]init];
    [self setText1:@"追号金额：" andLab2:_zhuiHaoJinELab text2:@"加载中" andColor2:RGB(249,84,83) andIndex:5 andL:21];
    _zhongjiangJinELab=[[UILabel alloc]init];
    [self setText1:@"中奖金额：" andLab2:_zhongjiangJinELab text2:@"加载中" andColor2:RGB(249,84,83) andIndex:5 andL:(G_SCREENWIDTH-20)/2.0];
    

    _orderCopyBtn=[[UIButton alloc]init];
    [self addSubview:_orderCopyBtn];
    _orderCopyBtn.backgroundColor=[UIColor whiteColor];
    _orderCopyBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [_orderCopyBtn setTitleColor:RGB(255,168,0) forState:UIControlStateNormal];
    [_orderCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
    [_orderCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_orderLab.mas_centerY);
        make.centerX.equalTo(_stopBtn.mas_centerX);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(21);
    }];
    [_orderCopyBtn addTarget:self action:@selector(actionPasteboard) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIScrollView *bgview = [[UIScrollView alloc] init];
    [self addSubview:bgview];
    bgview.layer.cornerRadius = 4;
    bgview.clipsToBounds = YES;
    bgview.backgroundColor = RGB(237, 237, 237);
    self.bgview = bgview;
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(self.mas_top).offset(286);
        make.height.mas_equalTo(75);
    }];
    
    UILabel *haoDetailLabel = [[UILabel alloc] init];
    haoDetailLabel.textColor = RGB(46, 46, 46);
    haoDetailLabel.font = [UIFont systemFontOfSize:12];
    haoDetailLabel.text = @"正在加载";
    [bgview addSubview:haoDetailLabel];
    _haoDetailLabel=haoDetailLabel;
    haoDetailLabel.numberOfLines = 0;
    [haoDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(10));
//        make.right.equalTo(@(-10));
        make.width.equalTo(@(G_SCREENWIDTH-80));
        
    }];



    
}
#define UILABEL_LINE_SPACE 5
#define UILABEL_Kern_SPACE 0.1
//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UITextView*)label withValue:(NSString*)str withFont:(UIFont*)font {
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

-(void)setText1:(NSString *)text1 andLab2:(UILabel *)lab2 text2:(NSString *)text2 andColor2:(UIColor *)color2 andIndex:(int)index andL:(CGFloat )L {
    
    CGFloat H =30;
    CGFloat W_L =65;
    UILabel * lab1=[[UILabel alloc]init];
    lab1.textColor=RGB(46,46,46);
    lab1.font=[UIFont systemFontOfSize:12];
    lab1.text =text1;
    lab1.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:lab1];
    lab1.frame=CGRectMake(L, 107+index*H, W_L, 15);
    
    lab2.textColor=color2;
    lab2.font=[UIFont systemFontOfSize:12];
    lab2.text =text2;
    lab2.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:lab2];
    lab2.frame=CGRectMake(L+W_L, 107+index*H, G_SCREENWIDTH-33-W_L, 15);

}

-(void)actionPasteboard{
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = _orderLab.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
    }

}

+(CGFloat)computeHeight:(MCUserChaseRecordDetailDataModel *)dataSource{
    NSInteger line=dataSource.Bet.count;
    return 369+line*40 +20 +10;
}

#pragma mark-赋值
-(void)setDataContent:(MCUserChaseRecordDataModel *)dataContent{
    _dataContent = dataContent;
    
    if([dataContent.CountSY intValue]==0){
        _stopBtn.hidden=YES;
    }else{
        _stopBtn.hidden=NO;
    }
    
    NSString * str = [NSString stringWithFormat:@"已追 %d 期 / 总 %d 期 ",[dataContent.CountQS intValue]-[dataContent.CountSY intValue],[dataContent.CountQS intValue]];
    
    NSRange range1 = [str rangeOfString:[NSString stringWithFormat:@"追 %d",[dataContent.CountQS intValue]-[dataContent.CountSY intValue]]];
    NSRange range2 = [str rangeOfString:[NSString stringWithFormat:@"总 %d",[dataContent.CountQS intValue]]];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(255,168,0) range:NSMakeRange(range1.location+1, range1.length-1)];
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(255,168,0) range:NSMakeRange(range2.location+1, range2.length-1)];

    _contentLab.attributedText=attri;

}

-(void)setDataSource:(MCUserChaseRecordDetailDataModel *)dataSource{
    
    _dataSource=dataSource;

    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
    if (!dataSource||dataSource==nil||dataSource.LotteryCode.length<1) {
        return;
    }
    MCUserChaseRecordDetailSubDataModel * model1 =dataSource.Bet[0];
    MCUserChaseRecordDetailSubDataModel * model2 =[dataSource.Bet lastObject];
    //logo
    _logoImgV.image=[UIImage imageNamed: dic[dataSource.LotteryCode][@"logo"]];
    _orderLab.text=model1.ChaseOrderID;
    _czNameLab.text = dic[dataSource.LotteryCode][@"name"];
    _wfNameLab.text=[MCLotteryID  getLotteryFullNameByPlayCode:model1.PlayCode andLotteryCode:dataSource.LotteryCode andBetMode:[model1.BetMode intValue]];
    _startQiHaoLab.text=model1.IssueNumber;
    _stopQiHaoLab.text=model2.IssueNumber;
//    _contentLab.text=[NSString stringWithFormat:@"已追 %d 期 / 总 %d 期 ",model1.];


    int BetMode =[model1.BetMode intValue];
    if (( BetMode& 32)==32) {
        _zijinMoShiLab.text= @"元";
    } else if ((BetMode & 64)==64) {
        _zijinMoShiLab.text= @"角";
    } else if ((BetMode & 128)==128) {
        _zijinMoShiLab.text= @"分";
    } else if ((BetMode & 256)==256){
        _zijinMoShiLab.text= @"厘";
    }
    
    
    if ((BetMode & 2) == 2) {
        _zhuiHaoShezhiLab.text= @"是";
    } else if ((BetMode & 4) == 4) {
        _zhuiHaoShezhiLab.text= @"否";
    } else {
        _zhuiHaoShezhiLab.text= @"---";
    }
    
    _zhuiHaoJinELab.text=GetRealSNum(dataSource.SumBetMoney);
    
    _zhongjiangJinELab.text=GetRealSNum(model1.AwMoney);
    
    CGRect subviewRect1 = [model1.BetContent boundingRectWithSize:CGSizeMake(G_SCREENWIDTH-80, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];

    if (subviewRect1.size.height > 75) {
        self.bgview.contentSize = CGSizeMake(G_SCREENWIDTH-80, subviewRect1.size.height + 20);
    }else{
        self.bgview.contentSize = CGSizeMake(G_SCREENWIDTH-80, 75+10);
    }
    self.haoDetailLabel.text = model1.BetContent;
    
    
    _downView=[[UIView alloc]init];
    [self addSubview:_downView];
    _downView.frame=CGRectMake(20, 369, G_SCREENWIDTH-20*2-10*2, 40*dataSource.Bet.count+20);
    _downView.backgroundColor=RGB(251,251,251);
    _downView.layer.cornerRadius=3;
    _downView.clipsToBounds=YES;
    
    
//    GetRealSNum
    _stateLab.text=[self getBetOrderState:model1.BetOrderState];
    int i=0;
    for (MCUserChaseRecordDetailSubDataModel *bb in _dataSource.Bet) {
        [self createBtnWith:bb andIndex:i];
        i++;
    }
    
    
    
}

-(NSString *)getBetOrderState:(NSString *)SBetOrderState{
    int BetOrderState =[SBetOrderState intValue];
    if ((BetOrderState & 1) == 1) {
        return  @"购买成功";
    } else if ((BetOrderState & 32768) == 32768) {
        return  @"已撤奖";
    } else if ((BetOrderState & 64) == 64) {
        return  @"已出票";
    } else if ((BetOrderState & 16777216) == 16777216) {
        return  @"已派奖";
    } else if ((BetOrderState & 33554432) == 33554432) {
        return  @"未中奖";
    } else if ((BetOrderState & 4096) == 4096) {
        return  @"已结算";
    } else if ((BetOrderState & 512) == 512) {
        return  @"强制结算";
    } else if ((BetOrderState & 4) == 4) {
        return  @"已撤单";
    } else {
        return  @"订单异常";
    }
}

#pragma mark-actionStop
-(void)actionStop{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

-(void)createBtnWith:(MCUserChaseRecordDetailSubDataModel *)model andIndex:(int)index{
    
    UIButton * btn =[[UIButton alloc]init];
    [_downView addSubview:btn];
    btn.frame=CGRectMake(0, 0+40*index, G_SCREENWIDTH-20-40, 40);

    UILabel * qiHao=[self createLab:12 Text:[NSString stringWithFormat:@"%@期",model.IssueNumber] textAlignment:NSTextAlignmentLeft color:RGB(136,136,136)];
    [btn  addSubview:qiHao];
    
    [qiHao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn.mas_left).offset(8);
        make.top.equalTo(btn.mas_top).offset(16);
        make.height.mas_equalTo(20);
        make.width.mas_offset(110);
    }];
    
    
    UILabel * money=[self createLab:12 Text:GetRealSNum(model.BetMoney) textAlignment:NSTextAlignmentCenter color:RGB(249,84,83)];
    [btn  addSubview:money];
    
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(qiHao.mas_centerY);
        make.centerX.equalTo(btn.mas_centerX);
        make.height.mas_equalTo(20);
        make.width.mas_offset(150);
        
//        make.left.equalTo(btn.mas_left).offset(120);

    }];
    

    UILabel * state=[self createLab:12 Text:[self getBetOrderState:model.BetOrderState] textAlignment:NSTextAlignmentRight color:RGB(136,136,136)];
    [btn  addSubview:state];
    
    [state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(qiHao.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_offset(110);
        make.right.equalTo(btn.mas_right).offset(-45);
    }];
    
   
    
    
    UIView *bgview=[[UIView alloc]init];
    bgview.backgroundColor=RGB(229, 229, 229);
    [btn addSubview:bgview];
    bgview.layer.cornerRadius=8;
    bgview.clipsToBounds=YES;
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn.mas_right).offset(-10);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.centerY.equalTo(qiHao.mas_centerY);
    }];
    
    UIImageView * arrow=[[UIImageView alloc]init];
    [bgview addSubview:arrow];
    arrow.image=[UIImage imageNamed:@"jiantou_icon"];
    arrow.userInteractionEnabled=NO;
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(9);
        make.width.mas_equalTo(5);
        make.centerX.equalTo(bgview.mas_centerX);
        make.centerY.equalTo(bgview.mas_centerY);
    }];

    btn.tag=1000+index;
    [btn addTarget:self action:@selector(goToDetail:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark-跳转追号详情二级页面
-(void)goToDetail:(UIButton *)btn{
//    MCMCZhuihaoRecordSubDetailViewController * vc=[[MCMCZhuihaoRecordSubDetailViewController alloc]init];
    
    MCUserChaseRecordDetailSubDataModel * model =_dataSource.Bet[btn.tag-1000];
//    vc.dataSource=model;
//    vc.Amodel=_dataSource;
//    [[UIView MCcurrentViewController].navigationController pushViewController:vc animated:YES];
    
    if (self.goToBlock) {
        self.goToBlock(model, _dataSource);
    }
    
    
}

-(UILabel *)createLab:(CGFloat)font Text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment color:(UIColor*)color{
    UILabel * lab1=[[UILabel alloc]init];
    lab1.textColor=color;
    lab1.font=[UIFont systemFontOfSize:font];
    lab1.text =text;
    lab1.textAlignment=textAlignment;
    return lab1;
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


















