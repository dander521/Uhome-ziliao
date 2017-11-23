//
//  MCMMCPresentationController.m
//  TLYL
//
//  Created by MC on 2017/7/6.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMMCPresentationController.h"
#import "MMCHeader.h"

#define HEIGHT_FROMTOP  64.f
#define WIDTH_LEFT      (G_SCREENWIDTH-W_MMC_VIEW)/2.0
#define HEIGHT_TOP      (G_SCREENHEIGHT-H_MMC_VIEW-64)/2.0


#define Center_X   WIDTH_LEFT+W_MMC_VIEW/2.0
#define Center_Y   HEIGHT_TOP+H_MMC_VIEW/2.0

@interface MCMMCPresentationController () <UIViewControllerAnimatedTransitioning>
#pragma mark -property
/**dimmingView*/
@property (nonatomic, strong) UIView *dimmingView;

/**添加阴影*/
@property (nonatomic, strong) UIView *presentationWrappingView;

@end

@implementation MCMMCPresentationController
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
    
    UIView *presentedViewControllerView = [super presentedView];
    {
        UIView *presentationWrapperView = [[UIView alloc] initWithFrame:self.frameOfPresentedViewInContainerView];
        /*
         * 添加阴影
         */
        self.presentationWrappingView = presentationWrapperView;
//        self.presentationWrappingView.layer.cornerRadius=10.0;
//        self.presentationWrappingView.clipsToBounds=YES;
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
- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed == NO){
        self.presentationWrappingView = nil;
        self.dimmingView = nil;
    }
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
    //    self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView;
    
    self.presentationWrappingView.frame = CGRectMake(WIDTH_LEFT, HEIGHT_TOP, W_MMC_VIEW, H_MMC_VIEW);
}

#pragma mark -
#pragma mark Tap Gesture Recognizer
- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender{
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
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
    UIViewController __unused *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [containerView addSubview:fromView];
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    
    CGRect fromView_Final_Frame=CGRectMake(Center_X, Center_Y, 1, 1);
    
    
    /*
     * 初始化的Frame
     */
    CGRect toView_Initial_Frame=CGRectMake(Center_X, Center_Y, 1, 1);
    
    /*
     * 结束的Frame
     */
    
    CGRect __unused toView_Final_Frame =CGRectMake(WIDTH_LEFT, HEIGHT_TOP, W_MMC_VIEW, H_MMC_VIEW);
    [containerView addSubview:toView];
    if (isPresenting) {
        
        toView_Initial_Frame.origin = CGPointMake(Center_X, Center_Y);
        
        
        toView_Initial_Frame.size = CGSizeMake(1, 1);
        toView.frame = toView_Initial_Frame;
    } else {
        
        fromView_Final_Frame = CGRectMake(Center_X, Center_Y, 1, 1);
    }
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isPresenting){
            
            CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            animation.duration = 0.3;
            
            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            animation.values = values;
            [toView.layer addAnimation:animation forKey:nil];
            
            //            toView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5f, 0.5f);
            
            
            //            toView.transform = CGAffineTransformScale(toView.transform, 0.5, 0.5);
            //            toView.frame = toView_Final_Frame;
            
        }else{
            CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            animation.duration = 0.3;
            
            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.2, 0.2, 1.0)]];
            animation.values = values;
            [fromView.layer addAnimation:animation forKey:nil];
            
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

















