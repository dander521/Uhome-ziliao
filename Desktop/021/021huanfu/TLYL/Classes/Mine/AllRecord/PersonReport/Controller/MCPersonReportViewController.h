//
//  MCPersonReportViewController.h
//  TLYL
//
//  Created by MC on 2017/10/19.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyReportModel.h"
typedef NS_ENUM(NSInteger, MCPersonReportType){
    MCPersonReportType_Daily=0,
    MCPersonReportType_Summary
};

@interface MCPersonReportViewController : UIViewController

@property (nonatomic,assign)MCPersonReportType Type;
@property (nonatomic,strong) MCGetMyReportDataModel * Rmodel;
- (void)refreashData;
- (void)loadMoreData;

@end
