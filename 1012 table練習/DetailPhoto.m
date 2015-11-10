//
//  DetailPhoto.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/19.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "DetailPhoto.h"
#import "DetailPhotoCell.h"
#import "MessageViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailPhoto ()
{
    
    
}

@end

@implementation DetailPhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


///////cell內容

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    DetailPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailPhotoCell" forIndexPath:indexPath];
    
   
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView *imageView;
    
    if(screenWidth == 320) {
        imageView =
        [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
        
    }else if (screenWidth == 375)
    {
        imageView =
        [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 505)];
        
    }else{
        imageView =
        [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 494)];
        
    }
    
   
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = _deatilPhoto ;
    imageView.tag = 999;
    [cell.detailPhotoCellScrollView addSubview:imageView];
    cell.detailPhotoCellScrollView.delegate = self;
    
 
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [imageView setImageWithURLRequest:request
                         placeholderImage:nil
                                  success:nil
                                  failure:nil];

    
    return cell ;
}




////zoom in
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  [scrollView viewWithTag:999];
}




///按留言按鈕轉到留言頁面
//- (IBAction)messageToNext:(id)sender
//{
//
//    MessageViewController *controller =
//    [self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
//    
//    controller.modalPresentationStyle = UIModalTransitionStylePartialCurl;
//    
//    [self presentViewController:controller animated:YES completion:nil];
//
//}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
