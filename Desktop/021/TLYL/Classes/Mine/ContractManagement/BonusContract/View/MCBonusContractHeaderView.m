//
//  MCBonusContractHeaderView.m
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBonusContractHeaderView.h"
#import "MCContractMgtTool.h"
#import "MCBonusContractHeaderCellView.h"

@interface MCBonusContractHeaderView()
@property (nonatomic,strong)UIButton * btn;
@property (nonatomic,strong)UIView * back;
@property (nonatomic,strong)UIButton * ContractBtn;
@end

@implementation MCBonusContractHeaderView

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
        make.bottom.equalTo(self.mas_bottom).offset(-(13*2+25));
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(15);
    }];
    back.backgroundColor = [UIColor whiteColor];
    back.layer.cornerRadius=6;
    back.clipsToBounds=YES;
    _back=back;
    
    UILabel * lab = [self GetAdaptiveLable:CGRectMake(20, 15+15, 100, 18) AndText:@"我的契约" andFont:12 andTextColor:RGB(46,46,46) andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lab];
    
    UIButton * btn = [[UIButton alloc]init];
    [self addSubview:btn];
    btn.backgroundColor=RGB(248,193,1);
    btn.layer.cornerRadius=12.5;
    btn.clipsToBounds=YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"一键结算" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:12];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-13);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_offset(25);
        make.width.mas_offset(90);
    }];
    [btn addTarget:self action:@selector(jiesuan) forControlEvents:UIControlEventTouchUpInside];
    _btn=btn;
    _btn.hidden=YES;
    
    
    UIButton * ContractBtn = [[UIButton alloc]init];
    [self addSubview:ContractBtn];
    [ContractBtn setTitleColor:RGB(144,8,215) forState:UIControlStateNormal];
    [ContractBtn setTitle:@"新契约" forState:UIControlStateNormal];
    ContractBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    ContractBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    ContractBtn.backgroundColor=[UIColor clearColor];
    ContractBtn.frame=CGRectMake(G_SCREENWIDTH-60-50+20, 15+15, 50, 18);
    [ContractBtn addTarget:self action:@selector(GoToNewContract) forControlEvents:UIControlEventTouchUpInside];
    _ContractBtn=ContractBtn;
    _ContractBtn.hidden=YES;
}

-(void)setDataSource:(MCMyBonusContractListDataModel *)dataSource{
    _dataSource = dataSource;
    
    CGFloat T = 43+15 ,H=75,W=G_SCREENWIDTH-60,L = 20;
    int i = 0;
    if (dataSource) {
        
        for (MCMyBonusContractListDeatailDataModel * model in _dataSource.ContractContentModels) {
            MCBonusContractHeaderCellView * cell = [[MCBonusContractHeaderCellView alloc]init];
            cell.frame=CGRectMake(L, T+i*(75+10), W, H);
            [self addSubview:cell];
            cell.dataSouce=model;
            i++;
        }
    }
}

-(void)setLockState:(NSString *)lockState{
    _lockState =lockState;
    //        是否显示“一键结算”（1：显示，0：不显示）
    if ([lockState intValue]==1) {
        _btn.hidden=NO;
        [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-(13*2+25)-10);
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(15);
        }];
        
        
    }else{
        _btn.hidden=YES;
        [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(15);
        }];
    }
}

+(CGFloat)computeHeight:(MCMyBonusContractListDataModel *)info andLockState:(NSString *)LockState{
    
    if (LockState) {
        //        是否显示“一键结算”（1：显示，0：不显示）
        if ([LockState intValue]==1) {
            return 15+ 43+88*info.ContractContentModels.count +13*2+25  +10;
        }
    }
    return 15+ 43+88*info.ContractContentModels.count +10;
}

-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andFont:(CGFloat)font  andTextColor:(UIColor *)textColor andTextAlignment:(NSTextAlignment)textAlignment;
{
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.text = contentStr;
    contentLbl.textAlignment = textAlignment;
    contentLbl.font = [UIFont systemFontOfSize:font];
    contentLbl.textColor=textColor;
    contentLbl.clipsToBounds=YES;
    
    return contentLbl;
}

-(void)jiesuan{
    if (self.settleBlock) {
        self.settleBlock();
    }
}
-(void)GoToNewContract{
    if (self.goToContractBlock) {
        self.goToContractBlock();
    }
}


-(void)setNewState:(BOOL)isState{
    _ContractBtn.hidden=isState;
}

@end
























