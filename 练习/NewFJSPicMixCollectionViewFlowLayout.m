//
//  NewFJSPicMixCollectionViewFlowLayout.m
//  练习
//
//  Created by 付金诗 on 16/4/16.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "NewFJSPicMixCollectionViewFlowLayout.h"

@interface NewFJSPicMixCollectionViewFlowLayout ()
@property (nonatomic,strong)NSMutableArray * attributesArray;/**< 存放所有布局的array */
@end
@implementation NewFJSPicMixCollectionViewFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    //确定所有item的个数
    NSUInteger itemCounts = [[self collectionView]numberOfItemsInSection:0];
    //初始化保存所有item attributes的数组
    self.attributesArray = [NSMutableArray arrayWithCapacity:itemCounts];
    [self.modelArray enumerateObjectsUsingBlock:^(BQImageModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = [obj.frame CGRectValue];
        [self.attributesArray addObject:attributes];
    }];
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributesArray;
}


-(CGSize)collectionViewContentSize
{
    //使用数组中最后一个布局来进行滚动内容的高度,而不是self.contentHeight,原因是需要判断是否是最后一个图片的那一行,如果是不需要累加self.minimumLineSpacing.
    UICollectionViewLayoutAttributes * lastAttributes = [self.attributesArray lastObject];
    return CGSizeMake(ScreenWidth, CGRectGetMaxY(lastAttributes.frame));
}

@end
