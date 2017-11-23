//
//  MCMMPopView.h
//  TLYL
//
//  Created by miaocai on 2017/10/20.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCNaviPopView.h"

@interface MCMMPopView : MCNaviPopView
@property (nonatomic,strong)void (^searchBtnBlock)(NSString*);
@property (nonatomic,weak) UITextField *tf;
@end
