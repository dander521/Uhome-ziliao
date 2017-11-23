//
//  MCBankcardManageTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/7/11.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBankcardManageTableViewCell.h"
#import "MCDataTool.h"

@interface MCBankcardManageTableViewCell ()
/*
 * 打底
 */
@property (nonatomic,strong)UIView * backView;

/*
 * 图标
 */
@property (nonatomic,strong)UIImageView * logoImgV;
/*
 * 卡的名称
 */
@property (nonatomic,strong)UILabel * cardNameLab;

/*
 * 卡号
 */
@property (nonatomic,strong)UILabel * cardNumberLab;

/*
 * btn
 */
@property (nonatomic,strong)UIButton * defaultBtn;


@end

@implementation MCBankcardManageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

-(void)setBackCAGradientLayer:(BOOL)type{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    gradient.locations = @[@0.0,@0.5];
    gradient.frame = _backView.bounds;
    //红色
    if (type) {
        gradient.colors = [NSArray arrayWithObjects:
                           (id)RGB(238,51,46).CGColor,
                           (id)RGB(197,41,37).CGColor,nil];
    //蓝色
    }else {
        gradient.colors = [NSArray arrayWithObjects:
                           (id)RGB(32,120,222).CGColor,
                           (id)RGB(12,79,157).CGColor,nil];

    }
    [_backView.layer addSublayer:gradient];
    _backView.alpha=1.0;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    _backView=[[UIView alloc]init];
    [self addSubview:_backView];
    _backView.layer.cornerRadius=5;
    _backView.clipsToBounds=YES;
    _backView.frame=CGRectMake(10, 0, G_SCREENWIDTH-20, 80);
    
}

-(void)loadUI{

    /*
     * logo
     */
    _logoImgV=[[UIImageView alloc]init];
    _logoImgV.backgroundColor=[UIColor whiteColor];
    [_backView addSubview:_logoImgV];
    _logoImgV.layer.cornerRadius=20;
    _logoImgV.clipsToBounds=YES;
    _logoImgV.frame=CGRectMake(18, 22.5, 40, 40);
    
    /*
     * 卡的名称
     */
    _cardNameLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _cardNameLab.textColor=[UIColor whiteColor];
    _cardNameLab.font=[UIFont boldSystemFontOfSize:12];
    _cardNameLab.text =@"加载中...";
    _cardNameLab.textAlignment=NSTextAlignmentLeft;
    [_backView  addSubview:_cardNameLab];
    [_cardNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImgV.mas_top);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(G_SCREENWIDTH-100);
        make.left.equalTo(_logoImgV.mas_right).offset(18);
    }];
    
    /*
     * 卡号
     */
    _cardNumberLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _cardNumberLab.textColor=[UIColor whiteColor];
    _cardNumberLab.font=[UIFont systemFontOfSize:18];
    _cardNumberLab.text =@"加载中...";
    _cardNumberLab.textAlignment=NSTextAlignmentRight;
    [_backView  addSubview:_cardNumberLab];
    [_cardNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_logoImgV.mas_bottom).offset(2);
        make.height.mas_equalTo(19);
        make.width.mas_equalTo(G_SCREENWIDTH-90);
        make.right.equalTo(_backView.mas_right).offset(-10);
    }];
    
    _defaultBtn=[[UIButton alloc]init];
    [_defaultBtn setTitle:@"默认" forState:UIControlStateNormal];
    _defaultBtn.backgroundColor=[UIColor clearColor];
    _defaultBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    [_defaultBtn.layer setMasksToBounds:YES];
    [_defaultBtn.layer setCornerRadius:10.0]; //设置矩圆角半径
    [_defaultBtn.layer setBorderWidth:0.5];   //边框宽度
    [_defaultBtn.layer setBorderColor:[UIColor whiteColor].CGColor];//边框颜色
    [_backView  addSubview:_defaultBtn];
    _defaultBtn.userInteractionEnabled=NO;
    [_defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cardNameLab.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(45);
        make.right.equalTo(_backView.mas_right).offset(-10);
    }];

}


-(void)setDataSource:(MCBankModel *)dataSource{
    
    _dataSource=dataSource;
    _cardNumberLab.text=[NSString stringWithFormat:@"**** **** **** %@",[dataSource.bankNumer substringFromIndex:dataSource.bankNumer.length-4]];
    NSDictionary * dic=[MCDataTool MC_GetDic_Bank];
    _cardNameLab.text =dic[dataSource.BankCode][@"name"];
    
    //默认银行卡
    if ([dataSource.Isdefault intValue]==1) {
        
        _defaultBtn.backgroundColor=[UIColor whiteColor];
        [_defaultBtn.layer setBorderWidth:0.0];
        [_defaultBtn setTitleColor:RGB(198, 42, 44) forState:UIControlStateNormal];

    }else{
       
        [_defaultBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_defaultBtn.layer setBorderWidth:0.5];   //边框宽度
        [_defaultBtn.layer setBorderColor:[UIColor whiteColor].CGColor];//边框颜色
        
    }
    
    _logoImgV.image=[UIImage imageNamed:dataSource.BankCode];
    
}

-(void)setBackViewWithSingal:(BOOL)isSingal{
    [self setBackCAGradientLayer:isSingal];
    [self loadUI];
}

+(CGFloat)computeHeight:(id)info{
    
    return 80+10;
    
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












