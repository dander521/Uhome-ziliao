//
//  MCQuestionView.h
//  TLYL
//
//  Created by MC on 2017/7/18.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHT_MCQuestion 36*3+10



@interface MCQuestionTableViewCell : UITableViewCell

@property (nonatomic,strong)id dataSource;
+(CGFloat)computeHeight:(id)info;



@end


typedef void(^MCQuestionBlock)(NSString * str);

@interface MCQuestionView : UIView

@property (nonatomic,strong) NSMutableArray * dataSource;
@property (nonatomic,  copy) MCQuestionBlock  block;


@end

