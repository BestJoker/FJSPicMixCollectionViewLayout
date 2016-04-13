//
//  FJSWaterFlowMixCollectionViewFlowLayout.m
//  练习
//
//  Created by 付金诗 on 16/4/13.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSWaterFlowMixCollectionViewFlowLayout.h"
#import "BQImageModel.h"
@interface FJSWaterFlowMixCollectionViewFlowLayout ()
@property (nonatomic,assign)NSUInteger columnsCount;
@property (nonatomic,strong)NSMutableArray * columnsHeightArray;//保存所有列高度的数组
@property (nonatomic,strong)NSMutableArray *itemsAttributes;//保存所有列高度的数组
@end
@implementation FJSWaterFlowMixCollectionViewFlowLayout
-(void)prepareLayout
{
    //根据屏幕方向确定总共需要的列数
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationLandscapeLeft | orientation ==  UIDeviceOrientationLandscapeRight){
        self.columnsCount = self.ColOfLandscape;
    }else{
        self.columnsCount = self.ColOfPortrait;
    }
    //确定所有item的个数
    NSUInteger itemCounts = [[self collectionView]numberOfItemsInSection:0];
    //初始化保存所有item attributes的数组
    self.itemsAttributes = [NSMutableArray arrayWithCapacity:itemCounts];
    
    //根据列数确定存储列高度的数组容量，全部置0
    //我们还需要维护一个存储高度的数组COLUMNSHEIGHTS。数组中有n个元素，n表示所有列数，如上图，n = 3。缓存的值表示当前列的高度，
    self.columnsHeightArray = [NSMutableArray arrayWithCapacity:self.columnsCount];
    for (NSInteger i = 0; i<self.columnsCount; i++) {
        [self.columnsHeightArray addObject:@(0)];
    }
    
    for (NSInteger i = 0; i < itemCounts; i++) {
        NSInteger shortestColumnIndex = [self getMostShortestRow];
        CGFloat shortHeight = [[self.columnsHeightArray objectAtIndex:shortestColumnIndex] floatValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        BQImageModel * model = [self.modelArray objectAtIndex:i];
        CGFloat itemHeight;
        CGFloat itemWidth;
        NSInteger random = arc4random() % 100;
        //如果不是最后一列,同时当前列和下一列的高度相同,同时满足跨列的概率,则允许跨列.为什么需要跨列百分比,如果没有的话,一旦出现一个跨列,那么下面对应的地方会一直出现跨列.
        if (shortestColumnIndex < self.columnsCount - 1 && shortHeight == [[self.columnsHeightArray objectAtIndex:(shortestColumnIndex + 1)] floatValue] && random < self.DoubleColumnProbality) {
            itemWidth = 2 * [self columnWidth];
            itemHeight = model.height / model.width * itemWidth;
            //在夸列的时候,同时需要修改当前和后面一个列的高度
            [self.columnsHeightArray replaceObjectAtIndex:shortestColumnIndex withObject:@(shortHeight + itemHeight)];
            [self.columnsHeightArray replaceObjectAtIndex:shortestColumnIndex + 1 withObject:@(shortHeight + itemHeight)];
        }else
        {
            itemWidth = [self columnWidth];
            itemHeight = model.height / model.width * itemWidth;
            [self.columnsHeightArray replaceObjectAtIndex:shortestColumnIndex withObject:@(shortHeight + itemHeight)];
        }
        attributes.frame = CGRectMake(shortestColumnIndex * [self columnWidth], shortHeight, itemWidth, itemHeight);
        [self.itemsAttributes addObject:attributes];
    }
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemsAttributes;
}

-(CGSize)collectionViewContentSize
{
    __block CGFloat mostHeightestRowHeight = 0.f;
    [self.columnsHeightArray enumerateObjectsUsingBlock:^(NSNumber * rowHeight, NSUInteger idx, BOOL * _Nonnull stop) {
        if (mostHeightestRowHeight < [rowHeight floatValue]) {
            mostHeightestRowHeight = [rowHeight floatValue];
        }
    }];
    return CGSizeMake(ScreenWidth, mostHeightestRowHeight);
}


#pragma mark -- 获取嘴短的列的下标
- (NSInteger)getMostShortestRow
{
    __block NSInteger mostShortRowIndex = 0;
    __block CGFloat mostShortRowHeight = CGFLOAT_MAX;
    [self.columnsHeightArray enumerateObjectsUsingBlock:^(NSNumber * rowHeight, NSUInteger idx, BOOL * _Nonnull stop) {
        if (mostShortRowHeight > [rowHeight floatValue]) {
            mostShortRowHeight = [rowHeight floatValue];
            mostShortRowIndex = idx;
        }
    }];
    return mostShortRowIndex;
}


//均分的宽度,注意：四舍五入成整数
- (CGFloat )columnWidth{
    return roundf(self.collectionView.bounds.size.width / self.columnsCount);
}

@end
