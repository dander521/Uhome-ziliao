//
//  MCZhangBianRecordTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCZhangBianRecordTableViewCell.h"
#import "MCDataTool.h"
#import "MCGroupPaymentModel.h"
#import "MCRecordTool.h"

@interface MCZhangBianRecordTableViewCell ()

@property (nonatomic,strong)UILabel * logoImgV;
@property (nonatomic,strong)UILabel * lab1;
@property (nonatomic,strong)UILabel * lab2;
@property (nonatomic,strong)UILabel * lab3;

@end

@implementation MCZhangBianRecordTableViewCell

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
    CGFloat K1= 0.166666666;
    CGFloat K2= 0.366666666;
    CGFloat K3= 0.222222222;
//    CGFloat K4= 0.244444444;
    CGFloat W = G_SCREENWIDTH-26;
    
    CGFloat W1=W*K1;
    CGFloat W2=W*K2;
    CGFloat W3=W*K3;
    CGFloat W4=W-W1-W2-W3;
    
    CGFloat H1=27;
    UIView  *back =[[UIView alloc]init];
    back.frame=CGRectMake(0, 0, W , H1);
    [self addSubview:back];
    
    /*
     * logo
     */
    _logoImgV=[[UILabel alloc]init];
    _logoImgV.backgroundColor=[UIColor orangeColor];
    _logoImgV.frame=CGRectMake(L, 0, H1, H1);
    [back addSubview:_logoImgV];
    _logoImgV.layer.cornerRadius=27/2.0;
    _logoImgV.clipsToBounds=YES;
    _logoImgV.textAlignment=NSTextAlignmentCenter;
    _logoImgV.font=[UIFont systemFontOfSize:14];
    _logoImgV.textColor=[UIColor whiteColor];

    
    UILabel * lab1=[[UILabel alloc]init];
    lab1 =[[UILabel alloc]init];
    lab1.textColor=RGB(136, 136, 136);
    lab1.font=[UIFont systemFontOfSize:font];
    lab1.text =@"加载中";
    lab1.textAlignment=NSTextAlignmentLeft;
    [back addSubview:lab1];
    lab1.frame=CGRectMake(W1, 0, W2, H1);
    _lab1=lab1;

    UILabel * lab2=[[UILabel alloc]init];
    lab2 =[[UILabel alloc]init];
    lab2.textColor=RGB(46, 46, 46);
    lab2.font=[UIFont systemFontOfSize:font];
    lab2.text =@"加载中";
    lab2.textAlignment=NSTextAlignmentCenter;
    [back addSubview:lab2];
    lab2.frame=CGRectMake(W1+W2, 0, W3, H1);
    _lab2=lab2;

    
    
    
    UILabel * lab3=[[UILabel alloc]init];
    lab3 =[[UILabel alloc]init];
    lab3.textColor=RGB(136, 136, 136);
    lab3.font=[UIFont systemFontOfSize:font];
    lab3.text =@"加载中";
    lab3.textAlignment=NSTextAlignmentCenter;
    [back addSubview:lab3];
    lab3.frame=CGRectMake(W1+W2+W3, 0, W4, H1);
    _lab3=lab3;


    _line=[[UIView alloc]init];
    _line.backgroundColor=RGB(237,237,237);
    [self addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_logoImgV.mas_centerX);
        make.top.equalTo(_logoImgV.mas_bottom).offset(0);
        make.width.mas_equalTo(0.5);
        make.bottom.equalTo(self.mas_bottom);
    }];
    _line.hidden=YES;
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

-(void)setDataSource:(MCUserAccountRecordDetailDataModel *)dataSource{
    
    _lab1.text=dataSource.InsertTime;
    _lab2.text=dataSource.UseMoney;
    _lab3.text=dataSource.ThenBalance;
    
    MCUserARecordModel * model=[MCRecordTool getAccountType:dataSource];
    _logoImgV.backgroundColor=model.color;
    _logoImgV.text=model.imgVName;
 
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


















