//
//  MCMCZhuihaoRecordSubDetailUITableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMCZhuihaoRecordSubDetailUITableViewCell.h"
#import "MCDataTool.h"
#import "MCMCZhuihaoRecordSubDetailViewController.h"
#import "MCCollectionViewFlowLayout.h"
#import "MCMCZhuihaoRecordSubDetailCollectionViewCell.h"
#import "UIView+MCParentController.h"
#import "MCUserDefinedLotteryCategoriesModel.h"
#import "MCPickNumberViewController.h"

@interface MCMCZhuihaoRecordSubDetailUITableViewCell ()
<
UICollectionViewDelegate,
UICollectionViewDataSource
>
@property (nonatomic,strong)UIImageView *backImgV;
@property (nonatomic,strong)UIImageView * logoImgV;
@property (nonatomic,strong)UILabel * qiHaoLab;
@property (nonatomic,strong)UILabel * wfNameLab;
@property (nonatomic,strong)UILabel * czNameLab;
@property (nonatomic,strong)UILabel * stateLab;

@property (nonatomic,strong)UILabel * orderLab;
@property (nonatomic,strong)UILabel * liuShuiOrderLab;

@property (nonatomic,strong)UILabel * timeLab;
@property (nonatomic,strong)UILabel * contentLab;
@property (nonatomic,strong)UILabel * zijinMoShiLab;
@property (nonatomic,strong)UILabel * touzhuJinELab;
@property (nonatomic,strong)UILabel * kaiJiangTimeELab;
@property (nonatomic,strong)UILabel * kaiJianghaomaLab;
@property (nonatomic,strong)UILabel * zhongjiangZhuShuLab;
@property (nonatomic,strong)UILabel * zhongjiangJinELab;

@property (nonatomic,strong)UIButton * orderCopyBtn1;
@property (nonatomic,strong)UIButton * orderCopyBtn2;

@property (nonatomic,strong)UILabel *  haoDetailLabel;
@property (nonatomic,strong)UIScrollView *bgview;

@property(nonatomic,strong)UICollectionView * firstCollectionView;
@property(nonatomic,strong)NSMutableArray * collectionMarry;
@property (nonatomic,strong)UIView * downView;

@property (nonatomic,assign)int ballCount;
@property (nonatomic,assign)int lineCount;
@end

@implementation MCMCZhuihaoRecordSubDetailUITableViewCell
//第一个开奖期号
-(UICollectionView *)firstCollectionView{
    if (!_firstCollectionView) {
        
        //创建一个layout布局类
        MCCollectionViewFlowLayout * layout = [[MCCollectionViewFlowLayout alloc]init];
        //设置布局方向为横向流布局
        //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _firstCollectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _firstCollectionView.backgroundColor=[UIColor clearColor];
        _firstCollectionView.dataSource=self;
        _firstCollectionView.delegate=self;
        [_firstCollectionView registerClass:[MCMCZhuihaoRecordSubDetailCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCMCZhuihaoRecordSubDetailCollectionViewCell class])];
        
    }
    return _firstCollectionView;
}



#pragma mark - <UICollectionViewDataSource>
// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        return nil ;
    }
    return nil ;
}

//设置section的颜色
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout colorForSectionAtIndex:(NSInteger)section{
    return [UIColor clearColor];
}
//设置item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(27, 27);
}
//设置section的边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 两个cell之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
    
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

//numberOfItemsInSection
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _ballCount;
}

//numberOfSections
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


//UICollectionViewCell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MCMCZhuihaoRecordSubDetailCollectionViewCell*  cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCMCZhuihaoRecordSubDetailCollectionViewCell class]) forIndexPath:indexPath];
    if (_collectionMarry.count>0) {
        cell.dataSource=_collectionMarry[indexPath.row];
    }
    return cell;
}
#pragma mark-didSelect
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark-Init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier BallCount:(int)ballCount{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _ballCount=ballCount;
        _lineCount=ceilf((1.00*ballCount)/5.0);
        [self createBackView];
        [self initView];
    }
    return self;
}
#pragma mark-设置背景
-(void)createBackView{
    
    _backImgV=[[UIImageView alloc]init];
    [self addSubview:_backImgV];
    _backImgV.frame=CGRectMake(0, 0, G_SCREENWIDTH-20, 574+(_lineCount-1)*30);
    UIImage * image = [UIImage imageNamed:@"touzhu-beijing"];
    
    CGFloat top = 25; // 顶端盖高度
    CGFloat bottom = 25 ; // 底端盖高度
    CGFloat left = 10; // 左端盖宽度
    CGFloat right = 10; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    _backImgV.image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
}

#pragma mark-UI
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
    
    //期号
    _qiHaoLab =[[UILabel alloc]init];
    _qiHaoLab.textColor=RGB(136,136,136);
    _qiHaoLab.font=[UIFont systemFontOfSize:12];
    _qiHaoLab.text =@"加载中";
    _qiHaoLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_qiHaoLab];
    [_qiHaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(65);
        make.left.equalTo(_czNameLab.mas_left);
    }];
    
    
    //正在追号
    _stateLab =[[UILabel alloc]init];
    _stateLab.textColor=RGB(255,168,0);
    _stateLab.font=[UIFont systemFontOfSize:12];
    _stateLab.text =@"加载中";
    _stateLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_stateLab];
    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(65);
        make.left.equalTo(_qiHaoLab.mas_right).offset(10);
        make.width.mas_equalTo(100);
    }];
    
    
    _orderLab =[[UILabel alloc]init];
    [self setText1:@"订单编号：" andLab2:_orderLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:0 andL:21 andTop:107];
    
    _liuShuiOrderLab=[[UILabel alloc]init];
    [self setText1:@"流水编号：" andLab2:_liuShuiOrderLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:1 andL:21 andTop:107];
    
    _timeLab=[[UILabel alloc]init];
    [self setText1:@"投注时间：" andLab2:_timeLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:2 andL:21 andTop:107];
    
    _contentLab=[[UILabel alloc]init];
    [self setText1:@"投注详情：" andLab2:_contentLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:3 andL:21 andTop:107];
    _zijinMoShiLab=[[UILabel alloc]init];
    [self setText1:@"资金模式：" andLab2:_zijinMoShiLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:4 andL:21 andTop:107];
    
    _touzhuJinELab=[[UILabel alloc]init];
    [self setText1:@"投注金额：" andLab2:_touzhuJinELab text2:@"加载中" andColor2:RGB(249,84,83) andIndex:5 andL:21 andTop:107];
    
    _kaiJiangTimeELab=[[UILabel alloc]init];
    [self setText1:@"开奖时间：" andLab2:_kaiJiangTimeELab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:6 andL:21 andTop:107];
    
    _kaiJianghaomaLab=[[UILabel alloc]init];
    [self setText1:@"开奖号码：" andLab2:_zhongjiangJinELab text2:@"" andColor2:RGB(102,102,102) andIndex:7 andL:21 andTop:107];
    [self addSubview:self.firstCollectionView];
    self.firstCollectionView.frame=CGRectMake(21+65, 107+7*30-7,(27+2)*5+20, (27+2)*_lineCount);
    
    _zhongjiangZhuShuLab=[[UILabel alloc]init];
    [self setText1:@"中奖注数：" andLab2:_zhongjiangZhuShuLab text2:@"加载中" andColor2:RGB(102,102,102) andIndex:8 andL:21 andTop:107+(27+2)*_lineCount -20];
    
    _zhongjiangJinELab=[[UILabel alloc]init];
    [self setText1:@"中奖金额：" andLab2:_zhongjiangJinELab text2:@"加载中" andColor2:RGB(249,84,83) andIndex:9 andL:21 andTop:107+(27+2)*_lineCount -20];
    
    
    UIButton* orderCopyBtn1=[[UIButton alloc]init];
    [self addSubview:orderCopyBtn1];
    _orderCopyBtn1=orderCopyBtn1;
    orderCopyBtn1.backgroundColor=[UIColor whiteColor];
    orderCopyBtn1.titleLabel.font=[UIFont systemFontOfSize:12];
    [orderCopyBtn1 setTitleColor:RGB(255,168,0) forState:UIControlStateNormal];
    [orderCopyBtn1 setTitle:@"复制" forState:UIControlStateNormal];
    [orderCopyBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_orderLab.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(21);
    }];
    [orderCopyBtn1 addTarget:self action:@selector(actionPasteboard:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* orderCopyBtn2=[[UIButton alloc]init];
    [self addSubview:orderCopyBtn2];
    _orderCopyBtn2=orderCopyBtn2;
    orderCopyBtn2.backgroundColor=[UIColor whiteColor];
    orderCopyBtn2.titleLabel.font=[UIFont systemFontOfSize:12];
    [orderCopyBtn2 setTitleColor:RGB(255,168,0) forState:UIControlStateNormal];
    [orderCopyBtn2 setTitle:@"复制" forState:UIControlStateNormal];
    [orderCopyBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_liuShuiOrderLab.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(21);
    }];
    [orderCopyBtn2 addTarget:self action:@selector(actionPasteboard:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIScrollView *bgview = [[UIScrollView alloc] init];
    [self addSubview:bgview];
    bgview.layer.cornerRadius = 4;
    bgview.clipsToBounds = YES;
    bgview.backgroundColor = RGB(237, 237, 237);
    self.bgview = bgview;
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(_zhongjiangJinELab.mas_bottom).offset(10);
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
    
    

    
    UIButton * jiXuTZ =[[UIButton alloc]init];
    [jiXuTZ setTitle:@"继续投注" forState:UIControlStateNormal];
    [self addSubview:jiXuTZ];
    [jiXuTZ setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jiXuTZ.backgroundColor = RGB(144, 8, 215);
    jiXuTZ.layer.cornerRadius = 4;
    [jiXuTZ addTarget:self action:@selector(jiXuTZClick) forControlEvents:UIControlEventTouchUpInside];
    jiXuTZ.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [jiXuTZ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-63-5);
        make.top.equalTo(bgview.mas_bottom).offset(14);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(126);
    }];
    
    UIButton * gobackRecord =[[UIButton alloc]init];
    [gobackRecord setTitle:@"返回记录" forState:UIControlStateNormal];
    [self addSubview:gobackRecord];
    [gobackRecord setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    gobackRecord.backgroundColor = RGB(255,168,0);
    gobackRecord.layer.cornerRadius = 4;
    [gobackRecord addTarget:self action:@selector(gobackRecordClick) forControlEvents:UIControlEventTouchUpInside];
    gobackRecord.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [gobackRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(63+5);
        make.top.equalTo(bgview.mas_bottom).offset(14);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(126);
    }];
    
#pragma mark-【新需求 "21": "江苏骰宝" ，"87": "吉林骰宝"，"88": "安徽骰宝","89": "湖北骰宝"  隐藏(继续投注)和(返回记录)】
    if([self.LotteryCode isEqualToString:@"21"]||[self.LotteryCode isEqualToString:@"87"]||[self.LotteryCode isEqualToString:@"88"]||[self.LotteryCode isEqualToString:@"89"]){
        gobackRecord.hidden=YES;
        jiXuTZ.hidden=YES;
    }
    
}

#pragma mark-继续投注
-(void)jiXuTZClick{
    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
    //logo
    _logoImgV.image=[UIImage imageNamed: dic[_LotteryCode][@"logo"]];
    
    MCUserDefinedLotteryCategoriesModel *model = [MCUserDefinedLotteryCategoriesModel GetMCUserDefinedLotteryCategoriesModelWithCZID:_LotteryCode];
    MCPickNumberViewController *pickVc = [[MCPickNumberViewController alloc] init];
    pickVc.lotteriesTypeModel = model;
    pickVc.palyCode=self.dataSource.PlayCode;
    pickVc.navigationItem.title = dic[_LotteryCode][@"name"];
    [[UIView MCcurrentViewController].navigationController pushViewController:pickVc animated:YES];
}

#pragma mark-返回记录
-(void)gobackRecordClick{
    
    [[UIView MCcurrentViewController].navigationController popViewControllerAnimated:YES];
    
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

-(void)setText1:(NSString *)text1 andLab2:(UILabel *)lab2 text2:(NSString *)text2 andColor2:(UIColor *)color2 andIndex:(int)index andL:(CGFloat )L andTop:(CGFloat)Top{
    if (Top<107) {
        Top=107;
    }else{
        
    }
    CGFloat H =30;
    CGFloat W_L =65;
    UILabel * lab1=[[UILabel alloc]init];
    lab1.textColor=RGB(46,46,46);
    lab1.font=[UIFont systemFontOfSize:12];
    lab1.text =text1;
    lab1.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:lab1];
    lab1.frame=CGRectMake(L, Top+index*H, W_L, 15);
    
    lab2.textColor=color2;
    lab2.font=[UIFont systemFontOfSize:12];
    lab2.text =text2;
    lab2.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:lab2];
    lab2.frame=CGRectMake(L+W_L, Top+index*H, G_SCREENWIDTH-33-W_L, 15);
    
}

-(void)actionPasteboard:(UIButton *)btn{
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *string = @"";
    if (btn == _orderCopyBtn1) {
        string=_orderLab.text;
    }else{
        string=_liuShuiOrderLab.text;
    }
    [pab setString:string];
    
    if (pab == nil) {
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else{
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
    }
    
}



-(void)setDataSource:(MCUserChaseRecordDetailSubDataModel *)dataSource{
    _dataSource=dataSource;
    
    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
    //logo
    _logoImgV.image=[UIImage imageNamed: dic[_LotteryCode][@"logo"]];
    
    _czNameLab.text = dic[_LotteryCode][@"name"];
    _wfNameLab.text=[MCLotteryID  getLotteryFullNameByPlayCode:dataSource.PlayCode andLotteryCode:_LotteryCode andBetMode:[dataSource.BetMode intValue]];
    
    _qiHaoLab.text=[NSString stringWithFormat:@"%@期",dataSource.IssueNumber];
    _stateLab.text=[self getBetOrderState:dataSource.BetOrderState];
    _orderLab.text=dataSource.ChaseOrderID;
    _liuShuiOrderLab.text=dataSource.OrderID;
    //投注时间
    _timeLab.text=dataSource.InsertTime;
    _contentLab.text=[NSString stringWithFormat:@"%@注|%@倍|%@",dataSource.BetCount,dataSource.BetMultiple,[self getBetMode:dataSource.BetMode]];
    _zijinMoShiLab.text=[NSString stringWithFormat:@"%@~0.0",_BetRebate];
    _touzhuJinELab.text=GetRealSNum(dataSource.BetMoney);
    _kaiJiangTimeELab.text=dataSource.BetTime;
    if (dataSource.DrawContent.length>1) {
        _collectionMarry=[[NSMutableArray alloc]init];
        [_collectionMarry addObjectsFromArray:[dataSource.DrawContent componentsSeparatedByString:@","]];
        [self.firstCollectionView reloadData];
    }
    _zhongjiangZhuShuLab.text=[NSString stringWithFormat:@"%@注",dataSource.AwContent];
    _zhongjiangJinELab.text=GetRealSNum(dataSource.AwMoney);
    
    CGRect subviewRect1 = [dataSource.BetContent boundingRectWithSize:CGSizeMake(G_SCREENWIDTH-80, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
    
    if (subviewRect1.size.height > 75) {
        self.bgview.contentSize = CGSizeMake(G_SCREENWIDTH-80, subviewRect1.size.height + 20);
    }else{
        self.bgview.contentSize = CGSizeMake(G_SCREENWIDTH-80, 75+10);
    }
    self.haoDetailLabel.text = dataSource.BetContent;

}

-(NSString *)getBetMode:(NSString *)SBetMode{
    int BetMode =[SBetMode intValue];
    if (( BetMode& 32)==32) {
        return  @"元模式";
    } else if ((BetMode & 64)==64) {
        return   @"角模式";
    } else if ((BetMode & 128)==128) {
        return   @"分模式";
    } else if ((BetMode & 256)==256){
        return   @"厘模式";
    }
    return @"";
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



















