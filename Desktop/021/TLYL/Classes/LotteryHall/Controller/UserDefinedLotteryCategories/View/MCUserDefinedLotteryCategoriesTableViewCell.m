//
//  MCUserDefinedLotteryCategoriesTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCUserDefinedLotteryCategoriesTableViewCell.h"
#import "MCDataTool.h"
#import "UIView+MCParentController.h"
#import "MCPickNumberViewController.h"

@interface MCUserDefinedLotteryCategoriesTableViewCell ()

/*
 * 彩种logo
 */
@property(nonatomic,strong)UIImageView * logoImgV;


/*
 * 彩种名称
 */
@property(nonatomic,strong)UILabel * nameLab;


@property(nonatomic,strong)MCUserDefinedLotteryCategoriesModel * model;

/*
 * 开奖号
 */
@property(nonatomic,strong)UILabel * lotteryNumberLab;


/*
 * btn  用来控制用户点击响应区域
 */
@property (nonatomic,strong)UIButton * noneBtn;
/*
 * 跳转投注
 */
@property (nonatomic,strong)UIButton * btnTZ;
@property (nonatomic,strong)NSDictionary * cZHelperDic;
@end

@implementation MCUserDefinedLotteryCategoriesTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    _model=[[MCUserDefinedLotteryCategoriesModel alloc]init];
    
    self.backgroundColor=[UIColor whiteColor];
    /*
     * 彩种logo
     */
    _logoImgV=[[UIImageView alloc]init];
    _logoImgV.backgroundColor=[UIColor clearColor];
    [self addSubview:_logoImgV];
    
    /*
     * 彩种名称
     */
    _nameLab=[[UILabel alloc]init];
    _nameLab.text=@"加载中...";
    _nameLab.font=[UIFont systemFontOfSize:14];
    _nameLab.textColor=RGB(68, 68, 68);
    [self addSubview:_nameLab];
    
    
    /*
     * 开奖号
     */
    _lotteryNumberLab=[[UILabel alloc]init];
    _lotteryNumberLab.text=@"加载中...";
    _lotteryNumberLab.font=[UIFont systemFontOfSize:12];
    _lotteryNumberLab.textColor=RGB(165, 165, 165);
    [self addSubview:_lotteryNumberLab];
    
    /*
     * 选中图标
     */
    _selectedBtn=[[UIButton alloc]init];
    _selectedBtn.userInteractionEnabled=NO;
    [self addSubview:_selectedBtn];
    [_selectedBtn setImage:[UIImage imageNamed:@"notSelected"] forState:UIControlStateNormal];
    [_selectedBtn setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
    [_selectedBtn addTarget:self action:@selector(action_Selected:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    _btnTZ=[[UIButton alloc]init];
    _btnTZ.backgroundColor=[UIColor clearColor];
    [self addSubview:_btnTZ];
    
    _noneBtn=[[UIButton alloc]init];
    _noneBtn.backgroundColor=[UIColor clearColor];
    [self addSubview:_noneBtn];
    
    [_btnTZ addTarget:self action:@selector(gotoTZ) forControlEvents:UIControlEventTouchUpInside];
    
    [self layOutConstraints];
    
}
-(void)gotoTZ{
    MCPickNumberViewController *pickVC =  [[MCPickNumberViewController alloc] init];
    pickVC.lotteriesTypeModel = _dataSource;
    [[UIView MCcurrentViewController].navigationController pushViewController:pickVC animated:YES];
}
-(void)layOutConstraints{
    
    /*
     * 彩种logo
     */
    [_logoImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        
    }];
    
    
    [_btnTZ mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        
    }];
    
    /*
     * 彩种名称
     */
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_logoImgV.mas_top).offset(5);
        make.right.equalTo(self.mas_right).offset(-10);
        make.left.equalTo(_logoImgV.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    /*
     * 开奖号
     */
    [_lotteryNumberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.mas_bottom).offset(5);
        make.right.equalTo(self.mas_right).offset(-60);
        make.left.equalTo(_logoImgV.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    /*
     * 选中图标
     */
    [_selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
    }];
    
    
    [_noneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_btnTZ.mas_right).offset(0);
        make.top.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(G_SCREENWIDTH/2.0);
        
    }];
    
    
    
}

/*
 * 选中彩种
 */
-(void)action_Selected:(UIButton *)btn{
    
    //    model.categoryID=[NSString stringWithFormat:@"%ld",(long)btn.tag];
    //    model.categoryName=_lab_name.text;
    
    if (_selectedBtn.selected) {
        
        [_selectedBtn setSelected:NO];
        _model.isSelected=0;
        
    }else{
        
        [_selectedBtn setSelected:YES];
        _model.isSelected=1;
    }
    
    if (self.block) {
        self.block(_model);
    }
}


+(CGFloat)computeHeight:(id)info{
    return 78;
}
-(NSDictionary *)cZHelperDic{
    if (!_cZHelperDic) {
        _cZHelperDic=[MCDataTool MC_GetDic_CZHelper];
    }
    return _cZHelperDic;
}
-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    
    
    MCUserDefinedLotteryCategoriesModel * Cmodel=(MCUserDefinedLotteryCategoriesModel*)dataSource;
    _model=Cmodel;
    if (Cmodel.isSelected) {
        [_selectedBtn setSelected:YES];
    }else{
        [_selectedBtn setSelected:NO];
    }
    _nameLab.text=[NSString stringWithFormat:@"%@",Cmodel.name];
    _selectedBtn.tag=[Cmodel.LotteryID integerValue];
//    _lotteryNumberLab.text=@"开奖号：9，9，9，9，9";
    _logoImgV.image=[UIImage imageNamed:_model.logo];
    NSDictionary * dic=self.cZHelperDic[Cmodel.LotteryID];
    _lotteryNumberLab.text =dic[@"KaiJiangTip"];
//    /*
//     * 设置彩种名称富文本
//     */
//    NSRange range_categoryName = [_nameLab.text rangeOfString:@"20179999999期"];
//    [self setTextColor:_nameLab FontNumber:[UIFont systemFontOfSize:12] AndRange:range_categoryName AndColor:RGB(165, 165, 165)];
    
//    /*
//     * 设置开奖号的富文本
//     */
//    NSRange range_lotteryNumber = [_lotteryNumberLab.text rangeOfString:@"9，9，9，9，9"];
//    [self setTextColor:_lotteryNumberLab FontNumber:[UIFont systemFontOfSize:12] AndRange:range_lotteryNumber AndColor:RGB(76, 142, 208)];
    
}

//设置不同字体颜色
-(void)setTextColor:(UILabel *)label FontNumber:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    label.attributedText = str;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
}

@end





































