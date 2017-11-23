//
//  MCGameRecordDetailViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCGameRecordDetailViewController.h"
#import "MCPickNumberViewController.h"
#import "MCGameRecordDetailModel.h"
#import "MCGameRecordDetailCollectionViewCell.h"
#import "MCTeamBDetailViewController.h"
#import "MCPullMenuModel.h"
#import "MCDataTool.h"

@interface MCGameRecordDetailViewController ()<UICollectionViewDataSource>

@property (nonatomic,strong) MCGameRecordDetailModel *gameRecordModel;
@property (nonatomic,strong) MCGameRecordDetailModel *data;


@end

@implementation MCGameRecordDetailViewController

- (NSMutableArray *)collectionViewArray{
    if (_collectionViewArray == nil) {
        _collectionViewArray = [NSMutableArray array];
    }
    return _collectionViewArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpUI];
    self.OrderID = self.dataSource.OrderID;
    self.InsertTime = self.dataSource.InsertTime;
    self.BetTb = self.dataSource.BetTb;
    if (![self isKindOfClass:[MCTeamBDetailViewController class]]) {
         [self loadDataAndShow];
    }
}

- (void)setUpUI{
 
    NSString *CZType = [MCLotteryID getLotteryFullNameByID:self.dataSource.PlayCode];
    int ballCount = (int)[MCMathUnits getBallCountWithCZType:CZType];
    int lineCount=ceilf((1.00*ballCount)/5.0);

    //打底的ScrollView
    UIScrollView *baseScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:baseScrollView];
    self.baseScrollView = baseScrollView;
    baseScrollView.backgroundColor = RGB(231, 231, 231);
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(13, 13, G_SCREENWIDTH - 26, MC_REALVALUE(547)+lineCount*30)];
    [baseScrollView addSubview:bgImg];
    // 加载图片
    UIImage *image = [UIImage imageNamed:@"touzhu-beijing"];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
    bgImg.image = newImage;
    bgImg.userInteractionEnabled = YES;
    
    //彩种logo
    UIImageView *czLogoImgV = [[UIImageView alloc] init];
    [bgImg addSubview:czLogoImgV];
    self.bgImg = bgImg;
    
    /*
     * 彩种名字
     */
    UILabel *czNameLabel = [[UILabel alloc] init];
    czNameLabel.text = @"正在加载";
    [bgImg addSubview:czNameLabel];
    czNameLabel.textColor = RGB(46, 46, 46);
    czNameLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(15)];

    /*
     * 玩法名称
     */
    UILabel *wfNameLabel = [[UILabel alloc] init];
    wfNameLabel.text = @"正在加载";
    [bgImg addSubview:wfNameLabel];
    wfNameLabel.textColor = RGB(46, 46, 46);
    wfNameLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];

    /*
     * 期号
     */
    UILabel *dateTitleLabel = [[UILabel alloc] init];
    dateTitleLabel.text = @"正在加载";
    [bgImg addSubview:dateTitleLabel];
    dateTitleLabel.textColor = RGB(136, 136, 136);
    dateTitleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];

    
    /*
     * 状态
     */
    UILabel *statusTitleLabel = [[UILabel alloc] init];
    statusTitleLabel.text = @"正在加载";
    [bgImg addSubview:statusTitleLabel];
    statusTitleLabel.textColor = RGB(255, 168, 0);
    statusTitleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];


    /*
     * 撤单
     */
    UIButton *chedanBtn = [[UIButton alloc] init];
    self.chedanBtn = chedanBtn;
    [chedanBtn setTitle:@"撤单" forState:UIControlStateNormal];
    [chedanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chedanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [chedanBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchDown];
    chedanBtn.frame = CGRectMake(0, 0, 64, 44);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chedanBtn];
    
    
    /*
     * 订单编号
     */
    UILabel *dingDanLabel = [[UILabel alloc] init];
    dingDanLabel.text = @"订单编号：";
    [bgImg addSubview:dingDanLabel];
    dingDanLabel.textColor = RGB(46, 46, 46);
    dingDanLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    UILabel *dingDanDetailLabel = [[UILabel alloc] init];
    [bgImg addSubview:dingDanDetailLabel];
    dingDanDetailLabel.text = @"正在加载";
    dingDanDetailLabel.textColor = RGB(46, 46, 46);
    dingDanDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];

    /*
     * 流水编号
     */
    UILabel *liuShuiLabel = [[UILabel alloc] init];
    liuShuiLabel.text = @"流水编号：";
    [bgImg addSubview:liuShuiLabel];
    liuShuiLabel.textColor = RGB(46, 46, 46);
    liuShuiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    UILabel *liuShuiLabelDetail = [[UILabel alloc] init];
    [bgImg addSubview:liuShuiLabelDetail];
    liuShuiLabelDetail.textColor = RGB(46, 46, 46);
    liuShuiLabelDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    liuShuiLabelDetail.text = @"正在加载";

    /*
     * 投注时间
     */
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.text = @"投注时间：";
    [bgImg addSubview:dateLabel];
    dateLabel.textColor = RGB(46, 46, 46);
    dateLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    UILabel *dateDetailLabel = [[UILabel alloc] init];
    [bgImg addSubview:dateDetailLabel];
    dateDetailLabel.text = @"正在加载";
    dateDetailLabel.textColor = RGB(46, 46, 46);
    dateDetailLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
 
    /*
     * 投注详情
     */
    UILabel *touzhuXianQingLabel = [[UILabel alloc] init];
    [bgImg addSubview:touzhuXianQingLabel];
    touzhuXianQingLabel.text = @"投注详情：";
    UILabel *touzhuXianQingLabelDetail = [[UILabel alloc] init];
    touzhuXianQingLabelDetail.text = @"正在加载";
    
    self.touzhuXianQingLabelDetail = touzhuXianQingLabelDetail;
    [bgImg addSubview:touzhuXianQingLabelDetail];
    touzhuXianQingLabel.textColor = RGB(46, 46, 46);
    touzhuXianQingLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    touzhuXianQingLabelDetail.textColor = RGB(46, 46, 46);
    touzhuXianQingLabelDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    
    /*
     * 奖金模式
     */
    UILabel *moshiLabel = [[UILabel alloc] init];
    moshiLabel.text = @"奖金模式：";
    [bgImg addSubview:moshiLabel];
    moshiLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    moshiLabel.textColor = RGB(46, 46, 46);
    
    UILabel *moshiLabelDatail = [[UILabel alloc] init];
    [bgImg addSubview:moshiLabelDatail];
    moshiLabelDatail.text = @"正在加载";
    moshiLabelDatail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    moshiLabelDatail.textColor = RGB(46, 46, 46);
    
    
    /*
     * 投注金额
     */
    UILabel *touZhujinELabel = [[UILabel alloc] init];
    touZhujinELabel.textColor = RGB(46, 46, 46);
    touZhujinELabel.text = @"投注金额：";
    touZhujinELabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [bgImg addSubview:touZhujinELabel];
    
    UILabel *touZhujinELabelDetail = [[UILabel alloc] init];
    touZhujinELabelDetail.textColor = RGB(249, 84, 83);
    touZhujinELabelDetail.text = @"正在加载";
    touZhujinELabelDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [bgImg addSubview:touZhujinELabelDetail];
    
    /*
     * 开奖时间
     */
    UILabel *dateLabelKai = [[UILabel alloc] init];
    dateLabelKai.textColor = RGB(46, 46, 46);
    dateLabelKai.text = @"开奖时间：";
    dateLabelKai.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [bgImg addSubview:dateLabelKai];
    
    UILabel *dateLabelKaiDetail = [[UILabel alloc] init];
    dateLabelKaiDetail.textColor = RGB(46, 46, 46);
    dateLabelKaiDetail.text = @"正在加载";
    dateLabelKaiDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [bgImg addSubview:dateLabelKaiDetail];
    
    /*
     * 开奖号码
     */
    UILabel *haomaLabel = [[UILabel alloc] init];
    haomaLabel.textColor = RGB(46, 46, 46);
    haomaLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    haomaLabel.text = @"开奖号码：";
    [bgImg addSubview:haomaLabel];
    
    
    /*
     * 中奖金额
     */
    UILabel *zhongjiangLabel = [[UILabel alloc] init];
    zhongjiangLabel.textColor = RGB(46, 46, 46);
    zhongjiangLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhongjiangLabel.text = @"中奖金额：";
    [bgImg addSubview:zhongjiangLabel];

    UILabel *zhongjiangLabelDetail = [[UILabel alloc] init];
    zhongjiangLabelDetail.textColor = RGB(249, 84, 83);
    zhongjiangLabelDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhongjiangLabelDetail.text = @"正在加载";
    [bgImg addSubview:zhongjiangLabelDetail];
    
    /*
     * 中奖注数
     */
    UILabel *zhongjiangZhuShuLabel = [[UILabel alloc] init];
    zhongjiangZhuShuLabel.textColor = RGB(46, 46, 46);
    zhongjiangZhuShuLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhongjiangZhuShuLabel.text = @"中奖注数：";
    [bgImg addSubview:zhongjiangZhuShuLabel];
    
    UILabel *zhongjiangZhuShuLabelDetail = [[UILabel alloc] init];
    zhongjiangZhuShuLabelDetail.textColor = RGB(46, 46, 46);
    zhongjiangZhuShuLabelDetail.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    zhongjiangZhuShuLabelDetail.text = @"正在加载";
    [bgImg addSubview:zhongjiangZhuShuLabelDetail];
    
    
    //开奖号码
    UIScrollView *bgview = [[UIScrollView alloc] init];
    [bgImg addSubview:bgview];
    bgview.layer.cornerRadius = 4;
    bgview.clipsToBounds = YES;
    bgview.backgroundColor = RGB(237, 237, 237);
    UILabel *haoDetailLabel = [[UILabel alloc] init];
    haoDetailLabel.textColor = RGB(46, 46, 46);
    haoDetailLabel.font = [UIFont systemFontOfSize:12];
    haoDetailLabel.text = @"正在加载";
    [bgview addSubview:haoDetailLabel];
    
    /*
     * 返回记录
     */
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setTitle:@"返回记录" forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backBtn.backgroundColor = RGB(255, 168, 0);
    backBtn.layer.cornerRadius = 4;
    [backBtn addTarget:self action:@selector(backBtnCopyClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.titleLabel.font = [UIFont boldSystemFontOfSize:MC_REALVALUE(12)];
    
    /*
     * 返回记录
     */
    UIButton *contnueBtn = [[UIButton alloc] init];
    [contnueBtn setTitle:@"继续投注" forState:UIControlStateNormal];
    [self.view addSubview:contnueBtn];
    [contnueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    contnueBtn.backgroundColor = RGB(144, 8, 215);
    contnueBtn.layer.cornerRadius = 4;
    [contnueBtn addTarget:self action:@selector(contnueBtnCopyClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    CGFloat padding = MC_REALVALUE(15);
    baseScrollView.contentSize = CGSizeMake(G_SCREENWIDTH, G_SCREENHEIGHT + 60);
    contnueBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    czLogoImgV.backgroundColor = [UIColor greenColor];
    czLogoImgV.layer.cornerRadius = 30;
    czLogoImgV.clipsToBounds = YES;
    self.haoDetailLabel = haoDetailLabel;
    
    UIButton *dingDanBtnCopy = [[UIButton alloc] init];
    [dingDanBtnCopy setTitle:@"复制" forState:UIControlStateNormal];
    dingDanBtnCopy.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(12)];
    [bgImg addSubview:dingDanBtnCopy];
    [dingDanBtnCopy setTitleColor:RGB(255, 168, 0) forState:UIControlStateNormal];
    [dingDanBtnCopy addTarget:self action:@selector(dingDanBtnCopyClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton *liuShuiBtnCopy = [[UIButton alloc] init];
    [liuShuiBtnCopy setTitle:@"复制" forState:UIControlStateNormal];
    liuShuiBtnCopy.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [bgImg addSubview:liuShuiBtnCopy];
    [liuShuiBtnCopy setTitleColor:RGB(255, 168, 0) forState:UIControlStateNormal];
    [liuShuiBtnCopy addTarget:self action:@selector(liuShuiBtnCopyClick) forControlEvents:UIControlEventTouchUpInside];
    [czLogoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg).offset(MC_REALVALUE(35));
        make.top.equalTo(bgImg).offset(MC_REALVALUE(30));
        make.height.width.equalTo(@(MC_REALVALUE(60)));
    }];
    self.czLogoImgV = czLogoImgV;
    [czNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(czLogoImgV.mas_right).offset(10);
        make.top.equalTo(@(MC_REALVALUE(45)));
    }];
    self.czNameLabel = czNameLabel;
    [wfNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(czNameLabel.mas_right).offset(5);
        make.centerY.equalTo(czNameLabel.mas_centerY);
    }];
    self.wfNameLabel = wfNameLabel;
    [dateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(czNameLabel);
        make.top.equalTo(czNameLabel.mas_bottom).offset(MC_REALVALUE(5));
    }];
    self.dateTitleLabel = dateTitleLabel;
    [statusTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateTitleLabel.mas_right).offset(MC_REALVALUE(5));
        make.centerY.equalTo(dateTitleLabel.mas_centerY);
    }];
    self.statusTitleLabel = statusTitleLabel;

    
    //订单编号
    [dingDanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg).offset(MC_REALVALUE(35));
        make.top.equalTo(bgImg).offset(MC_REALVALUE(107));
    }];
    [dingDanDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel.mas_right);
        make.top.equalTo(dingDanLabel);
    }];
    self.dingDanDetailLabel = dingDanDetailLabel;
    
    
    
    //流水编号
    [liuShuiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(dingDanLabel.mas_bottom).offset(padding);
    }];
    [liuShuiLabelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(liuShuiLabel.mas_right);
        make.top.equalTo(liuShuiLabel);
    }];
    self.liuShuiLabelDetail = liuShuiLabelDetail;
    
    
    
    // 投注时间
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(liuShuiLabel.mas_bottom).offset(padding);
    }];
    [dateDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateLabel.mas_right);
        make.top.equalTo(dateLabel);
    }];
    
    self.dateDetailLabel =dateDetailLabel;
    
    //投注详情
    [touzhuXianQingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(dateLabel.mas_bottom).offset(padding);
    }];

    [touzhuXianQingLabelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(touzhuXianQingLabel.mas_right);
        make.top.equalTo(dateLabel.mas_bottom).offset(padding);
    }];


    [moshiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(touzhuXianQingLabel.mas_bottom).offset(padding);
    }];

    [moshiLabelDatail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moshiLabel.mas_right);
        make.top.equalTo(moshiLabel);
    }];
    self.moshiLabelDatail = moshiLabelDatail;

    
    
    //投注金额
    [touZhujinELabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(moshiLabel.mas_bottom).offset(padding);
    }];

    [touZhujinELabelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel.mas_right);
        make.top.equalTo(touZhujinELabel);
    }];
    self.touZhujinELabelDetail = touZhujinELabelDetail;

    [haomaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(touZhujinELabel.mas_bottom).offset(padding);
    }];
    self.zhongjiangLabelDetail = zhongjiangLabelDetail;
    
    
    /*
     * 开奖号码球
     */
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(27, 27);
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 5;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[MCGameRecordDetailCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MCGameRecordDetailCollectionViewCell class])];
    collectionView.dataSource = self;
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:collectionView];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(haomaLabel.mas_right).offset(5);
        make.height.mas_equalTo((27+2)*lineCount);
        make.top.equalTo(haomaLabel.mas_top);
        make.width.mas_equalTo((27+2)*5+20);
    }];
    
    
    //中奖注数
    [zhongjiangZhuShuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(collectionView.mas_bottom).offset(padding);
    }];
    [zhongjiangZhuShuLabelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zhongjiangZhuShuLabel.mas_right);
        make.top.equalTo(zhongjiangZhuShuLabel);
    }];
    self.zhongjiangZhuShuLabelDetail = zhongjiangZhuShuLabelDetail;
    
    //中奖金额
    [zhongjiangLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dingDanLabel);
        make.top.equalTo(zhongjiangZhuShuLabel.mas_bottom).offset(padding);
    }];

    [zhongjiangLabelDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(zhongjiangLabel.mas_right);
        make.top.equalTo(zhongjiangLabel);
    }];

    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg).offset(MC_REALVALUE(34));
        make.right.equalTo(bgImg).offset(MC_REALVALUE(-34));
        make.height.equalTo(@(MC_REALVALUE(75)));
        make.top.equalTo(zhongjiangLabel.mas_bottom).offset(padding);
    }];
    self.bgview = bgview;
    
    
    //继续投注
   [contnueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImg).offset(MC_REALVALUE(45));
        make.top.equalTo(bgview.mas_bottom).offset(padding);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@((G_SCREENWIDTH - 126) * 0.5));
    }];
    //返回记录
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bgImg).offset(MC_REALVALUE(-45));
        make.top.equalTo(bgview.mas_bottom).offset(padding);
        make.height.equalTo(@(MC_REALVALUE(34)));
        make.width.equalTo(@((G_SCREENWIDTH - 126) * 0.5));
    }];
    self.contnueBtn = contnueBtn;
    self.backBtn = backBtn;
    
    
    
    haoDetailLabel.numberOfLines = 0;
    [haoDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(10));
        make.width.equalTo(@(MC_REALVALUE(264)));
    }];

    [dingDanBtnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dingDanLabel);
        make.right.equalTo(bgImg).offset(MC_REALVALUE(-23));
        make.height.equalTo(@(MC_REALVALUE(15)));
        make.width.equalTo(@(MC_REALVALUE(40)));
        
    }];
    [liuShuiBtnCopy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(liuShuiLabel);
        make.right.equalTo(bgImg).offset(MC_REALVALUE(-23));
        make.height.equalTo(@(MC_REALVALUE(15)));
        make.width.equalTo(@(MC_REALVALUE(40)));
        
    }];
    [self.collectionViewArray removeAllObjects];
    [self ballCount];
    
  
}
- (void)ballCount{
    NSString *str = [MCLotteryID getLotteryFullNameByID:self.dataSource.PlayCode];
    int count = 0;
    if ([str isEqualToString:@"ssc"]) {
        count = 5;
    } else if ([str isEqualToString:@"esf"]){
        count = 5;
    }else if ([str isEqualToString:@"sd"]){
        count = 3;
    }else if ([str isEqualToString:@"pls"]){
        count = 3;
    }else if ([str isEqualToString:@"plw"]){
        count = 5;
    }else if ([str isEqualToString:@"ssl"]){
        count = 3;
    }else if ([str isEqualToString:@"kl8"]){
        count = 20;
    }else if ([str isEqualToString:@"pks"]){
        count = 10;
    }else if ([str isEqualToString:@"k3"]){
        count = 3;
    }else if ([str isEqualToString:@"tb"]){
        count = 5;
    }else if([str isEqualToString:@"klsf"]){
        count = 8;
    }
    for (NSInteger i = 0; i<count; i++) {
        [self.collectionViewArray addObject:@"?"];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)backBtnCopyClick{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark-跳转投注界面
- (void)contnueBtnCopyClick{
    
    
    MCUserDefinedLotteryCategoriesModel *model = [MCUserDefinedLotteryCategoriesModel GetMCUserDefinedLotteryCategoriesModelWithCZID:self.data.LotteryCode];
    MCPickNumberViewController *pickVc = [[MCPickNumberViewController alloc] init];
    pickVc.lotteriesTypeModel = model;
    pickVc.palyCode=self.dataSource.PlayCode;
    pickVc.navigationItem.title = [MCLotteryID getLotteryCategoriesNameByID:self.data.LotteryCode];
    [self.navigationController pushViewController:pickVc animated:YES];

}


- (void)touzhuBtnCopyClick{
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.dingDanDetailLabel.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else{
        
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
        
    }

}

- (void)liuShuiBtnCopyClick{
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.dingDanDetailLabel.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
    }

}
- (void)dingDanBtnCopyClick{
    
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    
    NSString *string = self.dingDanDetailLabel.text;
    
    [pab setString:string];
    
    if (pab == nil) {
        [SVProgressHUD showErrorWithStatus:@"复制失败"];
        
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"已复制"];
    }

}
- (void)getSubView:(UIView *)view{
    for (UIView *subView in [view subviews]) {
        if ([subView isKindOfClass:[UICollectionView class]]) {
            UICollectionView *col = (UICollectionView*)subView;
            UICollectionViewCell *cell0 = [col cellForItemAtIndexPath:[NSIndexPath indexPathWithIndex:0]];
            UICollectionViewCell *cell1 = [col cellForItemAtIndexPath:[NSIndexPath indexPathWithIndex:1]];
            for (UIView *subView1 in [cell0 subviews]) {
                if ([subView1 isKindOfClass:[UILabel class]]) {
                    UILabel *lab = (UILabel *)subView1;
                    lab.font = [UIFont systemFontOfSize:14];
                }
                [self getSubView:cell0];
            }
            for (UIView *subView2 in [cell1 subviews]) {
                if ([subView2 isKindOfClass:[UILabel class]]) {
                    UILabel *lab = (UILabel *)subView2;
                    lab.font = [UIFont systemFontOfSize:14];
                }
                [self getSubView:cell1];
            }
           
        }
        [self getSubView:subView];
    }
}

- (void)cancleBtnClick:(UIButton *)btn{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
   
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"您确定撤销该注单吗？" attributes: @{NSForegroundColorAttributeName :RGB(102, 102, 102),NSFontAttributeName:[UIFont systemFontOfSize:MC_REALVALUE(12)]}];
    [alertController setValue:title forKey:@"attributedTitle"];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"以后再说" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
 
    }];
    [cancelAction setValue:RGB(46, 46, 46) forKey:@"titleTextColor"];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即撤单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
        MCCancleLotteryModel *model = [[MCCancleLotteryModel alloc] init];
        self.cancelModel = model;
        model->_code = self.data.LotteryCode;
        model->_orderID = self.data.Bet[0].OrderID;
        [BKIndicationView showInView:self.view];
        [model refreashDataAndShow];
        model.callBackSuccessBlock = ^(id manager) {
            self.chedanBtn.enabled = NO;
            [self.chedanBtn setTitle:@"已撤单" forState:UIControlStateNormal];
        };
        
    }];
    [okAction setValue:RGB(144, 8, 215) forKey:@"titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self getSubView:alertController.view];
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (void)loadDataAndShow{
  
    MCGameRecordDetailModel *model = [[MCGameRecordDetailModel alloc] init];
    self.gameRecordModel = model;
//    model->_ChaseOrderID = self.dataSource.ChaseOrderID;

    model->_OrderID = self.OrderID;
    model->_InsertTime = self.InsertTime;
    model->_IsHistory = self.isHistory;
    model->_LotteryCode = self.BetTb;
    [BKIndicationView showInView:self.view];
    [model refreashDataAndShow];
    self.chedanBtn.userInteractionEnabled = NO;
    model.callBackFailedBlock = ^(id manager, NSString *errorCode) {
        self.chedanBtn.userInteractionEnabled = YES;
    };
    model.callBackSuccessBlock = ^(id manager) {
        self.chedanBtn.userInteractionEnabled = YES;
        self.data = [MCGameRecordDetailModel mj_objectWithKeyValues:manager];
        NSDictionary * dic_CZHelper = [MCDataTool MC_GetDic_CZHelper];
        NSDictionary * czInfo=[dic_CZHelper objectForKey:self.data.LotteryCode];
        MCCZHelperModel * modelCZ=[MCCZHelperModel mj_objectWithKeyValues:czInfo];
        self.czLogoImgV.image = [UIImage imageNamed:modelCZ.logo];
        if (self.data.Bet.count ==0) {
            [SVProgressHUD showInfoWithStatus:@"暂无数据"];
            return ;
        }
        self.dingDanDetailLabel.text = self.data.Bet[0].ChaseOrderID;
        //彩种名称
        self.czNameLabel.text = [MCLotteryID getLotteryCategoriesNameByID:self.data.LotteryCode];
        self.dateTitleLabel.text = [NSString stringWithFormat:@"%@期",self.data.Bet[0].IssueNumber];
        //玩法名称
        self.wfNameLabel.text = [MCLotteryID  getLotteryFullNameByPlayCode:self.data.Bet[0].PlayCode andLotteryCode:self.data.LotteryCode andBetMode:self.data.Bet[0].BetMode ];
        self.dateDetailLabel.text = self.data.Bet[0].InsertTime;
        int BetOrderState = self.data.Bet[0].BetOrderState;
        NSString *str = @"";
        self.chedanBtn.hidden = YES;
        if ((BetOrderState & 1) == 1) {
            str = @"【购买成功】";
            self.chedanBtn.hidden = NO;
        } else if ((BetOrderState & 32768) == 32768) {
            str = @"【已撤奖】";
           
        } else if ((BetOrderState & 64) == 64) {
            str = @"【已出票】";
            
        } else if ((BetOrderState & 16777216) == 16777216) {
            str = @"【已派奖】";
           
        } else if ((BetOrderState & 33554432) == 33554432) {
            str = @"【未中奖】";
          
        } else if ((BetOrderState & 4096) == 4096) {
            str = @"【已结算】";
            
        } else if ((BetOrderState & 512) == 512) {
            str = @"【强制结算】";
            
        } else if ((BetOrderState & 4) == 4) {
            str = @"【已撤单】";
        } else {
            str = @"【订单异常】";
          
        }
        if ((1048577 & BetOrderState) == 1048577) {
            self.chedanBtn.hidden = NO;
        } else {
            self.chedanBtn.hidden = YES;
        }
        NSString *typeSS = @"";
       int BetMode=  self.data.Bet[0].BetMode;
        if ((BetMode & 32)==32) {
            typeSS = @"元模式";
        } else if ((BetMode & 64)==64) {
            typeSS = @"角模式";
        } else if ((BetMode & 128)==128) {
            typeSS = @"分模式";
        } else if ((BetMode & 256)==256){
            typeSS = @"厘模式";
        }
        
        self.moshiLabelDatail.text = [NSString stringWithFormat:@"%@~0.0" ,self.data.BetRebate];
        self.statusTitleLabel.text = str;
        //流水编号
        self.liuShuiLabelDetail.text = self.data.Bet[0].OrderID;
        self.dateDetailLabel.text = self.data.Bet[0].InsertTime;
        NSString *str1 =  [NSString stringWithFormat:@"%@|%@|%@倍|%d注",typeSS,self.data.BetRebate,self.data.Bet[0].BetMultiple,self.data.Bet[0].BetCount];
        self.touzhuXianQingLabelDetail.text = str1;

        
        NSString *teStr = @"";
        if ([self.data.Bet[0].AwContent isEqualToString:@""]||self.data.Bet[0].AwContent == nil) {
            teStr = @"0注";
        }else{
            teStr = [NSString stringWithFormat:@"%@注",self.data.Bet[0].AwContent];
        }
        self.zhongjiangZhuShuLabelDetail.text = teStr;
        float awMoneyFloat = [self.data.Bet[0].AwMoney floatValue];
        int awMoneyInt = [self.data.Bet[0].AwMoney intValue];
        if (awMoneyFloat == awMoneyInt) {
            self.zhongjiangLabelDetail.text = [NSString stringWithFormat:@"%d元",awMoneyInt];
        } else {
            NSString *str1 = [NSString stringWithFormat:@"%.2f元",awMoneyFloat];
            NSString *str2 = [NSString stringWithFormat:@"%.3f元",awMoneyFloat];
            if ([str1 floatValue] == [str2 floatValue]) {
                self.zhongjiangLabelDetail.text = str1;
            } else {
                self.zhongjiangLabelDetail.text = str2;
            }
        }
        float betMoneyFloat = [self.data.Bet[0].BetMoney floatValue];
        int betMoneyInt = [self.data.Bet[0].BetMoney intValue];
        if (betMoneyFloat == betMoneyInt) {
            self.touZhujinELabelDetail.text = [NSString stringWithFormat:@"%d元",betMoneyInt];
        } else {
            NSString *str1 = [NSString stringWithFormat:@"%.2f元",betMoneyFloat];
            NSString *str2 = [NSString stringWithFormat:@"%.3f元",betMoneyFloat];
            if ([str1 floatValue] == [str2 floatValue]) {
                self.touZhujinELabelDetail.text = str1;
            } else {
                self.touZhujinELabelDetail.text = str2;
            }
        }

        if ([self.data.Bet[0].DrawContent isEqualToString:@""] ||self.data.Bet[0].DrawContent == nil ) {
  
        } else {
            NSArray *arr = [self.data.Bet[0].DrawContent componentsSeparatedByString:@","];
            
            [self.collectionViewArray removeAllObjects];
   
            [self.collectionView reloadData];
            
            self.collectionViewArray = [NSMutableArray arrayWithArray:arr];
            //快乐8干掉 飞盘号
            if ([self.data.LotteryCode isEqualToString: @"9"]||[self.data.LotteryCode isEqualToString: @"79"]||[self.data.LotteryCode isEqualToString: @"80"]) {
                [self.collectionViewArray removeLastObject];
            }
        }
        

        [self.collectionView reloadData];

       NSString *strTemp = [self.data.Bet[0].PlayCode stringByReplacingOccurrencesOfString:self.data.LotteryCode withString:@""];
       NSString *strBetContent = [MCMathUnits tzContentToChinese:[MCLotteryID getLotteryCategoriesTypeNameByID:self.data.LotteryCode] andMethodId:strTemp andContent:self.data.Bet[0].BetContent];
        
        CGRect subviewRect1 = [strBetContent boundingRectWithSize:CGSizeMake(MC_REALVALUE(264), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
        
        self.baseScrollView.contentSize = CGSizeMake(G_SCREENWIDTH, G_SCREENHEIGHT + subviewRect1.size.height + 100);
        if (subviewRect1.size.height > 75) {
        self.bgview.contentSize = CGSizeMake(MC_REALVALUE(264), subviewRect1.size.height + 20);
        }else{
         self.bgview.contentSize = CGSizeMake(MC_REALVALUE(264), 75);
        }
        
        self.haoDetailLabel.attributedText = [[NSAttributedString alloc] initWithString:strBetContent];
        
#pragma mark-【新需求 "21": "江苏骰宝" ，"87": "吉林骰宝"，"88": "安徽骰宝","89": "湖北骰宝"  隐藏(继续投注)和(返回记录)】
        if([self.data.LotteryCode isEqualToString:@"21"]||[self.data.LotteryCode isEqualToString:@"87"]||[self.data.LotteryCode isEqualToString:@"88"]||[self.data.LotteryCode isEqualToString:@"89"]){
            
            self.contnueBtn.hidden=YES;
            self.backBtn.hidden=YES;
        }
        
    };
}
                                   
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MCGameRecordDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MCGameRecordDetailCollectionViewCell class]) forIndexPath:indexPath];
    cell.dataSource=self.collectionViewArray[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collectionViewArray.count;
}
@end
