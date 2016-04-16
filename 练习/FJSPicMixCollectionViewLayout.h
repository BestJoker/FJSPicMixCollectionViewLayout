//
//  FJSPicMixCollectionViewLayout.h
//  练习
//
//  Created by 付金诗 on 16/4/12.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQImageModel.h"
@interface FJSPicMixCollectionViewLayout : UICollectionViewFlowLayout
@property (nonatomic,strong)NSMutableArray * modelArray;
@property (nonatomic,assign)BOOL isHeaderRefresh;/**< 区分是上拉加载还是下拉刷新 */
@end
