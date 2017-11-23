//
//  MCLotteryRecordCollectionViewCell.m
//  TLYL
//
//  Created by Canny on 2017/9/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryRecordCollectionViewCell.h"


@interface MCLotteryRecordCollectionViewCell ()

@property (nonatomic,strong)UIImageView *logoImgV;

@property (nonatomic,strong)UILabel *titleLab;

@end


@implementation MCLotteryRecordCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)relayOutCellWithDataSource:(id)dataSource andType:(NSInteger )type andIndex:(NSInteger )index {

    _titleLab.text =dataSource;
    if (type==1) {
        
        _logoImgV.layer.cornerRadius=self.bounds.size.width/2.0;
        _titleLab.font=[UIFont boldSystemFontOfSize:12];
        _titleLab.textColor=[UIColor whiteColor];
    }else if(type==2){
        
        _logoImgV.layer.cornerRadius=self.bounds.size.width/2.0;
        _titleLab.font=[UIFont boldSystemFontOfSize:12];
        _logoImgV.backgroundColor=[UIColor clearColor];
        _titleLab.textColor=RGB(143, 0, 210);
        _logoImgV.image=[UIImage imageNamed:@"MCLotteryRecordCollectionViewCell-xbg"];
        
    }else if (type==3){
        _titleLab.textColor=[UIColor whiteColor];
        _logoImgV.layer.cornerRadius=5;
        _titleLab.font=[UIFont boldSystemFontOfSize:12];
        
        if (index==0) {
            _logoImgV.backgroundColor=RGB(107, 117, 240);
        }else if (index==1){
            _logoImgV.backgroundColor=RGB(34, 174, 232);
        }else if (index==2){
            _logoImgV.backgroundColor=RGB(0, 214, 197);
        }else if (index==3){
            _logoImgV.backgroundColor=RGB(0, 215, 48);
        }else if (index==4){
            _logoImgV.backgroundColor=RGB(183, 216, 52);
        }else if (index==5){
            _logoImgV.backgroundColor=RGB(255, 187, 51);
        }else if (index==6){
            _logoImgV.backgroundColor=RGB(255, 109, 36);
        }else if (index==7){
            _logoImgV.backgroundColor=RGB(255, 43, 51);
        }else if (index==8){
            _logoImgV.backgroundColor=RGB(255, 40, 136);
        }else if (index==9){
            _logoImgV.backgroundColor=RGB(242, 32, 250);
        }
    }
    

}

-(void)initView{
    self.backgroundColor = [UIColor  clearColor];
    
    _logoImgV=[[UIImageView alloc]init];
    _logoImgV.backgroundColor=RGB(143, 0, 210);
    _logoImgV.layer.cornerRadius=self.bounds.size.width/2.0;
    _logoImgV.clipsToBounds=YES;
    
    [self addSubview:_logoImgV];
    
    [_logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    _titleLab =[[UILabel alloc]initWithFrame:CGRectZero];
    _titleLab.alpha=0.8;
    _titleLab.textColor=[UIColor whiteColor];
    _titleLab.font=[UIFont boldSystemFontOfSize:12];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    
}


@end
