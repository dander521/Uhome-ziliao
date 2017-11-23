//
//  ExceptionView.h
//  TLYL
//
//  Created by MC on 2017/8/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ExceptionCodeType){
    ExceptionCodeTypeServerError=0,           //服务器错误
    ExceptionCodeTypeRequestFailed,           //请求失败
    ExceptionCodeTypeNoData,                  //没有数据
    ExceptionCodeTypeNoNetwork                //无网络
};


@interface ExceptionViewAction : NSObject

@property(nonatomic,assign,readonly) ExceptionCodeType type;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;



+(instancetype)actionWithType:(ExceptionCodeType)type handler:(void(^)(ExceptionViewAction *action))handler;

@end



@interface ExceptionView : UIView

@property(nonatomic,assign,readonly) ExceptionCodeType type;

-(void)addAction:(ExceptionViewAction*)action;
-(void)showInView:(UIView*)view;
-(void)dismiss;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

+(instancetype)exceptionViewWithType:(ExceptionCodeType)type;


@property(nonatomic,assign) CGFloat originY;
@property(nonatomic,assign) CGFloat heightH;
@property(nonatomic,assign) CGFloat wh;
@property(nonatomic,assign) CGFloat originX;
@end

