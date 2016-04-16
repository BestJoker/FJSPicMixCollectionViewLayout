//
//  NewPicMixViewController.m
//  练习
//
//  Created by 付金诗 on 16/4/16.
//  Copyright © 2016年 www.fujinshi.com. All rights reserved.
//

#import "NewPicMixViewController.h"
#import "BQImageModel.h"
#import "MyCollectionViewCell.h"
#import "MJRefresh.h"
#import "NewFJSPicMixCollectionViewFlowLayout.h"
@interface NewPicMixViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSMutableArray * dataArray;
@property (nonatomic,strong)NewFJSPicMixCollectionViewFlowLayout * flowLayuot;
@property (nonatomic,assign)CGFloat contentHeight;/** 记录flowLayout的高度的 */
@end

@implementation NewPicMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flowLayuot = [[NewFJSPicMixCollectionViewFlowLayout alloc] init];
    self.flowLayuot.minimumLineSpacing = 1;
    self.flowLayuot.minimumInteritemSpacing = 1;
    self.flowLayuot.sectionInset = UIEdgeInsetsZero;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayuot];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = YES;
    [self.collectionView addHeaderWithTarget:self action:@selector(headerRefersh)];
    [self.collectionView addFooterWithTarget:self action:@selector(footerRefresh)];
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    [self headerRefersh];

}

- (void)headerRefersh
{
    NSInteger random = arc4random() % 20 + 10;
    self.dataArray = [NSMutableArray array];
    self.contentHeight = 0.f;
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
    [self getwholeRowFrame:self.dataArray];
    [self reloadDataArray];
    if (![self.collectionView isHeaderHidden]) {
        [self.collectionView headerEndRefreshing];
    }
}


- (void)footerRefresh
{
    NSInteger random = arc4random() % 20 + 10;
    NSMutableArray * array = [NSMutableArray array];
    for (NSInteger i = 0; i < random; i++) {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]];
        BQImageModel * imageModel = [[BQImageModel alloc] init];
        imageModel.image = image;
        //图片原来尺寸比较大,为了能够出现一行多张,所以处理了图片的宽度进行模拟.
        imageModel.width = image.size.width / 5.0f;
        imageModel.height = image.size.height / 5.0f;
        imageModel.whScale = image.size.width / image.size.height;
        //        NSLog(@"width == %f***height == %fwhScale===%f",imageModel.width,imageModel.height,imageModel.whScale);
        [array addObject:imageModel];
    }
    [self getwholeRowFrame:array];
    NSLog(@"%ld",)
    [self.dataArray addObjectsFromArray:array];
    [self reloadDataArray];
    if (![self.collectionView isFooterHidden]) {
        [self.collectionView footerEndRefreshing];
    }
}


#pragma mark -- 计算每一个item的位置
- (void)getwholeRowFrame:(NSMutableArray *)modelArray
{
    //设置一个宽度来记录和判断图片是否换行.
    CGFloat width = 0.f;
    //保存同一行图片的所有尺寸比例和,用来计算这一行图片的高度
    CGFloat scaleSum = 0.f;
    NSInteger currentIndex = 0;
    //不需要担心最后如果只有一张图的话,没有匹配如何显示,因为遍历的次数和图片的数量相同.
    for (NSInteger i = 0; i < modelArray.count; i++) {
        BQImageModel * model = [modelArray objectAtIndex:i];
        width = width + model.width;
        //        NSLog(@"%f===%f",scaleSum,model.whScale);
        scaleSum = scaleSum + model.whScale;
        //        NSLog(@"%f==%f",width,ScreenWidth - self.minimumInteritemSpacing * (i - currentIndex - 1));
        //换行之后需要重新清空累计的宽度 同时保存下一个currentIndex从第几行开始.
        //累计图片宽度,如果宽度超过了屏宽减去间距,则换行
        if (width >= ScreenWidth - self.flowLayuot.minimumInteritemSpacing * (i - currentIndex - 1)) {
            [self setAttributesFromCurrentIndex:currentIndex DestionIndex:i scaleSum:scaleSum modelArray:modelArray];
            //换行之后需要重新清空累计的宽度 同时保存下一个currentIndex从第几行开始.
            width = 0.f;
            scaleSum = 0.f;
            currentIndex = i + 1;
        }else
        {
            //如果是最后一行并没有满足超过屏宽,则将当前几个视图进行计算,铺满屏幕
            if (i == modelArray.count - 1) {
                [self setAttributesFromCurrentIndex:currentIndex DestionIndex:i scaleSum:scaleSum modelArray:modelArray];
            }
        }
    }
    
}

#pragma mark -- 根据这一行的第一个和最后一个index 以及比例和,加上model数组,为什么不使用self.modelArray,因为那样的话为了不重复计算,还是需要记录上一次数组有多少个.
- (void)setAttributesFromCurrentIndex:(NSInteger)currnetIndex DestionIndex:(NSInteger)destionIndex scaleSum:(CGFloat)scaleSum modelArray:(NSMutableArray *)modelArray
{
    //根据公式计算出该行的高度
    CGFloat height = (ScreenWidth - (destionIndex - currnetIndex) * self.flowLayuot.minimumInteritemSpacing) / scaleSum;
    //均分的宽度,注意：四舍五入成整数
    height = roundf(height);
    CGFloat orignX = 0.f;
    NSLog(@"从第%ld个到第%ld个,高度为%f",currnetIndex,destionIndex,height);
    for (NSInteger i = currnetIndex; i <= destionIndex; i++) {
        //给attributes.frame 赋值，并存入 self.itemsAttributes
        BQImageModel * model = [modelArray objectAtIndex:i];
        //根据计算出来的高度来根据图片比例计算出宽度
        CGFloat width = height * model.whScale;
        /*获取当前的对应UICollectionViewLayoutAttributes,进行修改,然后保存到数组中
         x: 根据同一行,前一个视图进行累计,同时加上self.minimumInteritemSpacing
         y: 使用全局的属性记录.
         width和height都有计算好了.
         */
        NSLog(@"oldAttributes == %f\nself.contentHeight == %f\nwidth == %f\nheight == %f",orignX,self.contentHeight,width,height);
        NSLog(@"第%ld个到第%ld个在一行",currnetIndex,destionIndex);
        model.frame = [NSValue valueWithCGRect:CGRectMake(orignX, self.contentHeight, width, height)];
        orignX = orignX + width + self.flowLayuot.minimumInteritemSpacing;
    }
    //累加记录高度的
    self.contentHeight = self.contentHeight + height + self.flowLayuot.minimumLineSpacing;
}




- (void)reloadDataArray
{
    self.flowLayuot.modelArray = self.dataArray;
    [self.collectionView reloadData];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BQImageModel * model = [self.dataArray objectAtIndex:indexPath.item];
    NSLog(@"数组数量: %ld",self.dataArray.count);
    CGRect frame = [model.frame CGRectValue];
    NSLog(@"%@==%@",model.frame,NSStringFromCGRect(frame));
    return CGSizeMake(frame.size.width, frame.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    BQImageModel * model = [self.dataArray objectAtIndex:indexPath.item];
    cell.imageView.image = model.image;
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
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
