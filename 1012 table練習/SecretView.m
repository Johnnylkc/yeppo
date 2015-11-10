//
//  SecretView.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/30.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "SecretView.h"

@interface SecretView () <UIScrollViewDelegate>
{
    
    UIImageView *imageView ;
    
}



@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@end



@implementation SecretView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    

    self.scroller.delegate = self;
    
    self.scroller.contentSize =
    CGSizeMake([UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height );

    
    
    
    float screenWidth = [UIScreen mainScreen].bounds.size.width;

    if (screenWidth == 320) {
        
           imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 320, 400)];
        
    }else if (screenWidth == 375){
        
        
           imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 455)];

    }else{
        
           imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 414, 494)];

        
    }
    
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
   
    imageView.image = self.catchImage;
    
    [self.scroller addSubview:imageView];


}


///zoom in
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return  imageView ;
    
}



////這是往上滑返回前頁
- (IBAction)swipeBack:(id)sender
{

    [self dismissViewControllerAnimated:YES completion:nil];


}



///這是往下滑回前頁
- (IBAction)swipeBack02:(id)sender
{

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
