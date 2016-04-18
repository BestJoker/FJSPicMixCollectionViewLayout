//
//  FJSBroserScrollView.h
//  练习
//
//  Created by 付金诗 on 16/4/18.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJSBroserScrollView : UIScrollView
@property (nonatomic,copy) void (^tapBackBlcok)();/** <单机图片消失的block */
@property (nonatomic,strong)UIImage * image;
- (void)setImageWithImageStr:(NSString *)imageStr;
@end
