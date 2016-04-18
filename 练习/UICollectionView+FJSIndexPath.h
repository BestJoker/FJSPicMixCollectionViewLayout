//
//  UICollectionView+FJSIndexPath.h
//  练习
//
//  Created by 付金诗 on 16/4/17 北京必趣科技有限公司 iOS开发工程师.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (FJSIndexPath)

/**
 *  设置某一indexPath，用于记录
 *
 *  @param indexPath 目标indexPath
 */
- (void)setCurrentIndexPath:(NSIndexPath *)indexPath;

/**
 *  获取上述方法某一indexPath，把记录起来的拿回来用
 *
 *  @return 返回记录的indexPath
 */
- (NSIndexPath *)currentIndexPath;

@end
