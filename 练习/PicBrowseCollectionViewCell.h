//
//  PicBrowseCollectionViewCell.h
//  练习
//
//  Created by 付金诗 on 16/4/17.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSTranstionProtocol.h"
#import "FJSSnapPlaceView.h"
#import "BQImageModel.h"
@interface PicBrowseCollectionViewCell : UICollectionViewCell<FJSTranstionSnapProtocol>
@property (nonatomic,strong)UIImageView * imageView;
- (void)getValueFromBQImageModel:(BQImageModel *)model;
@end
