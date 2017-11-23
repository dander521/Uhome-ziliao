//
//  MCPullMenuSelectedCollectionViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPullMenuSelectedCollectionViewCell.h"

@interface MCPullMenuSelectedCollectionViewCell ()

@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UIImageView * imageV;

@end

@implementation MCPullMenuSelectedCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)relayOutData:(NSDictionary *)dataSource withType:(FinishOrEditType)type{
    _dataSource=dataSource;
    _lab_title.text =[NSString stringWithFormat:@"%@_%@",dataSource[@"typeName"],dataSource[@"name"]];
    if (type==FinishType) {
        _imageV.hidden=YES;
    }else if(type==EditType) {
        _imageV.hidden=NO;
    }
}

-(void)initView{
    
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.font=[UIFont systemFontOfSize:10];
    
    _lab_title.textColor=RGB(102, 102, 102);
    self.backgroundColor=RGB(246, 246, 246);
    self.layer.borderColor = RGB(213,213,213).CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius=self.bounds.size.height/2.0;
    self.clipsToBounds=YES;
    _lab_title.text =@"加载中...";
    _lab_title.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_lab_title];
    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _imageV=[[UIImageView alloc]init];
    [self addSubview:_imageV];
    _imageV.image=[UIImage imageNamed:@"UserDefinedCZ-"];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-2);
        make.top.equalTo(self.mas_top).offset(2);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    
    
}
- (void)setSelected:(BOOL)selected{
    
}

-(void)setCellSelected:(BOOL)selected{
    if (selected) {
        _lab_title.textColor=RGB(255, 255, 255);
        self.backgroundColor=RGB(250, 166, 46);
        self.layer.borderColor = RGB(251, 152, 41).CGColor;
        
    }else{
        _lab_title.textColor=RGB(102, 102, 102);
        self.backgroundColor=RGB(246, 246, 246);
        self.layer.borderColor = RGB(213,213,213).CGColor;
        
    }
}

@end
