//
//  CameraViewController.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/13.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "CameraViewController.h"
#import "MyCollectionViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>


@interface CameraViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *filter001;

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imagePicked.image = self.catchPhoto;
    
}


- (IBAction)openPhotoLibraryButton:(id)sender {
   
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        
        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        picker.allowsEditing = true;
        
        [self presentViewController:picker animated:true completion:nil];
    }

}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [userDefault objectForKey:@"loginToken"];
    NSString *userId = [userDefault objectForKey:@"userId"];
    
    
    NSLog(@"token %@", token);
    
    if (token != nil) {
        
        NSLog(@"ddd");
        
        
        NSString *apiName = [NSString stringWithFormat:@"http://www.yeppo.site/api/v1/users/%@/shots",
                             userId];
        
        
        
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
      NSDictionary *parameters = @{@"description": @"hello",
                                     @"shot_type":@"model",
                                     @"auth_token":token
                                     
                                     };
        
        NSLog(@"apiName:%@", apiName);
        [manager POST:apiName parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            //UIImage *image = self.imagePicked.image;
            
            
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];

            
            CGSize size = CGSizeMake(300, image.size.height * 300 /
                                     image.size.width);
            UIGraphicsBeginImageContextWithOptions(size, NO, 0);
            [image drawInRect:CGRectMake(0, 0, size.width,
                                         size.height)];
            UIImage *resizeImage =
            UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        
            
            NSData *imageData = UIImagePNGRepresentation(resizeImage);
            
            
            [formData appendPartWithFileData:imageData name:@"photo" fileName:@"photo.png"
                                    mimeType:@"image/png"];
            
            
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSData *imageData = UIImageJPEGRepresentation(self.imagePicked.image, 0.6);
            UIImage *compressedJPGImage = [UIImage imageWithData:imageData];
            UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil);
            
            ////若上傳成功出現alertAcrtion
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"照片已上傳"
                                                                          message:@" "
                                                                   preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 
                                                                 
                                                                 
                                                             }];
            
            
            [alert addAction:okButton];
            
            [self presentViewController:alert animated:YES completion:nil];
            
            
            NSLog(@"Success: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"Error: %@", error);
        }];
    }

    
    
   }





///上傳照片和存到相機膠卷
- (IBAction)saveImageButton:(id)sender
{

    [SVProgressHUD show];

    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"loginToken"];
    NSString *userId = [userDefault objectForKey:@"userId"];
    
    
    NSLog(@"token %@", token);
    
    if (token != nil) {
        
        NSLog(@"ddd");
        
        NSString *apiName = @"http://www.yeppo.site/api/v1/shots";
  
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
       
        
        NSDictionary *parameters = @{@"description": @"hello",
                                     @"shot_type":@"model",
                                     @"auth_token":token
                                     
                                     };
        
        NSLog(@"apiName:%@", apiName);
    [manager POST:apiName parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            UIImage *image = self.imagePicked.image;
            
            CGSize size =
            CGSizeMake(300, image.size.height * 300 / image.size.width);
            
            UIGraphicsBeginImageContextWithOptions(size, NO, 0);
            
            [image drawInRect:CGRectMake(0, 0, size.width,size.height)];
            UIImage *resizeImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            NSData *imageData = UIImagePNGRepresentation(resizeImage);
            

            NSLog(@"image %@ %@ ", self.imagePicked, resizeImage);

            
            
            [formData appendPartWithFileData:imageData name:@"photo" fileName:@"photo.png"
                                    mimeType:@"image/png"];


            
       } success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           [SVProgressHUD dismiss];

           
           [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateFeedNoti" object:nil];
           
           NSData *imageData = UIImageJPEGRepresentation(self.imagePicked.image, 0.4);
           
           UIImage *compressedJPGImage = [UIImage imageWithData:imageData];
           
           UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil);
           
           
           NSLog(@"上傳喔");
           ////設定出現alertAcrtion
           
           
           
           UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"照片已上傳"
                                                                         message:@" "
                                                                  preferredStyle:UIAlertControllerStyleAlert];
           
           
           UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                   
                                                            }];
           
           
           [alert addAction:okButton];
           
           [self presentViewController:alert animated:YES completion:nil];
           
           
           NSLog(@"Success: %@", responseObject);
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           
           NSLog(@"Error: %@", error);
        }];
    }

    
    return;

    NSDictionary *newPhoto = @{@"photo":self.imagePicked.image};
    
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addMyPhoto"
                                                       object:nil
                                                     userInfo:newPhoto];
    
    
    ///將照片存到相機膠卷
//    NSData *imageData = UIImageJPEGRepresentation(self.imagePicked.image, 0.6);
//    
//    UIImage *compressedJPGImage = [UIImage imageWithData:imageData];
//    
//    UIImageWriteToSavedPhotosAlbum(compressedJPGImage, nil, nil, nil);
//    
//
//    
//    ////設定出現alertAcrtion
//    UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"照片已上傳"
//                                                                  message:@" "
//                                                           preferredStyle:UIAlertControllerStyleAlert];
//    
//   
//    UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK"
//                                                       style:UIAlertActionStyleDefault
//                                                     handler:^(UIAlertAction * _Nonnull action) {
//   
//                
//                                                         
//    }];
//    
// 
//    [alert addAction:okButton];
//    
//    [self presentViewController:alert animated:YES completion:nil];
    
    
//    MyCollectionViewController *controller =
//    [self.storyboard instantiateViewControllerWithIdentifier:@"MyCollectionViewController"];
//    
//    controller.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
//    
//
//    
//    [self presentViewController:controller animated:YES completion:nil];

    
}


///回到相機
- (IBAction)xxxxx:(id)sender
{

    [self dismissViewControllerAnimated:YES completion:nil];

}




///使用濾鏡
- (IBAction)filter001Button:(id)sender
{

   self.filter001.hidden = NO;

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
