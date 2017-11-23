//
//  MCQiPaiReportViewController.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MCQiPaiReportType){
    //个人
    MCQiPai_Person_DailyReport=0,
    MCQiPai_Person_SummaryReport,
    
    //团队
    MCQiPai_Team_XiaJiReport,
    MCQiPai_Team_MyselfReport,
    MCQiPai_Team_TeamReport
    
};

@interface MCQiPaiReportViewController : UIViewController

@property (nonatomic,assign)MCQiPaiReportType Type;

@end






