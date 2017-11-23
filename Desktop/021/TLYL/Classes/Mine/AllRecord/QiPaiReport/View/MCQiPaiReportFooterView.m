//
//  MCQiPaiReportFooterView.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaiReportFooterView.h"
#import "MCButton.h"

@interface MCQiPaiReportFooterView ()
@property (nonatomic,strong)MCButton *btn1;
@property (nonatomic,strong)MCButton *btn2;
@end

@implementation MCQiPaiReportFooterView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    self.backgroundColor=[UIColor whiteColor];

    NSArray *botArr = @[@"个人报表",@"团队报表"];
    for (NSInteger i = 0; i<botArr.count; i++) {
        MCButton *btn = [[MCButton alloc] initWithFrame:CGRectMake(i*G_SCREENWIDTH*0.5, 0, G_SCREENWIDTH*0.5, 48)];
        [self addSubview:btn];
        [btn setTitle:botArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(144, 8, 215) forState:UIControlStateSelected];
        [btn setTitleColor:RGB(153, 153, 153) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
        if (i == 0) {
            [btn setImage:[UIImage imageNamed:@"grbb-wxz"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"grbz-xz"] forState:UIControlStateSelected];
            _btn1=btn;
        } else {
            [btn setImage:[UIImage imageNamed:@"tdbb-wz-xz"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"tdbb-xz"] forState:UIControlStateSelected];
            _btn2=btn;
        }
        btn.tag = 1001 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (btn.tag == 1001) {
            btn.selected = YES;
        }
    }
    
}

-(void)btnClick:(UIButton *)btn{
    if (btn.tag==1001) {
        _btn1.selected=YES;
        _btn2.selected=NO;
    }else{
        _btn1.selected=NO;
        _btn2.selected=YES;
    }
    if (self.block) {
        self.block(btn.tag-1000);
    }
}

@end
