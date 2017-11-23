//
//  MCSignContractHeaderView.h
//  TLYL
//
//  Created by MC on 2017/11/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCGetMyAndSubDayWagesThreeModel.h"
#import "MCMyXiaJiDayWagesThreeRdListModel.h"

@interface MCSignContractHeaderView : UIView

+(CGFloat)computeHeight:(id)info;

@property (nonatomic,strong)MCGetMyAndSubDayWagesThreeDataModel *dataSource;
@property (nonatomic,strong) MCMyXiaJiDayWagesThreeListModelsDataModel * xiaJiModel;


@end
