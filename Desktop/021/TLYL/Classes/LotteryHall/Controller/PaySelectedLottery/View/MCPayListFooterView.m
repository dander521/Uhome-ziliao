//
//  MCPayListFooterView.m
//  TLYL
//
//  Created by MC on 2017/9/21.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPayListFooterView.h"

@interface MCPayListFooterView ()


/**共1000注 10000元*/
@property(nonatomic,strong)UILabel * lab_title;

/*
 * 付款
 */
@property(nonatomic,strong)UIButton *btn_Pay;

/*
 * 清空
 */
@property(nonatomic,strong)UIButton *btn_clear;

@end

@implementation MCPayListFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=RGB(255, 255, 255);
    
    /**共1000注 10000元*/
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.textColor=RGB(100, 100, 100);
    _lab_title.font=[UIFont systemFontOfSize:15];
    _lab_title.text =@"加载中";
    _lab_title.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_lab_title];
    _lab_title.frame=CGRectMake(18, 0, G_SCREENWIDTH-100, 31);

    /*
     * 付款
     */
    _btn_Pay=[[UIButton alloc]init];
    [self setBtn:_btn_Pay withTitle:@"立即投注" andImgV:nil andColor:RGB(142,0,211)];
    _btn_Pay.tag = 1002;
    [_btn_Pay addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn_Pay.frame=CGRectMake(0, 31, G_SCREENWIDTH, 50);

    _btn_clear=[[UIButton alloc]init];
    [self setBtn:_btn_clear withTitle:nil andImgV:@"qingkong-yxz" andColor:[UIColor clearColor]];
    _btn_clear.tag = 1001;
    [_btn_clear addTarget:self action:@selector(bottomViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn_clear.frame=CGRectMake(G_SCREENWIDTH-18-50, 5.5, 50, 20);
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
    if (self.block) {
        self.block(btn.tag);
    }
}

-(void)setDataSource:(MCPaySLBaseModel*)dataSource{
    _dataSource=dataSource;
//    NSString * str = [NSString stringWithFormat:@"总%@注，%@倍，%@元",_dataSource.stakeNumber,_dataSource.allMultiple,GetRealSNum(_dataSource.payMoney)];
    NSString * str = [NSString stringWithFormat:@"总%@注，%@元",_dataSource.stakeNumber,GetRealSNum(_dataSource.payMoney)];

    NSRange range = [str rangeOfString:[NSString stringWithFormat:@"%@元",GetRealSNum(_dataSource.payMoney)]];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 设置数字为红色
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(range.location, range.length-1)];

    _lab_title.attributedText=attri;
}

+(CGFloat)computeHeight:(id)info{
    return 81;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end




















