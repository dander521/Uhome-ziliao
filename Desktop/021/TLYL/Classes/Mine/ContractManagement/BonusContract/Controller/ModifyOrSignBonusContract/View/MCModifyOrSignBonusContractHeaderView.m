//
//  MCModifyOrSignBonusContractHeaderView.m
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyOrSignBonusContractHeaderView.h"
#import "MCContractMgtTool.h"
#import "MCModifyOrSignBonusContractCellView.h"


@interface MCModifyOrSignBonusContractHeaderView()

@property (nonatomic,strong)UIView * back;

@end

@implementation MCModifyOrSignBonusContractHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView * back = [[UIView alloc]init];
    [self addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-45);
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(15);
    }];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius=6;
    back.clipsToBounds=YES;
    _back=back;
    
    UILabel * lab1 = [self GetAdaptiveLable:CGRectMake(0, 15+15, G_SCREENWIDTH-26, 18) AndText:@"我的分红契约" andFont:12 andTextColor:RGB(102,102,102) andTextAlignment:NSTextAlignmentCenter];
    [self addSubview:lab1];

    UILabel *lab2 = [[UILabel alloc] init];
    lab2.textAlignment = NSTextAlignmentCenter;
    lab2.font = [UIFont boldSystemFontOfSize:12];
    lab2.textColor=RGB(102,102,102);
    [self addSubview:lab2];
    _lab2=lab2;
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(15);
    }];
    
}

-(void)setDataSource:(MCGetMyAndSubSignBounsContractDataModel *)dataSource{
    _dataSource = dataSource;
    _lab2.text=[NSString stringWithFormat:@""];
    CGFloat T = 43+15 ,H=75,W=G_SCREENWIDTH-60,L = 20;
    int i = 0;
    if (dataSource) {
        for (MCGetMyAndSubSignBounsContractDetailDataModel * model in _dataSource.MyContract) {
            MCModifyOrSignBonusContractCellView * cell = [[MCModifyOrSignBonusContractCellView alloc]init];
            cell.frame=CGRectMake(L, T+i*(75+10), W, H);
            [self addSubview:cell];
            cell.dataSouce=model;
            i++;
        }
    }
}


+(CGFloat)computeHeight:(MCGetMyAndSubSignBounsContractDataModel *)info{
    return 15+43 +(75+10)*info.MyContract.count +45;
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andFont:(CGFloat)font  andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment;
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.text = contentStr;
    contentLbl.textAlignment = textAlignment;
    contentLbl.font = [UIFont boldSystemFontOfSize:font];
    contentLbl.textColor=textColor;
    contentLbl.clipsToBounds=YES;
    
    return contentLbl;
}

@end

























