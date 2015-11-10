//
//  CameraViewController.h
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/13.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imagePicked;




@property (weak , nonatomic) UIImage *catchPhoto;///接

@end
