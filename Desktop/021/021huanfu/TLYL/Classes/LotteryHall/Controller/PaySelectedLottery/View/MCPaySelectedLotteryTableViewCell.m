//
//  MCPaySelectedLotteryTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/6/15.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPaySelectedLotteryTableViewCell.h"
#import "MCBetModel.h"

#pragma mark MCPaySelectedLotteryTableViewCell Implementation

@interface MCPaySelectedLotteryTableViewCell ()


/**选号码*/
@property (nonatomic,strong)UIButton * lab_BallNumbers;
/**玩法名称*/
@property (nonatomic,strong)UIButton * lab_WFName;
/**其他*/
@property (nonatomic,strong)UIButton * lab_Other;
/**购买金额*/
@property (nonatomic,strong)UIButton * lab_PayMoney;

@end

@implementation MCPaySelectedLotteryTableViewCell
#pragma mark View creation & layout

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        [self initViews:YES];
        [self createUI];
    }
    return self;
}

-(void)setBtn:(UIButton *)btn WithColor:(UIColor*)color andFont:(NSInteger)font andAlignment:(UIControlContentHorizontalAlignment)alignment{
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    [btn setTitle:@"加载中" forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = alignment;
    [self  addSubview:btn];
}
-(void)createUI{
    
    self.backgroundColor=[UIColor whiteColor];
    /*
     * 玩法名称
     */
    _lab_WFName =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_lab_WFName WithColor:RGB(46, 46, 46) andFont:12 andAlignment:UIControlContentHorizontalAlignmentLeft];
    
    /*
     * 其他
     */
    _lab_Other =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_lab_Other WithColor:RGB(136, 136, 136) andFont:12 andAlignment:UIControlContentHorizontalAlignmentRight];
    
    /*
     * 选号码
     */
    _lab_BallNumbers =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_lab_BallNumbers WithColor:RGB(143, 0, 210) andFont:14 andAlignment:UIControlContentHorizontalAlignmentLeft];
    
    /*
     * 单价
     */
    _lab_PayMoney =[[UIButton alloc]initWithFrame:CGRectZero];
    [self setBtn:_lab_PayMoney WithColor:RGB(249,84,83) andFont:20 andAlignment:UIControlContentHorizontalAlignmentRight];
    

    [self layOutConstraints];
    
    
}


-(void)layOutConstraints{
    
    /*
     * 玩法名称
     */
    [_lab_WFName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(15);
        make.right.equalTo(self.mas_right).offset(-100);
        make.height.mas_equalTo(13);

    }];
    
    /*
     * 其他
     */
    [_lab_Other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lab_WFName.mas_centerY);
        make.left.equalTo(self.mas_left).offset(80);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    /*
     * 选号码
     */
    [_lab_BallNumbers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.right.equalTo(self.mas_right).offset(-100);
        make.height.mas_equalTo(16);
    }];
    
    /*
     * 单价
     */
    [_lab_PayMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(_lab_BallNumbers.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(30);
    }];

}

-(void)setDataSource:(MCPaySelectedCellModel*)dataSource{
    _dataSource=dataSource;
    
    [_lab_BallNumbers setTitle:_dataSource.haoMa forState:UIControlStateNormal];
    
    /**玩法名称*/
     [_lab_WFName setTitle:_dataSource.WFName forState:UIControlStateNormal];
    
    NSString * fandian = [_dataSource.showRebate stringByReplacingOccurrencesOfString:@"," withString:@"~"];

    [_lab_Other setTitle:[NSString stringWithFormat:@"%@注，%@倍，%@，[%@]",_dataSource.stakeNumber,_dataSource.multiple,_dataSource.yuanJiaoFen,fandian] forState:UIControlStateNormal];

    /**购买金额*/
    [_lab_PayMoney setTitle:[NSString stringWithFormat:@"%@元",GetRealSNum(_dataSource.payMoney)] forState:UIControlStateNormal];

    
}

+(CGFloat)computeHeight:(id)info{
    
    return 70;
    
}

@end

























