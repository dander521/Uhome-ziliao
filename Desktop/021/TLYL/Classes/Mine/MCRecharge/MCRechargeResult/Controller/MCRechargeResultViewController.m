//
//  MCRechargeResultViewController.m
//  TLYL
//
//  Created by MC on 2017/7/27.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCRechargeResultViewController.h"

@interface MCRechargeResultViewController ()

@end

@implementation MCRechargeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setProperty];
    
    [self createUI];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.navigationController.navigationBar.translucent = NO;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [BKIndicationView dismiss];
}
#pragma mark==================setProperty======================
-(void)setProperty{
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"提示信息";
}

#pragma mark==================createUI======================
-(void)createUI{
    
    UIImageView * imgV=[[UIImageView alloc]init];
    [self.view addSubview:imgV];
    imgV.image=[UIImage imageNamed:@"RechargeResult"];

    [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(67);
        make.height.mas_equalTo(248/2.0);
        make.width.mas_equalTo(296/2.0);
    }];
    
    
    UIButton * btn1=[[UIButton alloc]init];
    [self setBTN:btn1 andIndex:0 andText:@"已完成充值"];
    
    UIButton * btn2=[[UIButton alloc]init];
    [self setBTN:btn2 andIndex:1 andText:@"充值遇到问题"];
    
    UIButton * btn3=[[UIButton alloc]init];
    [self setBTN:btn3 andIndex:2 andText:@"重新选择银行"];
}


-(void)setBTN:(UIButton *)btn andIndex:(int)index andText:(NSString *)text {
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"Button_Determin_Right"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=index+1000;
    btn.layer.cornerRadius=10.0;
    btn.clipsToBounds=YES;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.top.equalTo(self.view.mas_top).offset(67+124+90);
        make.height.mas_equalTo(50);
    }];
}

-(void)action_Btn:(UIButton *)btn{
   
    if (btn.tag==1000) {
        
        NSLog(@"已完成充值！");
        
    }else if (btn.tag==1001){
        
        NSLog(@"充值遇到问题！");

    }else if (btn.tag==1002){
        
        NSLog(@"重新选择银行！");
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end










