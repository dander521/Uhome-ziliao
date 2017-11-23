//
//  MCBuyLotteryCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/9/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBuyLotteryCollectionViewCell.h"
#import "MCDataTool.h"

@interface MCBuyLotteryCollectionViewCell ()
@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UIImageView * imgVLogo;
@property (nonatomic,strong)NSDictionary * cZHelperDic;

@end

@implementation MCBuyLotteryCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)setDataSource:(MCUserDefinedLotteryCategoriesModel*)dataSource{
    
    _dataSource=dataSource;
    if (dataSource) {
        _imgVLogo.hidden=NO;
        _lab_title.hidden=NO;
        NSString * name=self.cZHelperDic[dataSource.LotteryID][@"name"];
        NSString * logo=self.cZHelperDic[dataSource.LotteryID][@"logo"];
        _lab_title.text=name;
        _imgVLogo.image=[UIImage imageNamed:logo];
    }else{
        _imgVLogo.hidden=YES;
        _lab_title.hidden=YES;
    }
    
    
}
-(NSDictionary *)cZHelperDic{
    if (!_cZHelperDic) {
        _cZHelperDic=[MCDataTool MC_GetDic_CZHelper];
    }
    return _cZHelperDic;
}
-(void)initView{
    
    self.backgroundColor=[UIColor whiteColor];
    
    
    _imgVLogo=[[UIImageView alloc]init];
    [self addSubview:_imgVLogo];
    _imgVLogo.layer.cornerRadius=15;
    _imgVLogo.clipsToBounds=YES;
    [_imgVLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(20);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(45);
    }];
    
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.font=[UIFont systemFontOfSize:14];
    _lab_title.textColor=RGB(46, 46, 46);
    _lab_title.text =@"加载中...";
    _lab_title.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_lab_title];
    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.left.and.right.equalTo(self);
        make.top.equalTo(_imgVLogo.mas_bottom).offset(10);
        
    }];
    
}
- (void)setSelected:(BOOL)selected{
//    if (selected) {
//        _lab_title.textColor=RGB(255, 255, 255);
//        self.backgroundColor=RGB(250, 166, 46);
//        self.layer.borderColor = RGB(251, 152, 41).CGColor;
//    }else{
//        _lab_title.textColor=RGB(102, 102, 102);
//        self.backgroundColor=RGB(246, 246, 246);
//        self.layer.borderColor = RGB(220, 220, 220).CGColor;
//    }
}


+(CGFloat)computeHeight:(id)info{
    
    CGFloat W = (G_SCREENWIDTH-2)/3.0;
    return W;
}
@end





































