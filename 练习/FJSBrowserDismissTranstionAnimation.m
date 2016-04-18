//
//  FJSBrowserDismissTranstionAnimation.m
//  练习
//
//  Created by 付金诗 on 16/4/18.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSBrowserDismissTranstionAnimation.h"

@implementation FJSBrowserDismissTranstionAnimation
/*
 动画的关键在于animator如何实现，它实现了UIViewControllerAnimatedTransitioning协议，至少需要实现两个方法，我建议您仔细阅读animateTransition方法中的注释，它是整个动画逻辑的核心：
 */
//| ----------------------------------------------------------------------------
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return ANIMATIONDURATION;
}

/// 设置动画的进行方式，附有详细注释，demo中其他地方的这个方法不再解释
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>*fromViewController = (UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>*toViewController = (UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = transitionContext.containerView;
    // 需要关注一下from/to和presented/presenting的关系
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    UIView *fromView;
    UIView *toView;
    
    // iOS8引入了viewForKey方法，尽可能使用这个方法而不是直接访问controller的view属性
    // 比如在form sheet样式中，我们为presentedViewController的view添加阴影或其他decoration，animator会对整个decoration view
    // 添加动画效果，而此时presentedViewController的view只是decoration view的一个子视图
    // In iOS 8, the viewForKey: method was introduced to get views that the
    // animator manipulates.  This method should be preferred over accessing
    // the view of the fromViewController/toViewController directly.
    // It may return nil whenever the animator should not touch the view
    // (based on the presentation style of the incoming view controller).
    // It may also return a different view for the animator to animate.
    //
    // Imagine that you are implementing a presentation similar to form sheet.
    // In this case you would want to add some shadow or decoration around the
    // presented view controller's view. The animator will animate the
    // decoration view instead and the presented view controller's view will
    // be a child of the decoration view.
    
    if ([transitionContext respondsToSelector:@selector(valueForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    }else
    {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    fromView.frame = [transitionContext initialFrameForViewController:fromViewController];
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    
    fromView.alpha = 0.0f;
    toView.alpha = 1.0f;
    
    // We are responsible for adding the incoming view to the containerView
    // for the presentation/dismissal.
    [containerView addSubview:toView];
    
    //创建一个黑色的背景,作为遮挡
    UIView *blackViewContainer = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    blackViewContainer.backgroundColor = [UIColor blackColor];
    [containerView addSubview:blackViewContainer];

    //判断前往和原来的视图是否是navi,因为pixBrowseCollectionView中没有Naiv
    UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>* toVC = toViewController;
    UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>* fromVC = fromViewController;
    if ([toViewController isKindOfClass:[UINavigationController class]]) {
        toVC = (UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>*)((UINavigationController *)toViewController).topViewController;
    }else if ([fromViewController isKindOfClass:[UINavigationController class]]) {
        fromVC = (UIViewController <FJSTranstionProtocol,PicMixViewControllerProtocol>*)((UINavigationController *)fromViewController).topViewController;
    }
    
    //获取对应视图的collectionView
    UICollectionView * toControllerCollectionView = [toVC transitionCollectionView];
    
    UICollectionView * fromControllerCollectionView = [fromVC transitionCollectionView];
    
    NSIndexPath *indexPath = [fromControllerCollectionView currentIndexPath];
    
    //获取当前cell,用于获取对应的图片
    UIView <FJSTranstionSnapProtocol> *cell =  (UIView <FJSTranstionSnapProtocol> *)[fromControllerCollectionView cellForItemAtIndexPath:indexPath];
    
    //为了只写一个动画效果,所以这里,在查看大图那边,itemSize需要和图片大小一样.
    UIView *snapShot = [cell snapShotForTransition];
    
    [containerView addSubview:snapShot];
    
    //这里由于imageView和cell并不是完全填充的,所以需要获取imageView
    CGPoint leftUpperPoint = [cell imageViewOringn];
    
    [snapShot setOrigin:leftUpperPoint];
    
    [toVC viewWillAppearWithCurrentIndex:indexPath.item];

    [toControllerCollectionView layoutIfNeeded];
    
    //后去将要显示的collectionView中对应cell的位置,然后移动到对应位置.
    UIView <FJSTranstionSnapProtocol>* toCell = (UIView <FJSTranstionSnapProtocol> *)[toControllerCollectionView cellForItemAtIndexPath:indexPath];
    
    CGPoint toPoint = [toCell convertPoint:CGPointZero toView:nil];
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    CGFloat animationScale = toCell.bounds.size.width / ScreenWidth;
    
    [UIView animateWithDuration:transitionDuration animations:^{
        snapShot.transform = CGAffineTransformMakeScale(animationScale,
                                                        animationScale);
        [snapShot setOrigin:toPoint];
        blackViewContainer.alpha = 0.f;
    } completion:^(BOOL finished) {
        // When we complete, tell the transition context
        // passing along the BOOL that indicates whether the transition
        // finished or not.
        [snapShot removeFromSuperview];
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
