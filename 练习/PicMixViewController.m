//
//  PicMixViewController.m
//  练习
//
//  Created by 付金诗 on 16/4/13.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "PicMixViewController.h"
#import "FJSPicMixCollectionViewLayout.h"
#import "FJSPicCenterMaxCollectionViewFlowLayout.h"
#import "FJSWaterFlowCollectionViewFlowLayout.h"
#import "FJSWaterFlowMixCollectionViewFlowLayout.h"
#import "BQImageModel.h"
#import "MyCollectionViewCell.h"
#import "MJRefresh.h"
#import "FJSBrowseViewController.h"
#import "FJSBrowserTranstionAnimation.h"
#import "FJSBrowserDismissTranstionAnimation.h"
@interface PicMixViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIViewControllerTransitioningDelegate>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)UICollectionViewFlowLayout * flowLayuot;
@end

@implementation PicMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (self.type) {
        case 0:
        {
            self.flowLayuot = [[FJSPicMixCollectionViewLayout alloc] init];
            self.flowLayuot.minimumLineSpacing = 1;
            self.flowLayuot.minimumInteritemSpacing = 1;
            self.flowLayuot.sectionInset = UIEdgeInsetsZero;
        }
            break;
        case 1:
        {
            self.flowLayuot = [[FJSPicCenterMaxCollectionViewFlowLayout alloc] init];            
        }
            break;
        case 2:
        {
            self.flowLayuot = [[FJSWaterFlowCollectionViewFlowLayout alloc] init];
            ((FJSWaterFlowCollectionViewFlowLayout *)self.flowLayuot).ColOfPortrait = 3;
            ((FJSWaterFlowCollectionViewFlowLayout *)self.flowLayuot).ColOfLandscape = 4;
        }
            break;
        case 3:
        {
            self.flowLayuot = [[FJSWaterFlowMixCollectionViewFlowLayout alloc] init];
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).ColOfPortrait = 3;
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).ColOfLandscape = 4;
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).DoubleColumnProbality = 20;
        }
            break;
        default:
            break;
    }
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayuot];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefersh)];
    [self.collectionView addFooterWithTarget:self action:@selector(footerRefresh)];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    [self headerRefersh];
    
}

- (void)headerRefersh
{
    NSInteger random = arc4random() % 20 + 10;
    self.dataArray = [NSMutableArray array];
    for (NSInteger i = 0; i < random; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]];
        BQImageModel * imageModel = [[BQImageModel alloc] init];
        imageModel.image = image;
        //图片原来尺寸比较大,为了能够出现一行多张,所以处理了图片的宽度进行模拟.
        imageModel.width = image.size.width / 5.0f;
        imageModel.height = image.size.height / 5.0f;
        imageModel.whScale = image.size.width / image.size.height;
        //        NSLog(@"width == %f***height == %fwhScale===%f",imageModel.width,imageModel.height,imageModel.whScale);
        [self.dataArray addObject:imageModel];
    }
    [self reloadDataArrayIsHeadreRefresh:YES];
    if (![self.collectionView isHeaderHidden]) {
        [self.collectionView headerEndRefreshing];
    }
}


- (void)footerRefresh
{
    NSInteger random = arc4random() % 20 + 10;
    for (NSInteger i = 0; i < random; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]];
        BQImageModel * imageModel = [[BQImageModel alloc] init];
        imageModel.image = image;
        //图片原来尺寸比较大,为了能够出现一行多张,所以处理了图片的宽度进行模拟.
        imageModel.width = image.size.width / 5.0f;
        imageModel.height = image.size.height / 5.0f;
        imageModel.whScale = image.size.width / image.size.height;
        //        NSLog(@"width == %f***height == %fwhScale===%f",imageModel.width,imageModel.height,imageModel.whScale);
        [self.dataArray addObject:imageModel];
    }
    [self reloadDataArrayIsHeadreRefresh:NO];
    if (![self.collectionView isFooterHidden]) {
        [self.collectionView footerEndRefreshing];
    }
}


- (void)reloadDataArrayIsHeadreRefresh:(BOOL)isHeaderRefresh
{
    switch (self.type) {
        case 0:
        {
            ((FJSPicMixCollectionViewLayout *)self.flowLayuot).modelArray = self.dataArray;
            ((FJSPicMixCollectionViewLayout *)self.flowLayuot).isHeaderRefresh = isHeaderRefresh;
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            ((FJSWaterFlowCollectionViewFlowLayout *)self.flowLayuot).modelArray = self.dataArray;
        }
            break;
        case 3:
        {
            ((FJSWaterFlowMixCollectionViewFlowLayout *)self.flowLayuot).modelArray = self.dataArray;
        }
            break;
        default:
            break;
    }
    /*
     若结合下拉刷新的情况，即下拉刷新请求完成后，contentInset会设置回去，同时若reloaddata会出现屏幕大篇幅闪白，解决方案可延迟reloaddata，即等下拉恢复原位在调
     */
    static BOOL isInDuration = NO;
    if (isInDuration) {
        return;
    }
    isInDuration = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        isInDuration = NO;
        [self.collectionView reloadData];
    });
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.dataArray.count);
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    BQImageModel * model = [self.dataArray objectAtIndex:indexPath.item];
    [cell getValueFromBQImageModel:model];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    FJSBrowseViewController * browserVC = [[FJSBrowseViewController alloc] initModelArray:self.dataArray];
    [collectionView setCurrentIndexPath:indexPath];
    browserVC.transitioningDelegate = self;
    [self presentViewController:browserVC animated:YES completion:^{
        
    }];
}


- (UICollectionView *)transitionCollectionView
{
    return self.collectionView;
}


#pragma mark UIViewControllerTransitioningDelegate
//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the presentation of the incoming view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  presentation animation should be used.
//

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [FJSBrowserTranstionAnimation new];
}


//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the dismissal of the presented view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  dismissal animation should be used.
//

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [FJSBrowserDismissTranstionAnimation new];
}

-(void)viewWillAppearWithCurrentIndex:(NSInteger)pageIndex
{
    
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:pageIndex inSection:0];
    
    [self.collectionView setCurrentIndexPath:currentIndexPath];
    
    //返回来的时候,如果滑动的视图超出了屏幕使用格瓦拉那样的效果可能体验不是很好.
    [self.collectionView scrollToItemAtIndexPath:currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
