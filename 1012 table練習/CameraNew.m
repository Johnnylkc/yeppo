//
//  CameraNew.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/11/1.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "CameraNew.h"
#import "CameraViewController.h"



#import <AFNetworking/AFNetworking.h>
#import <AVfoundation/AVfoundation.h>
#import <ImageIO/ImageIO.h>
@interface CameraNew ()
{
    AVCaptureSession *session;
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
    AVCaptureConnection *videoConnection;
}

@property (weak , nonatomic)IBOutlet UIView *myView;


@property UIImage *myImg;


@property (weak, nonatomic) IBOutlet UIButton *takeCameraButton;




@end


AVCaptureDeviceInput *frontFacingCameraDevice;
AVCaptureDeviceInput *backFacingCameraDevice;


@implementation CameraNew

- (void)viewDidLoad {
    [super viewDidLoad];

    self.takeCameraButton.layer.cornerRadius = 30;
    self.takeCameraButton.layer.borderWidth = 4;
    self.takeCameraButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.takeCameraButton.backgroundColor = nil;
    
    
    [self camera];

}



-(void)camera
{
    
    session = [AVCaptureSession new];
    
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        
        if ([device position] == AVCaptureDevicePositionBack) {
            
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            
            [session addInput:input];
        }
        
        if ([device position] == AVCaptureDevicePositionFront) {
            
            frontFacingCameraDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
            
        }
        
        
        
    }
    
    AVCaptureStillImageOutput *output = [AVCaptureStillImageOutput new];
    
    NSDictionary *outputSetting = @{AVVideoCodecKey : AVVideoCodecJPEG};
    
    [output setOutputSettings:outputSetting];
    
    [session addOutput:output];
    
    
    
    
    captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    
    captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    [self.myView.layer addSublayer:captureVideoPreviewLayer];
    
    
    
    
    captureVideoPreviewLayer.frame = self.myView.bounds;
    
    [session startRunning];
    
}


///拍照按鈕
- (IBAction)takeButton:(id)sender
{

    for(AVCaptureConnection *connection in ((AVCaptureStillImageOutput *)session.outputs[0]).connections){
        
        for(AVCaptureInputPort *port in [connection inputPorts]) {
            
            if([[port mediaType] isEqual:AVMediaTypeVideo]){
                
                videoConnection = connection ;
                
                break;
                
            }
            
        }
        
        if (connection) {
            
            break;
            
        }
        
    }
    
    [session.outputs[0] captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^
     (CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
         
         //        CFDictionaryRef exifAttachments = CMGetAttachment(imageDataSampleBuffer, kCGImagePropertyExifAuxDictionary, NULL);
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
         
         self.myImg = [[UIImage alloc] initWithData:imageData];
         
         UIImageWriteToSavedPhotosAlbum(self.myImg , nil, nil, nil);
         
         
     }];
    
    
    [self performSelector:@selector(passToNext:) withObject:nil  afterDelay:1];
    


}



///拍照後到下一頁 也把拍的照片傳到下一頁 已在拍照中宣布 這裡執行
-(void)passToNext:(id)sender
{
    CameraViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    
    controller.catchPhoto = self.myImg;
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
    
}



/////轉換鏡頭
int num = 1 ;
- (IBAction)toggleCamera:(id)sender
{
    
    num++;
    
    if (num % 2 == 0) {
      
        [self cameraPositionChanged];

    }else{
        
        [self camera];
    }
    
}




///鏡頭前後轉換 在toggleCamera裡執行
-(void)cameraPositionChanged
{
    static BOOL isPositionFront;
    
    [session beginConfiguration];
    
    [session removeInput:session.inputs[0]];
    
    if (isPositionFront) {
        if ( [session canAddInput:backFacingCameraDevice]) {
            
            [session addInput:backFacingCameraDevice];
        }
        
        
        
    }else{
        if ([session canAddInput:frontFacingCameraDevice]) {
            
            [session addInput:frontFacingCameraDevice];
        }
        

        
    }
    
    [session commitConfiguration];
    
    isPositionFront = !isPositionFront;
    
}



- (IBAction)getOutCamera:(id)sender
{

    [self dismissViewControllerAnimated:YES completion:nil];


}



///打開相機膠卷
- (IBAction)openPhotoRoll:(id)sender
{

//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//        
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        
//        picker.delegate = self;
//        
//        [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//        
//        picker.allowsEditing = true;
//        
//        [self presentViewController:picker animated:true completion:nil];
//    }
    
    UIPopoverPresentationController *popover;
    
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    
    
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    imagePicker.delegate = self;
    
    
    
    imagePicker.modalPresentationStyle = UIModalPresentationPopover;
    
    popover = imagePicker.popoverPresentationController;
    
    
    
    popover.sourceView = sender;
    
    //popover.sourceRect = sender.bounds;
    
    popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    
    



}



-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    CameraViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"CameraViewController"];
    
    controller.catchPhoto = image;
   
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [userDefault objectForKey:@"loginToken"];
    NSString *userId = [userDefault objectForKey:@"userId"];
    if (token != nil) {

    
    NSString *apiName = [NSString stringWithFormat:@"http://www.yeppo.site/api/v1/users/%@/shots",
                        userId];
        
        
  
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
       manager.requestSerializer = [AFJSONRequestSerializer serializer];
        NSDictionary *parameters = @{@"shot[description]": @"hello",
                                     @"shot[shot_type]":@"model",
                                     @"authenticity_token":token};
        
        [manager POST:apiName parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
            UIImage *image = self.myImg;
   
            NSData *imageData = UIImagePNGRepresentation(image);
    //[formData appendPartWithFormData:imageData name:@"photo"];
    [formData appendPartWithFileData:imageData name:@"shot[photo]" fileName:@"photo.png"
                            mimeType:@"image/png"];
} success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Success: %@", responseObject);
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@ %@", error, operation.responseString);
}];    }
    
    
    
    
    
    
    [self dismissViewControllerAnimated:true completion:nil];
    
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
