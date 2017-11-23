//
//  MCMCSystemNoticeDetailCell.m
//  TLYL
//
//  Created by MC on 2017/8/4.
//  Copyright © 2017年 TLYL01. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "MCMCSystemNoticeDetailCell.h"

@interface MCMCSystemNoticeDetailCell ()



/*
 * 标题
 */
@property (nonatomic,strong)UILabel * titleLab;

/*
 * 时间
 */
@property (nonatomic,strong)UILabel * timeLab;

/*
 * 分隔线
 */
@property (nonatomic,strong)UIView * lineView;


@property (nonatomic,weak)  UIWebView *web;

@end

@implementation MCMCSystemNoticeDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor whiteColor];
    
    
    /*
     * 标题
     */
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(68, 68, 68);
    _titleLab.font=[UIFont systemFontOfSize:16];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    
    /*
     * 时间
     */
    _timeLab =[[UILabel alloc]init];
    _timeLab.textColor=RGB(177, 177, 177);
    _timeLab.font=[UIFont systemFontOfSize:12];
    _timeLab.text =@"加载中";
    _timeLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_timeLab];

    

    
    /*
     * 画线
     */
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=RGB(239, 246, 253);
    [self addSubview:_lineView];
    
  
    UIWebView *web =[[UIWebView alloc] init];
    web.backgroundColor=[UIColor whiteColor];
    self.web = web;
    
    [self addSubview:web];
    [self layOutConstraints];
    
    
}

-(void)layOutConstraints{
    
   
    /*
     * 标题
     */
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.right.equalTo(self.mas_right).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.mas_equalTo(35);
    }];
    
    /*
     * 时间
     */
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(35);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(G_SCREENWIDTH-20);
    }];
    
    /*
     * 画线
     */
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(0.8);
        make.top.equalTo(self.mas_top).offset(70);
    }];
    
    
    [self.web mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}




+(CGFloat)computeHeight:(id)info{
    
    return G_SCREENHEIGHT-64;
}

-(void)setDataSource:(MCSystemNoticeDetailModel *)dataSource{
    
    _dataSource=dataSource;
    _titleLab.text =dataSource.NewsTitle;
    _timeLab.text =dataSource.InsertTime;
    
    [self.web loadHTMLString:dataSource.NewsContent baseURL:nil];


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



















