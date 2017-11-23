//
//  MCMMSetingViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/23.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMSetingViewController.h"
#import "MCMMFandianModel.h"
#import "MCMMSaveModel.h"
#import "MCInputView.h"

@interface MCMMSetingViewController ()
@property (nonatomic,strong) MCMMFandianModel *fandianModel;
@property (nonatomic,strong) MCMMSaveModel *saveModel;
///**条件选择*/
@property (nonatomic,weak) MCInputView *viewPop;
@property (nonatomic,weak) UIView *cloverView;
@property (nonatomic,weak) UILabel *fandianlabValue;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,assign) int Rebate;
@end

@implementation MCMMSetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPUI];
    self.view.backgroundColor = RGB(231, 231, 231);
    [self loadData];
    self.navigationItem.title = [NSString stringWithFormat:@"%@返点设置",self.dataSource.UserName];
}

- (void)setUPUI{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), MC_REALVALUE(48))];
    topView.layer.cornerRadius = 6;
    topView.clipsToBounds = YES;
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UILabel *fandianlab = [[UILabel alloc] init];
    fandianlab.text = @"返点";
    fandianlab.textColor = RGB(46, 46, 46);
    fandianlab.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [topView addSubview:fandianlab];
    [fandianlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).offset(MC_REALVALUE(20));
        make.top.equalTo(topView).offset(MC_REALVALUE(18));
        
    }];
    UIImageView *imageV = [[UIImageView alloc] init];
    [topView addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"MC_right_arrow"];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).offset(MC_REALVALUE(-16));
        make.centerY.equalTo(topView);
    }];
    
    UILabel *fandianlabValue = [[UILabel alloc] init];
    fandianlabValue.text = @"";
    self.fandianlabValue = fandianlabValue;
    fandianlabValue.textColor = RGB(46, 46, 46);
    fandianlabValue.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [topView addSubview:fandianlabValue];
    [fandianlabValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imageV.mas_left).offset(MC_REALVALUE(-9));
        make.top.equalTo(topView).offset(MC_REALVALUE(18));
        
    }];
    UILabel *info = [[UILabel alloc] init];
    info.numberOfLines = 0;
    info.text = @"注意事项：\n1. 会员升点功能，仅限于上级对下级进行返点率操作；\n2. 对下级进行返点调整后，上级账户的返利比例数量会相应的减少，请谨慎操作。";
    info.textColor = RGB(136, 136, 136);
    info.font = [UIFont systemFontOfSize:MC_REALVALUE(10)];
    [self.view addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(MC_REALVALUE(22));
        make.right.equalTo(self.view).offset(MC_REALVALUE(-59));
        make.height.equalTo(@(MC_REALVALUE(64)));
        make.top.equalTo(topView.mas_bottom).offset(MC_REALVALUE(22));
    }];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:RGB(144, 8, 215)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:MC_REALVALUE(14)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    btn.layer.cornerRadius = 6;
    btn.clipsToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(MC_REALVALUE(13));
        make.right.equalTo(self.view).offset(MC_REALVALUE(-13));
        make.height.equalTo(@(MC_REALVALUE(40)));
        make.top.equalTo(info.mas_bottom).offset(MC_REALVALUE(16));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [topView addGestureRecognizer:tap];
}
- (void)loadData{
    MCMMFandianModel *fandianModel = [[MCMMFandianModel alloc] init];
    self.fandianModel = fandianModel;
    fandianModel.LikeUserName = self.dataSource.UserName;
    fandianModel.IsP = 1;
    [fandianModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    __weak typeof(self) weakself = self;
    [self.dataArr removeAllObjects];
    fandianModel.callBackSuccessBlock = ^(NSDictionary *manager) {

        for (NSNumber * num in manager[@"Parentrebate"]) {
            [weakself.dataArr addObject:[NSString stringWithFormat:@"%d",[num intValue]]];
        }
    
        [SVProgressHUD dismiss];
        if (weakself.dataArr.count > 0) {
            weakself.fandianlabValue.text = weakself.dataArr[0];
             weakself.Rebate = [weakself.dataArr[0] intValue];
        }
        
    };
    fandianModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [SVProgressHUD showWithStatus:manager.responseMessage];
        [SVProgressHUD dismiss];
    };
    
}
//保存
- (void)btnClick{
    if (self.dataArr.count == 0) {
         [SVProgressHUD showInfoWithStatus:@"当前用户无可用返点！"];
        return;
    }
    
    MCMMSaveModel *saveModel = [[MCMMSaveModel alloc] init];
    self.saveModel = saveModel;
    __weak typeof(self) weakself = self;
    saveModel.ThisUserID = self.dataSource.UserID;
    saveModel.Rebate = self.Rebate;
    [saveModel refreashDataAndShow];
    [BKIndicationView showInView:self.view];
    saveModel.callBackSuccessBlock = ^(ApiBaseManager *manager) {
        [SVProgressHUD showInfoWithStatus:manager.responseMessage];
        [weakself loadData];
    };
    saveModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
        [SVProgressHUD showInfoWithStatus:manager.responseMessage];
       
    };
}


//返点
- (void)tap{
   
    if (self.dataArr.count >0) {
        self.cloverView.hidden = NO;
        self.viewPop.dataArray = self.dataArr;
       [self.viewPop show];
        __weak typeof(self) weakself = self;
        self.viewPop.cellDidSelectedTop = ^(NSInteger i) {
            [weakself.viewPop hiden];
            weakself.cloverView.hidden = YES;
            weakself.fandianlabValue.text = weakself.viewPop.dataArray[i];
            weakself.Rebate = [weakself.dataArr[i] intValue];
           
        };
    }else{
        [SVProgressHUD showInfoWithStatus:@"当前用户无可用返点！"];
    }

}
- (void)dealloc {
    
    NSLog(@"%@--dealloc ",self);
}
- (void)tapClick{
    [self.viewPop hiden];
    self.cloverView.hidden = YES;
    
}
- (UIView *)cloverView{
    if (_cloverView == nil) {
        UIView *cloverView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, G_SCREENWIDTH, G_SCREENHEIGHT - 64)];
        cloverView.backgroundColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.5];
        [self.view addSubview:cloverView];
        _cloverView = cloverView;
        [cloverView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)]];
    }
    return _cloverView;
}
- (MCInputView *)viewPop{
    if (_viewPop == nil) {
        MCInputView *viewStatus = [[MCInputView alloc] init];
        [self.view addSubview:viewStatus];
        _viewPop = viewStatus;
    }
    return _viewPop;
}
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        _dataArr = arr;
    }
    return _dataArr;
    
}
@end
