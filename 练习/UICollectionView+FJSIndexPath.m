//
//  UICollectionView+FJSIndexPath.m
//  练习
//
//  Created by 付金诗 on 16/4/17.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "UICollectionView+FJSIndexPath.h"
#import <objc/runtime.h>
static NSString * const FJSIndexPathKey = @"FJSIndexPathKey";

@implementation UICollectionView (FJSIndexPath)

-(void)setCurrentIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.item);
    objc_setAssociatedObject(self, &FJSIndexPathKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


-(NSIndexPath *)currentIndexPath
{
    NSInteger index = self.contentOffset.x / self.frame.size.width;
    NSIndexPath *indexPath = objc_getAssociatedObject(self, &FJSIndexPathKey);
    NSLog(@"获取当前位置 %ld===%ld",index,indexPath.item);
    if (index > 0) {
        return [NSIndexPath indexPathForRow:index inSection:0];
    } else if (indexPath) {
        return indexPath;
    } else {
        return [NSIndexPath indexPathForRow:0 inSection:0];
    }
}



@end
