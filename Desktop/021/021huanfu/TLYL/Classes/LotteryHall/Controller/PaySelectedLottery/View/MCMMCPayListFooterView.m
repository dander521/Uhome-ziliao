//
//  MCMMCPayListFooterView.m
//  TLYL
//
//  Created by MC on 2017/9/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMCPayListFooterView.h"
#import "MCMSPopView.h"
#import "MCPaySelectedLotteryPickView.h"
@interface MCMMCPayListFooterView ()


/**共1000注 10000元*/
@property(nonatomic,strong)UILabel * lab_title;

/*
 * 清空
 */
@property(nonatomic,strong)UIButton *btn_clear;

@property(nonatomic,strong)UIButton *btn_lianKai;

@end

@implementation MCMMCPayListFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=RGB(255, 255, 255);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Notification_MCPaySelectedLottery_Count:) name:@"Notification_MCPaySelectedLottery_Count" object:nil];

    _lianKaiCount=1;
    
    UIButton * btn_liankai=[[UIButton alloc]init];
    [self addSubview:btn_liankai];
    btn_liankai.tag=1003;
    btn_liankai.frame=CGRectMake((G_SCREENWIDTH-49)/2.0, 3, 49, 25);
    [btn_liankai.layer setMasksToBounds:YES];
    [btn_liankai.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [btn_liankai.layer setBorderWidth:0.8]; //边框宽度
    [btn_liankai setTitleColor:RGB(144,8,215) forState:UIControlStateNormal];
    [btn_liankai.layer setBorderColor:RGB(220,220,220).CGColor];//边框颜色
    UIImage * image=[UIImage imageNamed:@"mmc_xiala_selected"];
    [btn_liankai setImage:image forState:UIControlStateNormal];
    [btn_liankai addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];//button 点击回调方法
    btn_liankai.backgroundColor = [UIColor whiteColor];
    btn_liankai.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn_liankai addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn_lianKai=btn_liankai;
    [btn_liankai setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [self setBtnLianKai:@"1"];
  
    
    UILabel * lab1=[[UILabel alloc]init];
    lab1.text=@"连开";
    lab1.textColor=RGB(46,46,46);
    lab1.font=[UIFont systemFontOfSize:12];
    [self addSubview:lab1];
    lab1.textAlignment=NSTextAlignmentRight;
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn_liankai.mas_centerY);
        make.right.equalTo(btn_liankai.mas_left).offset(-10);
    }];
    
    UILabel * lab2=[[UILabel alloc]init];
    lab2.text=@"次";
    lab2.textColor=RGB(46,46,46);
    lab2.font=[UIFont systemFontOfSize:12];
    lab2.textAlignment=NSTextAlignmentLeft;
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btn_liankai.mas_centerY);
        make.left.equalTo(btn_liankai.mas_right).offset(10);
    }];
    
    /**共1000注 10000元*/
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.textColor=RGB(100, 100, 100);
    _lab_title.font=[UIFont systemFontOfSize:15];
    _lab_title.text =@"加载中";
    _lab_title.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_lab_title];
    _lab_title.frame=CGRectMake(18, 32, G_SCREENWIDTH-100, 32);

    
    
    _btn_clear=[[UIButton alloc]init];
    [self setBtn:_btn_clear withTitle:nil andImgV:@"qingkong-yxz" andColor:[UIColor clearColor]];
    _btn_clear.tag = 1001;
    [_btn_clear addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn_clear.frame=CGRectMake(G_SCREENWIDTH-18-50, 32+6, 50, 20);
    
    
    UIView * downView=[[UIView alloc]init];
    [self addSubview:downView];
    downView.frame=CGRectMake(0, 64, G_SCREENWIDTH, 70);
    downView.backgroundColor=RGB(144,8,215);
    
    UIImageView * kaijiangimgV=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"anniu-miaomiaocai"]];
    kaijiangimgV.frame=CGRectMake(18, 11, G_SCREENWIDTH-36, 49);
    [downView addSubview:kaijiangimgV];
    
    UIButton * kaijiangBtn = [[UIButton alloc]init];
    kaijiangBtn.tag=1002;
    kaijiangBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [kaijiangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downView addSubview:kaijiangBtn];
    [kaijiangBtn setTitle:@"立即开奖" forState:UIControlStateNormal];
    kaijiangBtn.frame=CGRectMake(0, 0, G_SCREENWIDTH, 70);
    [kaijiangBtn addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)setBtn:(UIButton*)btn withTitle:(NSString *)title andImgV:(NSString *)image andColor:(UIColor *)color {
    btn.backgroundColor=color;
    btn.layer.cornerRadius=0.0;
    btn.clipsToBounds=YES;
    [self addSubview:btn];
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}



-(void)bottomViewBtnClick:(UIButton *)btn{
    
    if (btn.tag==1003) {
        MCPaySelectedLotteryPickView *picker = [[MCPaySelectedLotteryPickView alloc]init];
        picker.dataSource =@[@"1",@"5",@"10",@"15",@"20",@"30",@"40",@"50"];
        [picker show];

        
//        MCMSPopView *popView = [MCMSPopView alertInstance];
//        //    popView.dataArray=nil;
//        [popView.dataArray removeAllObjects];
//        popView.dataArray=[NSMutableArray arrayWithArray:@[@"1",@"5",@"10",@"15",@"20",@"30",@"40",@"50"]];
//        popView.frame = CGRectMake(_btn_lianKai.left, G_SCREENHEIGHT- (64+70)-90,  _btn_lianKai.widht, 90);
//        __weak MCMMCPayListFooterView *weakSelf = self;
//        popView.MSSelectRowBlock = ^(NSString *type){
//            
//            [weakSelf setBtnLianKai:type];
//            
//        };
//        
//        [popView showModelWindow];
        
    }else{
        if (self.block) {
            self.block(btn.tag);
        }
    }
   
    
}
-(void)Notification_MCPaySelectedLottery_Count:(NSNotification *)notification
{
    [self setBtnLianKai:notification.object];
}

-(void)setDataSource:(MCPaySLBaseModel*)dataSource{
    _dataSource=dataSource;
    [self setAttributedText:dataSource];
    
}

-(void)setBtnLianKai:(NSString *)type{

    [self.btn_lianKai setTitle:type forState:UIControlStateNormal];
    self.lianKaiCount=[type intValue];
    [self setAttributedText:self.dataSource];
    NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:type attributes:@{NSFontAttributeName: self.btn_lianKai.titleLabel.font}];
    CGSize size = [attributeSting size];

    CGFloat labelWidth = size.width +3 ;
    [self.btn_lianKai setImageEdgeInsets:UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth)];
}

-(void)setAttributedText:(MCPaySLBaseModel*)dataSource{
    NSString * str = [NSString stringWithFormat:@"总%@注，%@元",_dataSource.stakeNumber,GetRealFloatNum([_dataSource.payMoney floatValue] * self.lianKaiCount) ];
    
    NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%@元",GetRealFloatNum([_dataSource.payMoney floatValue] * self.lianKaiCount)]];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, range.length-1)];
    
    _lab_title.attributedText=attri;
}

+(CGFloat)computeHeight:(id)info{
    return 64+70;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end





















