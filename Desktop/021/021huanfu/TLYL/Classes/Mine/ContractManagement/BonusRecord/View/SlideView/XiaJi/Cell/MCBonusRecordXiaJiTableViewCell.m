//
//  MCBonusRecordXiaJiTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/11/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusRecordXiaJiTableViewCell.h"
#import "MCDataTool.h"
#import "MCRecordTool.h"
#import "MCContractMgtTool.h"

@interface MCBonusRecordXiaJiTableViewCell ()

@property (nonatomic,strong)UILabel * lab1;
@property (nonatomic,strong)UILabel * lab2;
@property (nonatomic,strong)UILabel * lab3;
@property (nonatomic,strong)UILabel * lab4;

@end

@implementation MCBonusRecordXiaJiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    CGFloat font = 12;
    CGFloat L = 22;
    if (G_SCREENWIDTH<370) {
        font=10;
        L =10;
    }
    
    self.backgroundColor=[UIColor clearColor];
    CGFloat K1= 0.25;
    CGFloat K2= 0.15;
    CGFloat K3= 0.225;
    CGFloat W = G_SCREENWIDTH-26;
    
    CGFloat W1=W*K1;
    CGFloat W2=W*K2;
    CGFloat W3=W*K3;
    CGFloat W4=W-W1-W2-W3;
    
    CGFloat H1=27;
    UIView  *back =[[UIView alloc]init];
    back.frame=CGRectMake(0, 0, W , H1);
    [self addSubview:back];
    
    UILabel * lab1=[[UILabel alloc]init];
    lab1 =[[UILabel alloc]init];
    lab1.textColor=RGB(46,46,46);
    lab1.font=[UIFont systemFontOfSize:font];
    lab1.text =@"加载中";
    lab1.textAlignment=NSTextAlignmentCenter;
    [back addSubview:lab1];
    lab1.frame=CGRectMake(0, 0, W1, H1);
    _lab1=lab1;
    
    UILabel * lab2=[[UILabel alloc]init];
    lab2 =[[UILabel alloc]init];
    lab2.textColor=RGB(255,168,0);
    lab2.font=[UIFont systemFontOfSize:font];
    lab2.text =@"加载中";
    lab2.textAlignment=NSTextAlignmentCenter;
    [back addSubview:lab2];
    lab2.frame=CGRectMake(W1, 0, W2, H1);
    _lab2=lab2;
    
    
    
    
    UILabel * lab3=[[UILabel alloc]init];
    lab3 =[[UILabel alloc]init];
    lab3.textColor=RGB(249,84,83);
    lab3.font=[UIFont systemFontOfSize:font];
    lab3.text =@"加载中";
    lab3.textAlignment=NSTextAlignmentCenter;
    [back addSubview:lab3];
    lab3.frame=CGRectMake(W1+W2, 0, W3, H1);
    _lab3=lab3;
    
    UILabel * lab4=[[UILabel alloc]init];
    lab4 =[[UILabel alloc]init];
    lab4.textColor=RGB(136, 136, 136);
    lab4.font=[UIFont systemFontOfSize:font];
    lab4.text =@"加载中";
    lab4.textAlignment=NSTextAlignmentCenter;
    [back addSubview:lab4];
    lab4.frame=CGRectMake(W1+W2+W3, 0, W4, H1);
    _lab4=lab4;
    
}


-(void)setLab:(UILabel *)lab Font:(CGFloat)font Color:(UIColor *)color TextAlignment:(NSTextAlignment)textAlignment {
    
    lab =[[UILabel alloc]init];
    lab.textColor=color;
    lab.font=[UIFont systemFontOfSize:font];
    lab.text =@"加载中";
    lab.textAlignment=textAlignment;
}


+(CGFloat)computeHeight:(id)info{
    
    return 40;
}

-(void)setDataSource:(MCGetDividentsListDeatailDataModel *)dataSource{
    
    _dataSource = dataSource;
    _lab1.text = dataSource.UserName;
    _lab2.text = [MCContractMgtTool getPercentNumber:dataSource.DividendRatio];
    _lab3.text = dataSource.DividentMoney;
    _lab4.text = dataSource.CreateTime;
    
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



















