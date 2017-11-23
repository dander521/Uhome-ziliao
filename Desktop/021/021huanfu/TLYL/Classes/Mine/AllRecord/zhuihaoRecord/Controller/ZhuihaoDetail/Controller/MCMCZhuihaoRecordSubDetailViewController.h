//
//  MCMCZhuihaoRecordSubDetailViewController.h
//  TLYL
//
//  Created by MC on 2017/10/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCUserChaseRecordDetailModel.h"

typedef void(^MCMCZhuihaoRecordSubDetailViewControllerGoBackBlock)() ;
@interface MCMCZhuihaoRecordSubDetailViewController : UIViewController

@property (nonatomic,strong)MCUserChaseRecordDetailSubDataModel * dataSource;
@property (nonatomic,strong)MCUserChaseRecordDetailDataModel * Amodel;

@property (nonatomic,copy)MCMCZhuihaoRecordSubDetailViewControllerGoBackBlock goBackBlock;
@end
