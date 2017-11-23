//
//  MCFavorableActivityCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/8/4.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCFavorableActivityCollectionViewCell.h"

@implementation MCFavorableActivityBlankCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}
-(void)initView{

    self.backgroundColor=[UIColor clearColor];
}
@end

@interface MCFavorableActivityCollectionViewCell()
@property (nonatomic,strong)UIView * backView;
@property (nonatomic,strong)UIImageView *imgV_logo;
@property (nonatomic,strong)UIButton * detailBtn;

@property (nonatomic,strong)UILabel * titleLab;
@property (nonatomic,strong)UILabel * tipLab;
@end

@implementation MCFavorableActivityCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    _titleLab.text=@"送100万活动";
    _tipLab.text=@"故事发生在非洲附近的大海上，主人公冷锋（吴京 饰）遭遇人生滑铁卢，被“开除军籍”，本想漂泊一生的他，正当他打算这么做的时候，一场突如其来的意外打破了他的计划，突然被卷入了一场非洲国家叛乱，本可以安全撤离，却因无法忘记曾经为军人的使命，孤身犯险冲回沦陷区，带领身陷屠杀中的同胞和难民，展开生死逃亡。随着斗争的持续，体内的狼性逐渐复苏，最终孤身闯入战乱区域，为同胞而战斗。";
    
}

-(void)initView{

    self.backgroundColor=[UIColor clearColor];
//    self.backgroundColor = RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
    
    _backView=[[UIView alloc]init];
    [self addSubview:_backView];
    _backView.layer.cornerRadius=10.0;
    _backView.clipsToBounds=YES;
    _backView.backgroundColor=[UIColor whiteColor];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(G_SCREENHEIGHT/667.0*333);
        make.width.mas_equalTo(G_SCREENWIDTH/375.0*250);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    _imgV_logo=[[UIImageView alloc]init];
    _imgV_logo.backgroundColor=[UIColor clearColor];
    _imgV_logo.image=[UIImage imageNamed:@"x_banner_01.jpg"];
    [_backView addSubview:_imgV_logo];
    [_imgV_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.top.equalTo(_backView.mas_top);
        make.height.mas_equalTo(140);
    }];
    
    _titleLab=[[UILabel alloc]init];
    [_backView addSubview:_titleLab];
    _titleLab.textColor=RGB(60, 140, 217);
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.top.equalTo(_imgV_logo.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    _tipLab=[[UILabel alloc]init];
    [_backView addSubview:_tipLab];
    _tipLab.numberOfLines=0;
    _tipLab.textColor=RGB(102, 102, 102);
    [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left).offset(10);
        make.right.equalTo(_backView.mas_right).offset(-10);
        make.top.equalTo(_titleLab.mas_bottom);
        make.bottom.equalTo(_backView.mas_bottom);
    }];
    
    
    _detailBtn=[[UIButton alloc]init];
    [self addSubview:_detailBtn];
    _detailBtn.backgroundColor=RGB(66, 162, 225);
    _detailBtn.layer.cornerRadius=10.0;
    _detailBtn.titleLabel.textColor=[UIColor whiteColor];
    [_detailBtn setTitle:@"点击进入" forState:UIControlStateNormal];
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.mas_equalTo(170);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_backView.mas_bottom).offset(30);
    }];
    


    
    
}


@end
