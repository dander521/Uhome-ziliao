//
//  MCPullMenuCollectionViewCell.m
//  TLYLSF
//
//  Created by Canny on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCPullMenuCollectionViewCell.h"


@interface MCPullMenuCollectionViewCell ()
@property (nonatomic,strong)UILabel *lab_title;
@property (nonatomic,strong)UIImageView * imageV;

@end

@implementation MCPullMenuCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initView];
    }
    return self;
}

-(void)relayOutData:(MCPullMenuCollectionCellModel *)dataSource withType:(FinishOrEditType)type{
    _dataSource=dataSource;
    _lab_title.text =[dataSource.dic objectForKey:@"name" ];
    if (type==FinishType) {
        _imageV.hidden=YES;
        [self setFinish_CellType:dataSource];
    }else if(type==EditType) {
        [self setEdit_CellType:dataSource];
        if (dataSource.type==HadSelectedType) {
            _imageV.hidden=YES;
        }else{
            _imageV.hidden=NO;
        }
    }
}

-(void)initView{
    
    _lab_title =[[UILabel alloc]initWithFrame:CGRectZero];
    _lab_title.font=[UIFont systemFontOfSize:10];
    _lab_title.textColor=RGB(102, 102, 102);
    self.backgroundColor=RGB(246, 246, 246);
    self.layer.borderColor = RGB(220, 220, 220).CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius=25/2.0;
    _lab_title.text =@"加载中...";
    _lab_title.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_lab_title];
    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _imageV=[[UIImageView alloc]init];
    [self addSubview:_imageV];
    _imageV.image=[UIImage imageNamed:@"UserDefinedCZ+"];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-2);
        make.top.equalTo(self.mas_top).offset(2);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    

}

-(void)setFinish_CellType:(MCPullMenuCollectionCellModel *)dataSource{
    //    WithoutSelectedType,          //没有被选择的状态  灰色黑子
    //    HadSelectedType=0,            //已经选择过状态 灰色白字
    //    UsingSelectedType             //正在使用的状态  黄色底 白字
    if (dataSource.type==WithoutSelectedType||dataSource.type==HadSelectedType) {
        _lab_title.textColor=RGB(102, 102, 102);
        self.backgroundColor=RGB(246, 246, 246);
        self.layer.borderColor = RGB(220, 220, 220).CGColor;
        
    }else if (dataSource.type==UsingSelectedType){
        
        _lab_title.textColor=RGB(255, 255, 255);
        self.backgroundColor=RGB(250, 166, 46);
        self.layer.borderColor = RGB(251, 152, 41).CGColor;
    }
}


-(void)setEdit_CellType:(MCPullMenuCollectionCellModel *)dataSource{
//    WithoutSelectedType,          //没有被选择的状态  灰色黑子
//    HadSelectedType=0,            //已经选择过状态 灰色白字
//    UsingSelectedType             //正在使用的状态  黄色底 白字
    if (dataSource.type==WithoutSelectedType) {
        _lab_title.textColor=RGB(102, 102, 102);
        self.backgroundColor=RGB(246, 246, 246);
        self.layer.borderColor = RGB(220, 220, 220).CGColor;
        
    }else if (dataSource.type==HadSelectedType){
        
        _lab_title.textColor=RGB(255, 255, 255);
        self.backgroundColor=RGB(193,193,193);
        self.layer.borderColor=RGB(193,193,193).CGColor;
        
    }else if (dataSource.type==UsingSelectedType){
        _lab_title.textColor=RGB(255, 255, 255);
        self.backgroundColor=RGB(250, 166, 46);
        self.layer.borderColor = RGB(251, 152, 41).CGColor;
    }
}

- (void)setSelected:(BOOL)selected{
    
}



@end





































