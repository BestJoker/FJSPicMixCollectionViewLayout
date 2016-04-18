//
//  PicBrowseCollectionViewCell.h
//  练习
//
//  Created by 付金诗 on 16/4/17.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJSBroserScrollView.h"
@interface PicBrowseCollectionViewCell : UICollectionViewCell<FJSTranstionSnapProtocol>
@property (nonatomic,strong)UIViewController * superViewController;/**< 所在VC,用来相应点击图片消失 */
@property (nonatomic,strong)FJSBroserScrollView * imageView;
- (void)getValueFromBQImageModel:(BQImageModel *)model;
@end
