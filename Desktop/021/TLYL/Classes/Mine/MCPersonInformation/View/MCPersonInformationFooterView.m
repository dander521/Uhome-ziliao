//
//  MCPersonInformationFooterView.m
//  TLYL
//
//  Created by MC on 2017/6/14.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCPersonInformationFooterView.h"
#import "MCMineInfoModel.h"
@interface MCPersonInformationFooterView ()

@property (nonatomic,strong)UIButton * saveBtn;

@end
@implementation MCPersonInformationFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}



-(void)createUI{
    
    self.backgroundColor=[UIColor clearColor];
    //保存
    _saveBtn=[[UIButton alloc]init];
    [self setFooter:_saveBtn];
    
    
    
}

/*
 * 点击 保存
 */
-(void)action_Save{
    
    if ([self.delegate respondsToSelector:@selector(savePersonalInformation)]) {
        [self.delegate savePersonalInformation];
    }
    
}


-(void)setFooter:(UIButton *)btn{
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    _saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    _saveBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_saveBtn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
    [_saveBtn setTitle:@"确定" forState:UIControlStateNormal];
//    [_saveBtn setImage:[UIImage imageNamed:@"Button_Determin_Right"] forState:UIControlStateNormal];
//    [_saveBtn setBackgroundColor:RGB(80, 141, 207)];
    [self addSubview:_saveBtn];
    [_saveBtn addTarget:self action:@selector(action_Save) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.layer.cornerRadius=10.0;
    _saveBtn.clipsToBounds=YES;
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(50);
    }];
}

-(void)relayOutUI{
    MCMineInfoModel *mineInfoModel = [MCMineInfoModel sharedMCMineInfoModel];
    if ((mineInfoModel.EMail.length>0)&&(mineInfoModel.Mobile.length>0)) {
        _saveBtn.hidden=YES;
    }else{
        _saveBtn.hidden=NO;
    }
    
}

+(CGFloat)computeHeight:(id)info{
    return 80;
}


@end










