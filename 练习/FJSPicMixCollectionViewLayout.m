//
//  FJSPicMixCollectionViewLayout.m
//  练习
//
//  Created by 付金诗 on 16/4/12.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSPicMixCollectionViewLayout.h"

@interface FJSPicMixCollectionViewLayout ()
@property (nonatomic,assign)CGFloat contentHeight;/**< 总体高度 */
@property (nonatomic,strong)NSMutableArray * attributesArray;/**< 存放所有布局的array */
@end
@implementation FJSPicMixCollectionViewLayout
/*
 所以我们的思路是在- (void)prepareLayout;方法中算出所有item的frame，并赋值给当前item的  UICollectionViewLayoutAttributes。用图片的形式比较直观：
 */

-(void)prepareLayout
{
    [super prepareLayout];
    //确定所有item的个数
    NSUInteger itemCounts = [[self collectionView]numberOfItemsInSection:0];
    //初始化保存所有item attributes的数组
    self.attributesArray = [NSMutableArray arrayWithCapacity:itemCounts];
    [self getwholeRowFrame];    
}


- (void)getwholeRowFrame
{
    //设置一个宽度来记录和判断图片是否换行.
    CGFloat width = 0.f;
    //保存同一行图片的所有尺寸比例和,用来计算这一行图片的高度
    CGFloat scaleSum = 0.f;
    NSInteger currentIndex = 0;
    //不需要担心最后如果只有一张图的话,没有匹配如何显示,因为遍历的次数和图片的数量相同.
    for (NSInteger i = 0; i < self.modelArray.count; i++) {
        BQImageModel * model = [self.modelArray objectAtIndex:i];
        width = width + model.width;
        //        NSLog(@"%f===%f",scaleSum,model.whScale);
        scaleSum = scaleSum + model.whScale;
        //        NSLog(@"%f==%f",width,ScreenWidth - self.minimumInteritemSpacing * (i - currentIndex - 1));
        //累计图片宽度,如果宽度超过了屏宽减去间距,则换行
        if (width >= ScreenWidth - self.minimumInteritemSpacing * (i - currentIndex - 1)) {
            [self setAttributesFromCurrentIndex:currentIndex DestionIndex:i scaleSum:scaleSum];
            //换行之后需要重新清空累计的宽度 同时保存下一个currentIndex从第几行开始.
            width = 0.f;
            scaleSum = 0.f;
            currentIndex = i + 1;
        }
    }
}

- (void)setAttributesFromCurrentIndex:(NSInteger)currnetIndex DestionIndex:(NSInteger)destionIndex scaleSum:(CGFloat)scaleSum
{
    //根据公式计算出该行的高度
    CGFloat height = (ScreenWidth - (destionIndex - currnetIndex) * self.minimumInteritemSpacing) / scaleSum;
    //均分的宽度,注意：四舍五入成整数
    height = roundf(height);
    NSLog(@"从第%ld个到第%ld个,高度为%f",currnetIndex,destionIndex,height);
    for (NSInteger i = currnetIndex; i <= destionIndex; i++) {
        //给attributes.frame 赋值，并存入 self.itemsAttributes
        BQImageModel * model = [self.modelArray objectAtIndex:i];
        //根据计算出来的高度来根据图片比例计算出宽度
        CGFloat width = height * model.whScale;
        UICollectionViewLayoutAttributes * oldAttributes;
        /*如果不是这一行的第一个图片,需要获取上一张图片的UICollectionViewLayoutAttributes,用来计算当前的图片的x值.为什么不使用
         NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
         UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];方法来获取上一个内容呢?因为内容为空,都保存到数组self.attributesArray中了,所以直接获取.
         */
        if (i > currnetIndex) {
            NSInteger oldIndex = i - 1;
            oldAttributes = [self.attributesArray objectAtIndex:oldIndex];
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        /*获取当前的对应UICollectionViewLayoutAttributes,进行修改,然后保存到数组中
         x: 根据同一行,前一个视图进行累计,同时加上self.minimumInteritemSpacing
         y: 使用全局的属性记录.
         width和height都有计算好了.
         */
        CGFloat orignX = oldAttributes?CGRectGetMaxX(oldAttributes.frame) + self.minimumInteritemSpacing:0;
        attributes.frame = CGRectMake(orignX, self.contentHeight, width, height);
        //        NSLog(@"oldAttributes == %f\nself.contentHeight == %f\nwidth == %f\nheight == %f",CGRectGetMaxX(oldAttributes.frame),self.contentHeight,width,height);
        //        NSLog(@"第%ld个到第%ld个在一行",currnetIndex,destionIndex);
        [self.attributesArray addObject:attributes];
    }
    //累加记录高度的
    self.contentHeight = self.contentHeight + height + self.minimumLineSpacing;
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


//#pragma mark -- 返回collectionView的内容的尺寸
//-(CGSize)collectionViewContentSize
//{
//
//}


/*
 - 返回rect中的所有的元素的布局属性
 - 返回的是包含UICollectionViewLayoutAttributes的NSArray
 */
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//
//}


#pragma mark -- UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息，通过不同的UICollectionViewLayoutAttributes初始化方法可以得到不同类型的UICollectionViewLayoutAttributes：

#pragma mark -- 返回对应于indexPath的位置的cell的布局属性
//-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//

#pragma mark -- 返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
//-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//

#pragma mark -- 返回对应于indexPath的位置的装饰视图的布局属性，如果没有装饰视图可不重载
//-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
//{
//
//}
//
//-(UICollectionViewLayoutAttributes *)layoutAttributesForInteractivelyMovingItemAtIndexPath:(NSIndexPath *)indexPath withTargetPosition:(CGPoint)position
//{
//
//}


/*
 - 当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
 
 另外需要了解的是，在初始化一个UICollectionViewLayout实例后，会有一系列准备方法被自动调用，以保证layout实例的正确。
 
 首先，-(void)prepareLayout将被调用，默认下该方法什么没做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始需要的参数等。
 
 之后，-(CGSize) collectionViewContentSize将被调用，以确定collection应该占据的尺寸。注意这里的尺寸不是指可视部分的尺寸，而应该是所有内容所占的尺寸。collectionView的本质是一个scrollView，因此需要这个尺寸来配置滚动行为。
 
 接下来-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect被调用，这个没什么值得多说的。初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。
 
 另外，在需要更新layout时，需要给当前layout发送 -invalidateLayout，该消息会立即返回，并且预约在下一个loop的时候刷新当前layout，这一点和UIView的setNeedsLayout方法十分类似。在-invalidateLayout后的下一个collectionView的刷新loop中，又会从prepareLayout开始，依次再调用-collectionViewContentSize和-layoutAttributesForElementsInRect来生成更新后的布局。
 */
//-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
//{
//    return YES;
//}


@end
