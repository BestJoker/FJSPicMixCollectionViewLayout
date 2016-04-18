//
//  BQImageModel.h
//  练习
//
//  Created by 付金诗 on 16/4/11.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BQImageModel : NSObject
@property (nonatomic,strong)UIImage * image;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat whScale;/**< 图片宽高比 */

@end
