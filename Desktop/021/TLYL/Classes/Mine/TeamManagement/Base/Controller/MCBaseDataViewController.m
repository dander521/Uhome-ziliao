//
//  MCBaseDataViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/23.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBaseDataViewController.h"


@interface MCBaseDataViewController ()


/**listModel 模型*/
@property (nonatomic,strong) MCBaseDataModel *baseModel;
@end

@implementation MCBaseDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCErrorWindow_Retry" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:@"MCNONetWindow_Retry" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self hiddenExDataView];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)hiddenExDataView{
    [self.noDataWin setHidden: YES];
    [self.errNetWin setHidden: YES];
    [self.errDataWin setHidden: YES];
}
- (void)showExDataView{

//        [self.noDataWin removeFromSuperview];
       [self.noDataWin setHidden: NO];

    
    
}
#pragma mark --发送请求
-(void)loadData{
    [self hiddenExDataView];

//    self.baseModel.callBackFailedBlock = ^(ApiBaseManager *manager, NSDictionary *errorCode) {
//        NSError *err = errorCode[@"code"];
//        if (err.code == -1001) {
//            [self.errDataWin showModelWindow];
//        } else if (err.code == -1009){
//            [self.errNetWin showModelWindow];
//        }
//        [SVProgressHUD dismiss];
//    };

}
- (MCNoDataWindow *)noDataWin{
    if (_noDataWin == nil) {
        MCNoDataWindow *win = [[MCNoDataWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49)];
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _noDataWin = win;
    }
    return _noDataWin;
    
}

- (MCErrorWindow *)errDataWin{
    if (_errDataWin == nil) {
        MCErrorWindow *win = [[MCErrorWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64 , G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49)];
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errDataWin = win;
    }
    return _errDataWin;
    
}
- (MCNONetWindow *)errNetWin{
    if (_errNetWin == nil) {
        MCNONetWindow *win = [[MCNONetWindow alloc]alertInstanceWithFrame:CGRectMake(MC_REALVALUE(13), MC_REALVALUE(13) + 64, G_SCREENWIDTH - MC_REALVALUE(26), G_SCREENHEIGHT-MC_REALVALUE(26) - 64 -49)];
        win.layer.cornerRadius = 6;
        win.clipsToBounds = YES;
        [self.view addSubview:win];
        _errNetWin = win;
    }
    return _errNetWin;
    
}

@end
