//
//  MCRechargeDetailExplainTableViewCell.m
//  TLYL
//
//  Created by MC on 2017/8/9.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeDetailExplainTableViewCell.h"
#import "XXLinkLabel.h"
#import "MCRechargeModel.h"
#import "MCPayWebViewController.h"
#import "MCRechargePayAliTestViewController.h"
#import "UIView+MCParentController.h"

#define RechargeDetailTip @"1、为了保证充值能及时到账请先转账成功后再提交充值订单。\n\n2、本系统支持支付宝、网银、手机银行、跨行转账。\n\n3、我司收款卡可能会随时进行更换，每次充值时需从充值页面重新获取，不能通过历史交易记录中所保留的卡号转账，如果转错卡号，损失有客户自行承担。\n\n4、正常转账成功后1-3分钟内资金将会自动到账(遇银行延迟除外)，超时未到请联系客服咨询。"
#define ZhaoShang_RechargeDetailTip @"1、为了保证充值能及时到账请先转账成功后再提交充值订单。【支付宝充值流程演示】\n\n2、本系统支持支付宝、网银、手机银行、跨行转账。\n\n3、我司收款卡可能会随时进行更换，每次充值时需从充值页面重新获取，不能通过历史交易记录中所保留的卡号转账，如果转错卡号，损失有客户自行承担。\n\n4、正常转账成功后1-3分钟内资金将会自动到账(遇银行延迟除外)，超时未到请联系客服咨询。"


@interface MCRechargeDetailExplainTableViewCell ()

@property (nonatomic,strong)UILabel *titleLab;
@property (nonatomic,strong)XXLinkLabel *tipLab;


@end

@implementation MCRechargeDetailExplainTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initView];
    }
    return self;
}

- (void)initView{
    
    self.backgroundColor=[UIColor clearColor];
    
    _titleLab =[[UILabel alloc]init];
    _titleLab.textColor=RGB(144,8,215);
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.text =@"充值说明";
    _titleLab.textAlignment=NSTextAlignmentCenter;
    [self  addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(45);
    }];
    
    _tipLab=[[XXLinkLabel alloc]init];
    [self addSubview:_tipLab];
    _tipLab.textColor=RGB(102, 102, 102);
    _tipLab.font=[UIFont systemFontOfSize:14];
    _tipLab.text =RechargeDetailTip;
    _tipLab.numberOfLines=0;
    _tipLab.textAlignment=NSTextAlignmentLeft;
    [_tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    MCRechargeModel * model=dataSource;
    
    
    
    
    //招商银行  提供单独的支付宝支付
    if ([model.BankCode isEqualToString:@"cmb"]) {

        _tipLab.text =ZhaoShang_RechargeDetailTip;
        
        [_tipLab addRegularString:@"【支付宝充值流程演示】"];
        
        _tipLab.linkTextColor=RGB(144,8,215);
        
//        _tipLab.selectedBackgroudColor=RGB(69, 142, 226);
        
        _tipLab.regularType = XXLinkLabelRegularTypeAboat | XXLinkLabelRegularTypeTopic | XXLinkLabelRegularTypeUrl;
        
        _tipLab.regularLinkClickBlock = ^(NSString *clickedString) {
            
            MCRechargePayAliTestViewController * vc = [[MCRechargePayAliTestViewController alloc]init];
            
            [[UIView MCcurrentViewController].navigationController pushViewController:vc animated:YES];
            
            NSLog(@"----block点击了文字----\n%@",clickedString);
            
        };
        
    }
    

    
}
//http链接点击   model内设置链接的对应点击
- (void)labelLinkClickLinkInfo:(XXLinkLabelModel *)linkInfo linkUrl:(NSString *)linkUrl{
    
}

//http链接点击   model内设置链接的对应长按
- (void)labelLinkLongPressLinkInfo:(XXLinkLabelModel *)linkInfo linkUrl:(NSString *)linkUrl{
    
}

- (NSArray *)getTestMessages {
    
    
    NSMutableArray *models = [NSMutableArray array];
//    for (int i = 0; i < 10; i++) {
        XXLinkLabelModel *messageModel = [[XXLinkLabelModel alloc]init];
        messageModel.message=@"【支付宝充值流程演示】";
        [models addObject:messageModel];
//    }
    return models;
}




+(CGFloat)computeHeight:(id)info{
    MCRechargeModel * model=info;
    //招商银行  提供单独的支付宝支付
    if ([model.BankCode isEqualToString:@"cmb"]) {

        return 45+[MCRechargeDetailExplainTableViewCell boundingALLRectWithSize:ZhaoShang_RechargeDetailTip Font:[UIFont systemFontOfSize:14] Size:CGSizeMake(G_SCREENWIDTH-20, 1000)].height;
        
    }

    
    return 45+[MCRechargeDetailExplainTableViewCell boundingALLRectWithSize:RechargeDetailTip Font:[UIFont systemFontOfSize:14] Size:CGSizeMake(G_SCREENWIDTH-20, 1000)].height;
}

+(CGSize) boundingALLRectWithSize:(NSString*) txt Font:(UIFont*) font Size:(CGSize) size{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:txt];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    [style setLineSpacing:2.0f];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [txt length])];
    
    CGSize realSize = CGSizeZero;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    CGRect textRect = [txt boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style} context:nil];
    realSize = textRect.size;
#else
    realSize = [txt sizeWithFont:font constrainedToSize:size];
#endif
    
    realSize.width = ceilf(realSize.width);
    realSize.height = ceilf(realSize.height);
    return realSize;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
