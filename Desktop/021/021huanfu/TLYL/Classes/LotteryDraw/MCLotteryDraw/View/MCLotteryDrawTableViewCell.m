//
//  MCLotteryDrawTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/16.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryDrawTableViewCell.h"
#import "MCDataTool.h"
@interface MCLotteryDrawTableViewCell ()

/*
 * back
 */
//@property (nonatomic,strong)UIImageView * backImgV;

/*
 * 彩种logo
 */
@property (nonatomic,strong)UIImageView * logoImgV;

/*
 * 彩种名称
 */
@property (nonatomic,strong)UILabel * titleLab;
/*
 * 开奖描述
 */
@property (nonatomic,strong)UILabel * tipLab;


/*
 * 箭头
 */
@property (nonatomic,strong)UIImageView * arrowImgV;

@property (nonatomic,strong)NSDictionary * cZHelperDic;

@property (nonatomic,strong)UIView * lineView;

@end

@implementation MCLotteryDrawTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
//    _backImgV=[[UIImageView alloc]init];
//    [self addSubview:_backImgV];
//    _backImgV.image=[UIImage imageNamed:@"lottery-Notice-background"];
//    _backImgV.frame=CGRectMake(10, 0, G_SCREENWIDTH-20, 75);
    
    
    
    /*
     * 彩种logo
     */
    _logoImgV=[[UIImageView alloc]init];
    [self addSubview:_logoImgV];
    _logoImgV.frame=CGRectMake(15, 12.5, 50, 50);

    
    
    /*
     * 彩种名称
     */
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=[UIColor grayColor];
    _titleLab.font=[UIFont systemFontOfSize:16];
    _titleLab.text =@"加载中";
    _titleLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_titleLab];
    
    /*
     * 开奖描述
     */
    _tipLab =[[UILabel alloc]init];
    _tipLab.textColor=[UIColor grayColor];
    _tipLab.font=[UIFont systemFontOfSize:12];
    _tipLab.text =@"加载中";
     _tipLab.numberOfLines = 1;
    _tipLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_tipLab];
   
  
    
    /*
     * 箭头
     */
    _arrowImgV=[[UIImageView alloc]init];
    [self addSubview:_arrowImgV];
    _arrowImgV.image=[UIImage imageNamed:@"kj-more"];
    
    /*
     * 画线
     */
    _lineView=[[UIView alloc]init];
    _lineView.backgroundColor=RGB(239, 246, 253);
    [self addSubview:_lineView];

    [self layOutConstraints];
    
    
}

-(void)layOutConstraints{
    
  
    
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.right.equalTo(self.mas_right).offset(-30);
        make.left.equalTo(self.mas_left).offset(80);
        make.height.mas_equalTo(20);
    }];
    
    [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-30);
        make.left.equalTo(self.mas_left).offset(80);
    }];
    
  
    
    /*
     * 箭头
     */
    [_arrowImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(32*0.5);
        make.width.mas_equalTo(32*0.5);
    }];

    /*
     * 画线
     */
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_logoImgV.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(0.8);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

-(void)setDataSource:(MCUserDefinedLotteryCategoriesModel*)dataSource{
    _dataSource=dataSource;
    if (dataSource) {
        NSDictionary * dic=self.cZHelperDic[dataSource.LotteryID];
        _titleLab.text =dic[@"name"];
        _logoImgV.image=[UIImage imageNamed:dic[@"logo"]];
        _tipLab.text =dic[@"KaiJiangTip"];
    }
    
}


-(NSDictionary *)cZHelperDic{
    if (!_cZHelperDic) {
        _cZHelperDic=[MCDataTool MC_GetDic_CZHelper];
    }
    return _cZHelperDic;
}


+(CGFloat)computeHeight:(id)info{
    return 80;
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













