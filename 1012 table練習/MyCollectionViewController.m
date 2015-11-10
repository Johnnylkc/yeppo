//
//  MyCollectionViewController.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/29.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyCollectionViewCell.h"
#import "MyCollectionReusableView.h"



@interface MyCollectionViewController () <UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *myPhotoArray;

}




@end

extern CGFloat minimumLineSpacing;
extern CGFloat minimumInteritemSpacing;
extern CGFloat topInset;
extern CGFloat leftInset;
extern CGFloat buttomInset;
extern CGFloat rightInset;
extern CGFloat coloumnCount;


@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"MyCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
  
    myPhotoArray = [[NSArray arrayWithObjects:
                  [UIImage imageNamed:@"m1"],
                  [UIImage imageNamed:@"w2"],
                  [UIImage imageNamed:@"m3"],
                  [UIImage imageNamed:@"w4"],
                  [UIImage imageNamed:@"005"],
                  [UIImage imageNamed:@"006"],
                  [UIImage imageNamed:@"007"],
                  [UIImage imageNamed:@"m8"],
                  [UIImage imageNamed:@"009"],
                  [UIImage imageNamed:@"010"],
                  [UIImage imageNamed:@"011"],
                  [UIImage imageNamed:@"012"],
                  [UIImage imageNamed:@"013"],
                  [UIImage imageNamed:@"014"],
                  [UIImage imageNamed:@"015"],nil]mutableCopy];
    

    
    
  //  myPhotoArray = [[NSMutableArray alloc] init];
    

//    [[NSNotificationCenter defaultCenter]addObserver:self
//                                            selector:@selector(addPhoto:)
//                                                name:@"addMyPhoto"
//                                              object:nil];







}

///執行在viewdidload裡接收廣播要執行的任務：把照片加到myPhotoArray 然後reloadData
//-(void)addPhoto:(NSNotification*)noti
//{
//    
//    NSDictionary *catchPhoto = noti.userInfo ;
//    
//    [myPhotoArray insertObject:catchPhoto atIndex:0];
//    
//    [self.collectionView reloadData];
//    
//    
//}







///客制header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        
    MyCollectionReusableView *headerView =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyCollectionReusableView" forIndexPath:indexPath];

        //背景圖片
        headerView.backPhoto.image = [UIImage imageNamed:@"aaa"];
        headerView.backPhoto.contentMode = UIViewContentModeScaleToFill ;
        
        //大頭照
        headerView.userHeadPhoto.image = [UIImage imageNamed:@"014"];
        headerView.userHeadPhoto.contentMode = UIViewContentModeScaleAspectFit;
        headerView.userHeadPhoto.layer.cornerRadius = 45;
        headerView.userHeadPhoto.layer.borderWidth = 2;
        headerView.userHeadPhoto.layer.masksToBounds = YES;
        headerView.userHeadPhoto.layer.borderColor = [UIColor whiteColor].CGColor;

        
        //編輯按鈕
        headerView.editButton.layer.cornerRadius = 15;
        //headerView.editButton.layer.backgroundColor = nil ;
        //headerView.editButton.layer.borderWidth = 2;
        //headerView.editButton.layer.borderColor = [UIColor yellowColor].CGColor;
        
        //userName
        headerView.nameLabel.text = @"johnny";
        
        
        reusableview = headerView;
        
    }//if
   
    return reusableview;
    
}




//item與item左右之間的距離
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return minimumInteritemSpacing;
}

//item上下之間的距離
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return minimumLineSpacing;
}





//item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    
    CGFloat itemWidth =
    (screenWidth - leftInset - rightInset - minimumLineSpacing * (coloumnCount-1)) / coloumnCount ;
    
    return CGSizeMake( itemWidth  , itemWidth );
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return myPhotoArray.count;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    MyCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCollectionViewCell" forIndexPath:indexPath];
    
    
    cell.myPostPhoto.image = myPhotoArray[indexPath.row];
    
    return cell;
}






















#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
