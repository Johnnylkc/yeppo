//
//  PersonCollectionViewController.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/16.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "PersonCollectionViewController.h"
#import "Person01CollectionViewCell.h"
#import "PersonHeader.h"
#import "DetailPhoto.h"
#import "DetailPhotoCell.h"

#import "MessageViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+AFNetworking.h"



@interface PersonCollectionViewController () <UICollectionViewDelegateFlowLayout>


@end

CGFloat minimumLineSpacing = 2.0;
CGFloat minimumInteritemSpacing = 2.0;
CGFloat topInset = 225.0;
CGFloat leftInset = 0.0 ;
CGFloat buttomInset = 0.0 ;
CGFloat rightInset = 0.0 ;
CGFloat coloumnCount = 3 ;



@implementation PersonCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"array %@", self.photoArray);
    
    
}


- (IBAction)followButPressed:(UIButton*)sender {
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"loginToken"];
    NSString *url = @"http://www.yeppo.site/api/v1/relationships";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    NSDictionary *dic = @{@"followed_id":self.userDic[@"userId"],
                          @"auth_token":token};
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [sender setTitle:@"已收藏" forState:UIControlStateNormal];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"error %@", error);
        
    }];

    
    
}


///////客製化header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        PersonHeader *headerView =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
       
        //大頭照的圖片設定
        UIImageView *headPhoto01 = headerView.headPhoto01;
        
        
        NSString *urlStr = self.userDic[@"headPhoto"];
        
        if([urlStr hasPrefix:@"http"]) {

            NSURL *url = [NSURL URLWithString:urlStr];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [headPhoto01 setImageWithURLRequest:request
                                  placeholderImage:nil
                                           success:nil
                                           failure:nil];

        }
        
        headPhoto01.contentMode = UIViewContentModeScaleAspectFill;
        
        //圓形大頭照
        headPhoto01.layer.cornerRadius = headPhoto01.frame.size.height/2;
        headPhoto01.clipsToBounds = YES;
        
        //框的設定
        headPhoto01.layer.borderWidth = 2 ;
        headPhoto01.layer.borderColor = [UIColor whiteColor].CGColor;
        
        //user使用者名稱
        headerView.nameLabel01.text = self.userDic[@"userName"];
        
        
        
        //設定followButton的外型
        [headerView.followButton  setTitle:@"收藏" forState:normal];
        headerView.followButton.layer.cornerRadius = 6;
        headerView.followButton.backgroundColor =
        [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
       
        
        //設定私訊button的外型
        [headerView.talkButton setTitle:@"私訊" forState:normal];
        headerView.talkButton.layer.cornerRadius = 6;
        headerView.talkButton.backgroundColor =
        [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
          
        reusableview = headerView;
    }
    
    
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




- (IBAction)leaveMessageButton:(id)sender
{



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
    return self.photoArray.count;
}




//cell內容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Person01CollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *userPostPhoto = cell.userPostPhoto;
   
    //userPostPhoto.image = photoArray[indexPath.row];
    
    NSDictionary *dic = self.photoArray[indexPath.row];
    NSString *urlStr = dic[@"photo"];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [userPostPhoto setImageWithURLRequest:request
                       placeholderImage:nil
                                success:nil
                                failure:nil];

    return cell;
}



///照片到下一頁
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        
        Person01CollectionViewCell *cell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        DetailPhoto *nextPage = [segue destinationViewController];
       
        NSDictionary *dic = self.photoArray[indexPath.item];
        NSString *urlStr = dic[@"photo"];
        nextPage.urlStr = urlStr;
        
    }
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
