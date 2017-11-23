//
//  MCModifyOrSignBonusContractFooterView.m
//  TLYL
//
//  Created by MC on 2017/11/8.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCModifyOrSignBonusContractFooterView.h"
#import "MCContractMgtTool.h"
#import "MCModifyOrSignBonusContractCellView.h"


@interface MCModifyOrSignBonusContractFooterView()

@property (nonatomic,strong)UIButton * delete;

@end

@implementation MCModifyOrSignBonusContractFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor = [UIColor clearColor];
   
    UIButton * delete = [self GetBtnWithTitle:@"删除行" andBackColor:RGB(248,193,1) andCornerRadius:12.5 andFont:12 andTag:1001];
    [self addSubview:delete];
    _delete = delete;
    [delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-(G_SCREENWIDTH-26)/4.0);
        make.width.mas_offset(90);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.mas_bottom).offset(-71-41);
    }];
    
    UIButton * add = [self GetBtnWithTitle:@"添加行" andBackColor:RGB(248,193,1) andCornerRadius:12.5 andFont:12 andTag:1002];
    [self addSubview:add];
    [add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset((G_SCREENWIDTH-26)/4.0);
        make.width.mas_offset(90);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.mas_bottom).offset(-71-41);
    }];
    
    UIButton * save = [self GetBtnWithTitle:@"保存" andBackColor:RGB(144,8,215) andCornerRadius:6 andFont:14 andTag:1003];
    [self addSubview:save];
    [save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-41);
    }];
    
}

-(UIButton *)GetBtnWithTitle:(NSString *)title andBackColor:(UIColor*)backgroundColor andCornerRadius:(CGFloat)cornerRadius andFont:(CGFloat)font andTag:(NSInteger)tag{
   
    UIButton * btn =[[UIButton alloc]init];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.backgroundColor=backgroundColor;
    [self addSubview:btn];
    btn.titleLabel.font=[UIFont systemFontOfSize:font];
    [btn addTarget:self action:@selector(ClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=cornerRadius;
    btn.clipsToBounds=YES;
    btn.tag=tag;
    return btn;
}

-(void)ClickBtn:(UIButton *)btn{
    
    Type_MCModifyOrSignBonusContractFooterAction  type = MC_ModifyOrSignBonusContractFooterAction_Delete;
    
    if (btn.tag==1002) {
        type = MC_ModifyOrSignBonusContractFooterAction_Add;
    }else if (btn.tag==1003){
        type = MC_ModifyOrSignBonusContractFooterAction_Save;
    }
    
    if (self.footerActionBlock) {
        self.footerActionBlock(type);
    }
    
}

+(CGFloat)computeHeight:(id)info{
    return 126-10 + 41;
}

-(void)setDeleteBtnHidden:(BOOL)hidden{
    [_delete setHidden:hidden];
//    if (hidden) {
////        _delete.backgroundColor=RGB(<#__r#>, <#__g#>, <#__b#>)
//    }
}

@end

























