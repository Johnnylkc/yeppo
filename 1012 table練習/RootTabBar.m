//
//  RootTabBar.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/11/1.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "RootTabBar.h"

#import "CameraViewController.h"

#import "CameraNew.h"

@interface RootTabBar () <UITabBarControllerDelegate , UIImagePickerControllerDelegate ,UINavigationBarDelegate>


@property (weak, nonatomic) IBOutlet UITabBar *rootTab;


@end

@implementation RootTabBar

- (void)viewDidLoad {
    [super viewDidLoad];

    ///tabbar被選到的顏色設定
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];

    //navbar 返回的顏色
    [[UINavigationBar appearance] setTintColor:[UIColor yellowColor]];

    
    
    ////在tabbar某處加按鈕
        float butWidth = [UIScreen mainScreen].bounds.size.width / 5;
    
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(butWidth*2, 0, butWidth, 49)];
    
        but.backgroundColor = [UIColor clearColor];
    
        [self.tabBar addSubview:but];
    
        [but addTarget:self action:@selector(butPressed:)forControlEvents:UIControlEventTouchUpInside];
        

}





-(void)butPressed:(id)sender
{
    CameraNew *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"CameraNew"];
    
    [self presentViewController:controller animated:YES completion:nil];
 
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
