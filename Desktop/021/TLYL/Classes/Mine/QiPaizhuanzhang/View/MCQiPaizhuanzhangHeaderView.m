//
//  MCQiPaizhuanzhangHeaderView.m
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCQiPaizhuanzhangHeaderView.h"
#import "MCUserMoneyModel.h"
#import "MCGetGameBalanceModel.h"
#import "UIView+MCParentController.h"
@interface MCQiPaizhuanzhangHeaderView ()

@property (nonatomic,strong)MCUserMoneyModel * userMoneyModel;
@property (nonatomic,strong)MCGetGameBalanceModel *getGameBalanceModel;

@property (nonatomic,assign)int T;
@end

@implementation MCQiPaizhuanzhangHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI{
    
    self.backgroundColor=RGB(249, 249, 249);
    
    CGFloat W = G_SCREENWIDTH-54;
    CGFloat L = 50;
    
    UILabel * lab1=[[UILabel alloc]init];
    [self setLab:lab1 withColor:RGB(0, 0, 0) andFont:11 andText:@"彩票余额" andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.width.mas_equalTo(L);
        make.left.equalTo(self.mas_left).offset(13);
    }];
    
    UILabel * lottory_yuElab=[[UILabel alloc]init];
    [self setLab:lottory_yuElab withColor:RGB(249,84,83) andFont:11 andText:@"加载中..." andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lottory_yuElab];
    _lottory_yuElab=lottory_yuElab;
    [lottory_yuElab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(lab1.mas_right).offset(0);
        make.width.mas_equalTo(W/2.0-L);
    }];
    
    UILabel * lab2=[[UILabel alloc]init];
    [self setLab:lab2 withColor:RGB(0, 0, 0) andFont:11 andText:@"棋牌余额" andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.width.mas_equalTo(L);
        make.left.equalTo(self.mas_left).offset(W/2.0);
    }];
    
    UILabel * qipai_yuElab=[[UILabel alloc]init];
    [self setLab:qipai_yuElab withColor:RGB(249,84,83) andFont:11 andText:@"加载中..." andTextAlignment:NSTextAlignmentLeft];
    [self addSubview:qipai_yuElab];
    _qipai_yuElab=qipai_yuElab;
    [qipai_yuElab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(lab2.mas_right).offset(0);
        make.width.mas_equalTo(W/2.0-L);
    }];
    
    
    
    UIView * line = [[UIView alloc]init];
    line.backgroundColor=RGB(231,231,231);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(G_SCREENWIDTH-54);
        make.width.mas_equalTo(0.5);
    }];

    
    UIImageView * yuEimgV=[[UIImageView alloc]init];
    [self addSubview:yuEimgV];
    yuEimgV.frame=CGRectMake(G_SCREENWIDTH-19-16, 12, 16, 16);
    yuEimgV.image=[UIImage imageNamed:@"shuaxinyue"];
    yuEimgV.userInteractionEnabled=YES;
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(shuaXin)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [yuEimgV addGestureRecognizer:singleRecognizer];
    
    
    
}

-(void)shuaXin{
    
    [self shuaXinYuE:^(BOOL result) {
        [BKIndicationView dismiss];
    }];
    
}

-(void)shuaXinYuE:(QiPaiCompeletion)compeletion{
    __weak __typeof__ (self) wself = self;
    
    _T = 0;
    
    //刷新余额
    [BKIndicationView showInView:[UIView MCcurrentViewController].view];
    
    MCUserMoneyModel * userMoneyModel=[MCUserMoneyModel sharedMCUserMoneyModel];
    [userMoneyModel refreashDataAndShow];
    self.userMoneyModel=userMoneyModel;
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_async(group, quene, ^{
            userMoneyModel.callBackSuccessBlock = ^(id manager) {
                [BKIndicationView dismiss];
                wself.userMoneyModel.FreezeMoney=manager[@"FreezeMoney"];
                wself.userMoneyModel.LotteryMoney=manager[@"LotteryMoney"];
                wself.lottory_yuElab.text = manager[@"LotteryMoney"];
                
                NSLog(@"complete task 1-YES");
                dispatch_semaphore_signal(semaphore);
                wself.T++;
                
            };
        
            userMoneyModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
                [BKIndicationView dismiss];
                
                
                NSLog(@"complete task 1-NO");
                dispatch_semaphore_signal(semaphore);

            };
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });

    
    MCGetGameBalanceModel *getGameBalanceModel = [MCGetGameBalanceModel sharedMCGetGameBalanceModel];
    [getGameBalanceModel refreashDataAndShow];
    self.getGameBalanceModel=getGameBalanceModel;
    
    dispatch_group_async(group, quene, ^{
        
        getGameBalanceModel.callBackSuccessBlock = ^(id manager) {
            wself.getGameBalanceModel.DsBalance=manager[@"DsBalance"];
            wself.qipai_yuElab.text = manager[@"DsBalance"];
            if (wself.qipai_yuElab.text.length<1) {
                wself.qipai_yuElab.text = @"0";
            }
            dispatch_semaphore_signal(semaphore);
            NSLog(@"complete task 2-YES");
            wself.T++;
        };
        
        getGameBalanceModel.callBackFailedBlock = ^(id manager, NSString *errorCode) {
            
            dispatch_semaphore_signal(semaphore);
            NSLog(@"complete task 2-NO");
        };
    
 
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    });
    

    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSLog(@"完成了网络请求，不管网络请求失败了还是成功了。");
        
        if (wself.T==2) {
            NSLog(@"11111111111111111111111111111111111");
            compeletion(YES);
        }else{
            NSLog(@"22222222222222222222222222222222222");
            compeletion(NO);
        }
    });
    
    
}


-(void)setLab:(UILabel *)lab withColor:(UIColor *)color andFont:(CGFloat)font andText:(NSString *)text andTextAlignment:(NSTextAlignment)textAlignment{
    lab.text=text;
    lab.textColor=color;
    lab.font=[UIFont systemFontOfSize:font];
    lab.textAlignment=textAlignment;
}



+(CGFloat)computeHeight:(id)info{
    return 40;
}

-(void)setDataSource:(id)dataSource{
    
    _dataSource=dataSource;

    
    
    
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


@end





























