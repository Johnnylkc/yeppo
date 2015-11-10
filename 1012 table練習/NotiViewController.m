//
//  NotiViewController.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/11/7.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "NotiViewController.h"

#import "MessageViewController.h"

@interface NotiViewController ()

@property (weak, nonatomic) IBOutlet UIView *notiView;


@end

@implementation NotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.notiView.layer.cornerRadius = 5;
    
}



- (IBAction)toMess:(id)sender
{

//MessageViewController *controller =
//    [self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
//    
//    [self presentViewController:controller animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

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
