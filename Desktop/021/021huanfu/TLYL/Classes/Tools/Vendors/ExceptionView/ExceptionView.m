//
//  ExceptionView.m
//  TLYL
//
//  Created by MC on 2017/8/3.
//  Copyright © 2017年 TLYL01. All rights reserved.
//



#import "ExceptionView.h"

typedef void(^ExceptionViewActionHandler)(ExceptionViewAction *action);

@interface ExceptionViewAction()

@property(nonatomic,copy) ExceptionViewActionHandler handler;

@end

@implementation ExceptionViewAction

- (instancetype)initWithTitle:(NSString*)title handler:(void (^)(ExceptionViewAction *))handler {
    self = [super init];
    if(self) {
        
        self.handler = handler;
    }
    return self;
}

- (instancetype)initWithType:(ExceptionCodeType)type handler:(void (^)(ExceptionViewAction *))handler
{
    self = [super init];
    if(self) {
        _type = type;
        self.handler = handler;
    }
    return self;
}

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(ExceptionViewAction *))handler {
    ExceptionViewAction *action = [[ExceptionViewAction alloc] initWithTitle:title handler:handler];
    
    return action;
}

+ (instancetype)actionWithType:(ExceptionCodeType)type handler:(void(^)(ExceptionViewAction *action))handler{
    ExceptionViewAction *action = [[ExceptionViewAction alloc] initWithType:type handler:handler];
    
    return action;
}
@end




@interface ExceptionView()

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) NSMutableArray<ExceptionViewAction*> *actions;
@property(nonatomic,strong) NSMutableArray<UIButton*> *buttons;

@end

@implementation ExceptionView


-(instancetype)initWithType:(ExceptionCodeType)type
{
    self = [super init];
    if (self) {
        _type = type;
        [self _initialize];
    }
    return self;
}


+ (instancetype)exceptionViewWithType:(ExceptionCodeType)type
{
    ExceptionView *view = [[ExceptionView alloc] initWithType:type];
    return view;
}


-(void)_initialize {
    
    self.backgroundColor = RGB(255, 255, 255);
    
    _actions = [NSMutableArray array];
    _buttons = [NSMutableArray array];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.image = [self imageWithType:_type];
    [self addSubview:_imageView];
    
    
    [self makeConstraints];
}


- (void)makeConstraints
{
    if (_type==ExceptionCodeTypeNoData) {
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset((G_SCREENHEIGHT-64 - MC_REALVALUE(150)) * 0.5);
            make.height.equalTo(@(MC_REALVALUE(150)));
            make.width.equalTo(@(MC_REALVALUE(250)));
            make.centerX.equalTo(self);
        }];
    }else{
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(MC_REALVALUE(89));
            make.height.equalTo(@(MC_REALVALUE(150)));
            make.width.equalTo(@(MC_REALVALUE(250)));
            make.centerX.equalTo(self);
        }];
        
    }
    

    
}

-(void)addAction:(ExceptionViewAction *)action {
    if(!action) {
        return;
    }
    if([_actions containsObject:action]) {
        return;
    }
    
    [_actions addObject:action];
    
    
    
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:[self btnTitleWithType:action.type] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    button.backgroundColor=RGB(144,8,215);
//    [button setBackgroundImage:[UIImage imageNamed:@"Button_Determine"] forState:UIControlStateNormal];
    [self addSubview:button];
    button.layer.cornerRadius=10.0;
    button.clipsToBounds=YES;
    
    [_buttons addObject:button];
    
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.top.equalTo(_imageView.mas_bottom).offset(MC_REALVALUE(65));
        make.height.equalTo(@(40));
    }];
    
    
}

-(void)showInView:(UIView *)view {
    
    if (_originY) {

        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(MC_REALVALUE(89)+_originY);
            make.height.equalTo(@(MC_REALVALUE(150)));
            make.width.equalTo(@(MC_REALVALUE(250)));
            make.centerX.equalTo(self);
        }];
        if (!_heightH) {
            _heightH=view.bounds.size.height;
        }
       self.frame = CGRectMake(0, _originY,view.bounds.size.width ,_heightH ) ;
        
    }else{
        if (!_heightH) {
            _heightH=G_SCREENHEIGHT-64;
        }else{
            [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.mas_centerX);
                make.top.equalTo(self.mas_top).offset((_heightH-250)/2.0);
                make.size.mas_equalTo(CGSizeMake(500*0.5, 300*0.5));
            }];
        }
        self.frame = CGRectMake(0, 0, view.bounds.size.width, _heightH) ;

        
    }
    [view addSubview:self];
}

-(void)buttonTouchUpInside:(UIButton*)sender {
    NSInteger index = [_buttons indexOfObject:sender];
    
    ExceptionViewAction *action = _actions[index];
    if(action.handler) {
        action.handler(action);
    }
}

-(void)dismiss {
    
    UIView *superView = self.superview;
    if(superView) {
        for (UIView *view in superView.subviews) {
            if([view isKindOfClass:[ExceptionView class]]) {
                [view removeFromSuperview];
            }
        }
    }
}




- (NSString *)btnTitleWithType:(ExceptionCodeType)type
{
    NSString *btnTitle;
    switch (type) {
        case ExceptionCodeTypeNoData:
            btnTitle = @"重试";
            break;
        case ExceptionCodeTypeServerError:
            btnTitle = @"重试";
            break;
            
        case ExceptionCodeTypeNoNetwork:
            btnTitle = @"重试";
            break;
        case ExceptionCodeTypeRequestFailed:
            btnTitle = @"重试";
            break;
            
            
        default:
            break;
    }
    
    return btnTitle;
}

- (UIImage *)imageWithType:(ExceptionCodeType)type
{
    NSString *imageString;
    switch (type) {
        case ExceptionCodeTypeNoData:
            imageString = @"noData_network";
            break;
        case ExceptionCodeTypeServerError:
            imageString = @"error_network";
            break;
            
        case ExceptionCodeTypeNoNetwork:
            imageString = @"badNet_network";
            break;
        case ExceptionCodeTypeRequestFailed:
            imageString = @"error_network";
            break;
            
            
        default:
            break;
    }
    
    return [UIImage imageNamed:imageString];
}

- (void)dealloc
{
    NSLog(@"exceptionView  dealloc");
}

@end

