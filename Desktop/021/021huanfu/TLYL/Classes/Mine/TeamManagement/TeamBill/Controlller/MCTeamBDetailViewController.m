//
//  MCTeamBDetailViewController.m
//  TLYL
//
//  Created by miaocai on 2017/10/26.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCTeamBDetailViewController.h"
#import "MCPullMenuModel.h"
#import "MCDataTool.h"

@interface MCTeamBDetailViewController ()

@end

@implementation MCTeamBDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contnueBtn.hidden = YES;
    self.backBtn.hidden = YES;
    [self loadDataAndShow];
}





@end
