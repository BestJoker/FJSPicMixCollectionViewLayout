//
//  FJSBroserScrollView.m
//  练习
//
//  Created by 付金诗 on 16/4/18.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "FJSBroserScrollView.h"

static CGFloat const kMaxZoom = 2.0f;
static CGFloat const kMinZoom = 1.0f;

@interface FJSBroserScrollView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,assign)CGFloat scale;/**< 记录当前比例*/
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation FJSBroserScrollView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        self.delegate = self;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bouncesZoom = YES;
        self.scrollEnabled = YES;
        self.minimumZoomScale = kMinZoom;
        self.maximumZoomScale = kMaxZoom;
        self.scale = 1.0f;
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        
        [self addGestures];
    }
    return self;
}

#pragma mark --这里可以传入图片网址,进行网络请求等处理
- (void)setImageWithImageStr:(NSString *)imageStr
{
    
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)addGestures {
    // 添加双击手势，用于方法图片
    UITapGestureRecognizer *doubleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleGesture:)];
    doubleGesture.numberOfTapsRequired = 2;
    doubleGesture.numberOfTouchesRequired = 1;
    [self.imageView addGestureRecognizer:doubleGesture];
}

- (void)doubleGesture:(UITapGestureRecognizer *)tapGesture {
    if (self.scale > kMinZoom) {
        [self setZoomScale:kMinZoom animated:YES];
    }
    else{
        CGRect zoomRect = [self zoomRectForScale:kMaxZoom withCenter:[tapGesture locationInView:self]];
        [self zoomToRect:zoomRect animated:YES];
    }

}

- (CGRect)zoomRectForScale:(CGFloat)scale withCenter:(CGPoint)touch {
    CGRect zoomRect = CGRectZero;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width / scale;
    zoomRect.origin.x = touch.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = touch.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    self.scale = scale;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = _imageView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width/2.0f, contentSize.height/2.0f);
    if (imgFrame.size.width <= boundsSize.width){
        centerPoint.x = boundsSize.width/2.0f;
    }
    
    if (imgFrame.size.height <= boundsSize.height){
        centerPoint.y = boundsSize.height/2.0f;
    }
    _imageView.center = centerPoint;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
