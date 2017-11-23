//
//  MCPullMenuPresentationController.h
//  TLYLSF
//
//  Created by MC on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>
#define HEIGHTDAOJISHI 0
#define HEIGHTKAIJIANGHAO 40
@interface MCPullMenuPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>
typedef NS_ENUM(NSInteger,MCPullMenuType ) {
    MCPullMenuKaiJiangType=1,
    MCPullMenuCZListType,
};

@property (nonatomic,assign)MCPullMenuType type;
@property (nonatomic,assign) BOOL isShowFaildIssue;

@end
