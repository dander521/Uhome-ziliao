//
//  MCModifyUserImgVViewController.h
//  TLYL
//
//  Created by MC on 2017/11/7.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^refreashUserImgVBlock)();

@interface MCModifyUserImgVViewController : UIViewController

@property (nonatomic,copy)refreashUserImgVBlock userImgBlock;

@end
