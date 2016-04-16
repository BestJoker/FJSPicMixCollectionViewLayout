//
//  MJRefreshConst.h
//  MJRefresh
//
//  Created by mj on 14-1-3.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

// objc_msgSend
#define msgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)


#define MJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 文字颜色
#define MJRefreshLabelTextColor MJColor(150, 150, 150)

extern const CGFloat MJRefreshViewHeight;
extern const CGFloat MJRefreshFastAnimationDuration;
extern const CGFloat MJRefreshSlowAnimationDuration;

extern NSString *const MJRefreshBundleName;
#define MJRefreshSrcName(file) [MJRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const MJRefreshFooterPullToRefresh;
extern NSString *const MJRefreshFooterReleaseToRefresh;
extern NSString *const MJRefreshFooterRefreshing;

extern NSString *const MJRefreshHeaderPullToRefresh;
extern NSString *const MJRefreshHeaderReleaseToRefresh;
extern NSString *const MJRefreshHeaderRefreshing;
extern NSString *const MJRefreshHeaderTimeKey;

extern NSString *const MJRefreshContentOffset;
extern NSString *const MJRefreshContentSize;