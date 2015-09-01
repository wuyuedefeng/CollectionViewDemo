//
//  ITDBannerViewController.m
//  WSCollectionView
//
//  Created by TX-009 on 15/6/15.
//  Copyright (c) 2015年 TX-009. All rights reserved.
//

#import "ITDBannerViewController.h"

@interface ITDBannerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

//@property(nonatomic, strong) UICollectionView *collecitonView;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger bannerWidth;

@property (nonatomic, strong) NSArray *imageUrlStrArray;

@end

@implementation ITDBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _imageUrlStrArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    UIView *collectionViewContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 150)];
    _bannerWidth = collectionViewContainer.frame.size.width;
    [scrollView addSubview:collectionViewContainer];
    
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewContainer.bounds collectionViewLayout:flowLayout];
    [collectionViewContainer addSubview:collectionView];
    
    [collectionView setShowsHorizontalScrollIndicator:NO];
    
    collectionView.backgroundColor = [UIColor redColor];
    
    collectionView.pagingEnabled = YES;
    
    static NSString *identify = @"collectionCell";
    //注册单元格
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identify];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    if (_imageUrlStrArray.count > 0){
        collectionView.contentOffset = CGPointMake(CGRectGetWidth(collectionView.frame), 0);
    }
    

    
    [scrollView addSubview:collectionViewContainer];
    
    [self setPageControlInView:collectionViewContainer];
}

- (void)setPageControlInView:(UIView *)view
{
    int pagesCount =5;
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    _pageControl = pageControl;
    pageControl.center = CGPointMake(view.frame.size.width/2, view.frame.size.height-15); // 设置pageControl的位置
    pageControl.numberOfPages = pagesCount;
    pageControl.currentPage = 0;
    
    [view addSubview:pageControl];
}

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"collectionCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((2 * indexPath.row) / 255.0) green:( 1 - (20 * indexPath.row)/255.0) blue:(1 - (30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.bounds.size.width , 150);
}

//定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0f;
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int num = (scrollView.contentOffset.x + _bannerWidth / 2.0)  / _bannerWidth ;
    _pageControl.currentPage = num;
    NSLog(@"%d",num);
}

@end
