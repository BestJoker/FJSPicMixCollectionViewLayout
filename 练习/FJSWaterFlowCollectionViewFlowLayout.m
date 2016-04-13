//
//  FJSWaterFlowCollectionViewFlowLayout.m
//  练习
//
//  Created by 付金诗 on 16/4/13.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSWaterFlowCollectionViewFlowLayout.h"
#import "BQImageModel.h"
@interface FJSWaterFlowCollectionViewFlowLayout ()
@property (nonatomic,assign)NSUInteger columnsCount;
@property (nonatomic,strong)NSMutableArray * columnsHeightArray;//保存所有列高度的数组
@property (nonatomic,strong)NSMutableArray *itemsAttributes;//保存所有列高度的数组
@end
@implementation FJSWaterFlowCollectionViewFlowLayout

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
    /*
     坐标x应该是这样的:（最短列的编号-1）x 列宽
     
     坐标y应该是这样的:从COLUMNSHEIGHTS中取出最短列对应的高度
     
     所以我们需要一个算法来找出当前COLUMNSHEIGHTS中的最短的列，最直接的方法就是0(n)时间复杂度的循环比较，这里还好因为数据量比较少，如果遇到数据量大的情况可能就需要考虑分治法了。
     */
    for (NSInteger i = 0; i < itemCounts; i++) {
        NSInteger shortestColumnIndex = [self getMostShortestRow];
        CGFloat shortHeight = [[self.columnsHeightArray objectAtIndex:shortestColumnIndex] floatValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        BQImageModel * model = [self.modelArray objectAtIndex:i];
        CGFloat itemHeight = model.height / model.width * [self columnWidth];
        attributes.frame = CGRectMake(shortestColumnIndex * [self columnWidth], shortHeight, [self columnWidth], itemHeight);
        [self.itemsAttributes addObject:attributes];
        [self.columnsHeightArray replaceObjectAtIndex:shortestColumnIndex withObject:@(shortHeight + itemHeight)];
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


#pragma mark -- 获取嘴短的一个列的角标
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
