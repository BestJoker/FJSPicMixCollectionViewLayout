//
//  FJSWaterFlowCollectionViewFlowLayout.h
//  练习
//
//  Created by 付金诗 on 16/4/13.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FJSWaterFlowCollectionViewFlowLayout : UICollectionViewFlowLayout
//** The number of column when device orientation is portrait
//** 设备竖直时候的列数
@property(nonatomic,assign)NSUInteger ColOfPortrait;

//** The number of column when device orientation is landscape
//** 设备水平时候的列数
@property(nonatomic,assign)NSUInteger ColOfLandscape;

@property (nonatomic,strong)NSMutableArray * modelArray;

@end
