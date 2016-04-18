//
//  PicBrowseCollectionViewCell.m
//  练习
//
//  Created by 付金诗 on 16/4/17.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "PicBrowseCollectionViewCell.h"

@interface PicBrowseCollectionViewCell ()
@property (nonatomic,strong)BQImageModel * model;
@end
@implementation PicBrowseCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[FJSBroserScrollView alloc] initWithFrame:self.contentView.bounds];
        self.imageView.backgroundColor = [UIColor orangeColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)getValueFromBQImageModel:(BQImageModel *)model
{
    self.model = model;
    self.imageView.image = model.image;
}

-(FJSSnapPlaceView *)snapShotForTransition
{
    //由于图片放大是需要scrollview的配合,所以图片的实际高度,就与self.imageView不相同了.
    CGFloat height = self.model.height / self.model.width * ScreenWidth;
    FJSSnapPlaceView *snapShotView = [[FJSSnapPlaceView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height) ImageModel:self.model];
    return snapShotView;
    
}

- (CGPoint)imageViewOringn
{
    //由于self.imageView的坐标和self.contentView的坐标相同,所以这个地方的处理变化了一下.
    CGFloat height = self.model.height / self.model.width * ScreenWidth;
    CGFloat coorY = (ScreenHeight - height) * 0.5;
    return [self.contentView convertPoint:CGPointMake(0, coorY) toView:nil];
}

@end
