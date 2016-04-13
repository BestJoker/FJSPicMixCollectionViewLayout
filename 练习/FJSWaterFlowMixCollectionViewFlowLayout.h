//
//  FJSWaterFlowMixCollectionViewFlowLayout.h
//  练习
//
//  Created by 付金诗 on 16/4/13.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FJSWaterFlowMixCollectionViewFlowLayout : UICollectionViewFlowLayout
//** The number of column when device orientation is portrait
//** 设备竖直时候的列数
@property(nonatomic,assign)NSUInteger ColOfPortrait;

//** The number of column when device orientation is landscape
//** 设备水平时候的列数
@property(nonatomic,assign)NSUInteger ColOfLandscape;

//** The threshold of double-colume.It's between 0~100.eg,you set DoubleColumnThreshold to 40,it means you will have 40 percent possibility have a double-column-width/height column.
//** 横跨双列出现概率的阈值。比如你指定 DoubleColumnThreshold 为40，那么将会有40%的可能性出现双列宽度或高度的列。
@property(nonatomic,assign)NSUInteger DoubleColumnProbality;

@property (nonatomic,strong)NSMutableArray * modelArray;

@end
