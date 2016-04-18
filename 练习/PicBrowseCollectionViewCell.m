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
        self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
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
    CGFloat height = model.height / model.width * ScreenWidth;
    CGFloat coorY = (ScreenHeight - height) * 0.5;
    [self.imageView setFrame:CGRectMake(0, coorY, ScreenWidth, height)];
    self.imageView.image = model.image;
}


-(FJSSnapPlaceView *)snapShotForTransition
{
    NSLog(@"----%@",NSStringFromCGRect(self.imageView.frame));
    FJSSnapPlaceView *snapShotView = [[FJSSnapPlaceView alloc] initWithFrame:self.imageView.bounds ImageModel:self.model];    
    return snapShotView;
    
}

- (CGPoint)imageViewOringn
{
    return [self.contentView convertPoint:self.imageView.frame.origin toView:nil];
}

@end
