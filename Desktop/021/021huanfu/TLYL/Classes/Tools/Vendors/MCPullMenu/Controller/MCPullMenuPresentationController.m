//
//  MCPullMenuPresentationController.m
//  TLYLSF
//
//  Created by MC on 2017/6/7.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "MCPullMenuPresentationController.h"
#import "UIView+MCParentController.h"
#import "MCPaySelectedLotteryModel.h"
#import "MCPopAlertView.h"

#define HEIGHT_FROMTOP  64+HEIGHTKAIJIANGHAO+HEIGHTDAOJISHI

@interface MCPullMenuPresentationController ()
<
UIViewControllerAnimatedTransitioning,
UIAlertViewDelegate
>
#pragma mark -property
/** */
@property (nonatomic, strong) UIView *dimmingView;

@property (nonatomic, strong) UIView *presentationWrappingView;

@end

@implementation MCPullMenuPresentationController
#pragma mark - INIT
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (UIView*)presentedView{
    
    return self.presentationWrappingView;
}

- (void)presentationTransitionWillBegin{
    
    
    UIButton * btn_back=[[UIButton alloc]init];
    [self.containerView addSubview:btn_back ];
    btn_back.backgroundColor=[UIColor clearColor];
    btn_back.frame=CGRectMake(0, 0, 100, 64);
    [btn_back addTarget:self action:@selector(action_back) forControlEvents:UIControlEventTouchUpInside];
    
    if (_type==MCPullMenuKaiJiangType) {
        UIButton * btn_back=[[UIButton alloc]init];
        [self.containerView addSubview:btn_back ];
        btn_back.backgroundColor=[UIColor clearColor];
        btn_back.frame=CGRectMake(G_SCREENWIDTH*494/750.0, 64+HEIGHTDAOJISHI,G_SCREENWIDTH*256/750.0 , HEIGHTKAIJIANGHAO);
        [btn_back addTarget:self action:@selector(dismissKaiJiangType) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    
    if (_type==MCPullMenuCZListType) {
        UIButton * btn_back=[[UIButton alloc]init];
        [self.containerView addSubview:btn_back ];
        btn_back.backgroundColor=[UIColor clearColor];
        btn_back.frame=CGRectMake(0, 64+HEIGHTDAOJISHI,G_SCREENWIDTH*494/750.0 , HEIGHTKAIJIANGHAO);
        [btn_back addTarget:self action:@selector(dismissCZListType) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIView *presentedViewControllerView = [super presentedView];
    {
        UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
        /*
         * 添加阴影
         */
        self.presentationWrappingView = presentationWrapperView;
        UIView *presentationRoundedCornerView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
        presentationRoundedCornerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentationRoundedCornerView.layer.cornerRadius = 0;
        presentationRoundedCornerView.layer.masksToBounds = YES;
        UIView *presentedViewControllerWrapperView = [[UIView alloc] initWithFrame:UIEdgeInsetsInsetRect(presentationRoundedCornerView.bounds, UIEdgeInsetsMake(0, 0, 0, 0))];
        presentedViewControllerWrapperView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentedViewControllerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds;
        [presentedViewControllerWrapperView addSubview:presentedViewControllerView];
        [presentationRoundedCornerView addSubview:presentedViewControllerWrapperView];
        [presentationWrapperView addSubview:presentationRoundedCornerView];
    }
    {
        UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        dimmingView.backgroundColor = [UIColor blackColor];
        dimmingView.opaque = NO;
        dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
        self.dimmingView = dimmingView;
        [self.containerView addSubview:dimmingView];
        id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
        self.dimmingView.alpha = 0.f;
        [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
            self.dimmingView.alpha = 0.5f;
        } completion:NULL];
    }
}

-(void)action_back{
    MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
    if (model.dataSource.count == 0) {
        [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.0];
    }else{
//        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"返回将清空已选号码，确定返回吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [alertView show];
        MCPopAlertView *mcAlertView = [[MCPopAlertView alloc] initWithType:MCPopAlertTypeTZRequest_Confirm Title:@"提示" message:@"返回将清空已选号码，确定返回吗？" leftBtn:@"确定" rightBtn:@"取消"];
        
        mcAlertView.resultIndex = ^(NSInteger index){
            if (index==1) {
                /*
                 * 清空购彩蓝
                 */
                MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
                [model removeDataSource];
                
                
                [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.0];
            }
        };
        [mcAlertView showXLAlertView];
        
    }
   
    
    
    
}

-(void)dismissKaiJiangType{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
-(void)dismissCZListType{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}
- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed == NO){
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        /*
         * 清空购彩蓝
         */
        MCPaySLBaseModel * model=[MCPaySLBaseModel sharedMCPaySLBaseModel];
        [model removeDataSource];
        
        
        [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:0.0];
    }
    
    
    
}
-(void)delayMethod{
    [self.presentingViewController dismissViewControllerAnimated:NO completion:^{
        /*
         * 跳转到首页
         */
        [[UIView MCcurrentViewController].navigationController popViewControllerAnimated:YES];
    }];
}

- (void)dismissalTransitionWillBegin{
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}
- (void)dismissalTransitionDidEnd:(BOOL)completed{
    
    if (completed == YES){
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
}
#pragma mark -
#pragma mark Layout
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize{
    if (container == self.presentedViewController)
        return ((UIViewController*)container).preferredContentSize;
    else
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
}
- (CGRect)frameOfPresentedViewInContainerView{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y=HEIGHT_FROMTOP;
    return presentedViewControllerFrame;
}
- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = CGRectMake(self.containerView.bounds.origin.x, self.containerView.bounds.origin.y+HEIGHT_FROMTOP, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
}

#pragma mark -
#pragma mark Tap Gesture Recognizer
- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark -
#pragma mark UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    if ([transitionContext isAnimated]) {
        return 0.30;
    }else{
        return 0.0;
    }
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [containerView addSubview:fromView];
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    CGRect __unused fromView_Initial_Frame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect fromView_Final_Frame = [transitionContext finalFrameForViewController:fromViewController];
    /*
     * 初始化的Frame
     */
    CGRect toView_Initial_Frame = [transitionContext initialFrameForViewController:toViewController];
    /*
     * 结束的Frame
     */
    CGRect toView_Final_Frame = [transitionContext finalFrameForViewController:toViewController];
    [containerView addSubview:toView];
    if (isPresenting) {
        toView_Initial_Frame.origin = CGPointMake(CGRectGetMinX(containerView.bounds), HEIGHT_FROMTOP);
        NSLog(@"%f----%f",CGRectGetMinX(containerView.bounds),CGRectGetMaxY(containerView.bounds));
        toView_Initial_Frame.size = CGSizeMake(toView_Final_Frame.size.width, 1);
        toView.frame = toView_Initial_Frame;
    } else {
        fromView_Final_Frame = CGRectMake(0, HEIGHT_FROMTOP, fromView_Initial_Frame.size.width, 0);
    }
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting){
            toView.frame = toView_Final_Frame;
        }else{
            fromView.frame = fromView_Final_Frame;
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}
#pragma mark -
#pragma mark UIViewControllerTransitioningDelegate
- (UIPresentationController*)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    NSAssert(self.presentedViewController == presented, @"You didn't initialize %@ with the correct presentedViewController.  Expected %@, got %@.",
             self, presented, self.presentedViewController);
    return self;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}

@end

















