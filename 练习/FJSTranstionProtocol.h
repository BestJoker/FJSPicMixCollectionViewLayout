//
//  FJSTranstionProtocol.h
//  练习
//
//  Created by 付金诗 on 16/4/17.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJSSnapPlaceView.h"
@protocol FJSTranstionProtocol <NSObject>
@optional
/**
 *  获取需要变换的CollectionView
 *
 *  @return 目标变换CollectionView
*/
- (UICollectionView *)transitionCollectionView;

@end

@protocol FJSTranstionSnapProtocol <NSObject>

/**
 *  获取需要缩放的快照View
 *
 *  @return 目标快照
 */
- (FJSSnapPlaceView *)snapShotForTransition;

- (CGPoint)imageViewOringn;

@end

@protocol PicMixViewControllerProtocol <NSObject>

/**
 *  当详情页面进行左右滑动之后，需要回调告诉父视图控制器
 *
 *  @param pageIndex 某一页码
 */
- (void)viewWillAppearWithCurrentIndex:(NSInteger)pageIndex;

@end

















