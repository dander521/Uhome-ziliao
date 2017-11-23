//
//  MCQiPaiReportFooterView.h
//  TLYL
//
//  Created by MC on 2017/10/25.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MCQiPaiReportFooterBlock)(NSInteger t);

@interface MCQiPaiReportFooterView : UIView

@property (nonatomic,copy) MCQiPaiReportFooterBlock block;

@end
