//
//  MCZhuihaoRecordTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCZhuihaoRecordTableViewCell.h"
#import "MCDataTool.h"

@interface MCZhuihaoRecordTableViewCell ()

@property (nonatomic,strong)UILabel * czNameLab;
@property (nonatomic,strong)UILabel * timeLab;
@property (nonatomic,strong)UILabel * contentLab;
@property (nonatomic,strong)UILabel * stateLab;

@end

@implementation MCZhuihaoRecordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];

    _czNameLab =[[UILabel alloc]init];
    _czNameLab.textColor=RGB(46,46,46);
    _czNameLab.font=[UIFont systemFontOfSize:14];
    _czNameLab.text =@"加载中";
    _czNameLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_czNameLab];
    
    [_czNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(13);
        make.left.equalTo(self.mas_left).offset(12);
        make.width.mas_equalTo(100);
    }];
    
    _timeLab =[[UILabel alloc]init];
    _timeLab.textColor=RGB(102,102,102);
    _timeLab.font=[UIFont systemFontOfSize:12];
    _timeLab.text =@"追号时间：加载中";
    _timeLab.textAlignment=NSTextAlignmentLeft;
    [self  addSubview:_timeLab];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(34);
        make.left.equalTo(_czNameLab.mas_left).offset(0);
        make.width.mas_equalTo(200);
    }];
    
    _contentLab =[[UILabel alloc]init];
    _contentLab.textColor=RGB(102,102,102);
    _contentLab.font=[UIFont systemFontOfSize:12];
    _contentLab.text =@"加载中";
    _contentLab.textAlignment=NSTextAlignmentRight;
    [self  addSubview:_contentLab];
    
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_czNameLab.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-14);
        make.width.mas_equalTo(300);
    }];
    
    
    _stateLab =[[UILabel alloc]init];
    _stateLab.textColor=RGB(255,168,0);
    _stateLab.font=[UIFont systemFontOfSize:12];
    _stateLab.text =@"加载中";
    _stateLab.textAlignment=NSTextAlignmentRight;
    [self  addSubview:_stateLab];
    
    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_timeLab.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-14);
        make.width.mas_equalTo(100);
    }];
    
    
}

+(CGFloat)computeHeight:(id)info{
    
    return 66;
}

-(void)setDataSource:(MCUserChaseRecordDataModel *)dataSource{
    NSDictionary * dic = [MCDataTool MC_GetDic_CZHelper];
    _czNameLab.text = dic[dataSource.BetTb][@"name"];

    _timeLab.text=[NSString stringWithFormat:@"追号时间：%@",dataSource.InsertTime];

    NSString * str = [NSString stringWithFormat:@"剩余 %d 期 / 总 %d 期 ",[dataSource.CountSY intValue],[dataSource.CountQS intValue]];
    
    NSRange range1 = [str rangeOfString:[NSString stringWithFormat:@"余 %d",[dataSource.CountSY intValue]]];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:RGB(144,8,215) range:NSMakeRange(range1.location+1, range1.length-1)];

    
    _contentLab.attributedText=attri;

    
    
    
    //
    //OrderID	String
    //BetTb	Int	彩种 ID
    //CountQS	Int	总期数
    //CountSY	Int	剩余期数 见备注1
    //SumBetMoney	Number	投注金额
    //OrderState	Int	中奖状态
    //SumAwardMoney	Number	中奖金额
    //InsertTime	String	交易时间
    
    
    
//    关于 订单状态（或追号状态） 的说明：
//    当 剩余期数 countSY = 0，则为“已完成”
//    当 剩余期数 countSY != 0，则为“追号中…”
    if ([dataSource.CountSY integerValue]==0) {
        _stateLab.text=@"已完成";
        _stateLab.textColor=RGB(144,8,215);
        
    }else{
        _stateLab.text=@"追号中";
        _stateLab.textColor=RGB(255,168,0);
    }

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


















