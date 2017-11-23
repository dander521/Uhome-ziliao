//
//  MCLotteryDrawDetailsFooterView.m
//  TLYL
//
//  Created by MC on 2017/6/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCLotteryDrawDetailsFooterView.h"
#import "MCDataTool.h"
@interface MCLotteryDrawDetailsFooterView ()

@property(nonatomic,strong)UIButton * titleBtn;

@end

@implementation MCLotteryDrawDetailsFooterView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI{
    
    self.backgroundColor=RGB(48, 127, 207);
    
    _titleBtn=[[UIButton alloc]init];
    [_titleBtn setTitle:@"投注XXXX" forState:UIControlStateNormal];
    [self addSubview:_titleBtn];
    [_titleBtn addTarget:self action:@selector(action_PushToBet) forControlEvents:UIControlEventTouchUpInside];

    [self layOutConstraints];
    
}

-(void)action_PushToBet{
    if (self.block) {
        self.block();
    }
}

-(void)layOutConstraints{
    
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(50);
        make.right.equalTo(self.mas_right).offset(-50);
        make.height.mas_equalTo(44);
    }];
    
}

+(CGFloat)computeHeight:(id)info{
    return 44;
}

-(void)setDataSource:(id)dataSource{
    _dataSource=dataSource;
    
    if (dataSource) {
        [_titleBtn setTitle:[NSString stringWithFormat:@"投注%@",[MCDataTool MC_GetDic_CZHelper][dataSource][@"name"]] forState:UIControlStateNormal];
    }
    

}

    




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
