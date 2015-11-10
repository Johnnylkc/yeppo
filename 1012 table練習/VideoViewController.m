//
//  VideoViewController.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/14.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "VideoViewController.h"
#import "RootTabBar.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "AFNetworking.h"


@import MediaPlayer; //記得import
@import AVKit;
@import AVFoundation;


@interface VideoViewController ()

@property (strong, nonatomic) AVPlayerViewController *moviePlayer;//video


@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //fb按鈕 外觀位置
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.frame = CGRectMake(-5, self.view.bounds.size.height - 50, self.view.bounds.size.width+10  , 50);
    [self.view addSubview:loginButton];
    
    
    ///影片設定
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"001" withExtension:@"mov"];
    self.moviePlayer = [[AVPlayerViewController alloc] init];
    self.moviePlayer.player = [AVPlayer playerWithURL:videoURL];
    self.moviePlayer.view.frame = self.view.frame;
    self.moviePlayer.showsPlaybackControls = NO ;
    [self.view insertSubview:self.moviePlayer.view atIndex:0];
    
    [self.moviePlayer.player play];
    
    // Loop video.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loopVideo) name:AVPlayerItemDidPlayToEndTimeNotification object:self.moviePlayer.player.currentItem];
    
    ///fb
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(fbTokenChangeNoti:)
//                                                 name:FBSDKAccessTokenDidChangeNotification object:nil];
//    




}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
 
    ///fb
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fbTokenChangeNoti:)
                                                 name:FBSDKAccessTokenDidChangeNotification object:nil];

    
}



- (void)loopVideo {
    [self.moviePlayer.player seekToTime:kCMTimeZero];
    [self.moviePlayer.player play];
}



-(void)fbTokenChangeNoti:(NSNotification*)noti
{
    NSLog(@"fffff");
   
    if ([FBSDKAccessToken currentAccessToken]) {
        
        FBSDKGraphRequest *request =[[FBSDKGraphRequest alloc]initWithGraphPath:@"me"
                                         parameters:@{@"fields" : @"email, name, first_name, last_name"}
                                         HTTPMethod:@"GET"];

        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,NSDictionary *result,NSError *error) {
            
            
            // Handle the result
        FBSDKAccessToken * fbAccessToken = [FBSDKAccessToken currentAccessToken];
           
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString *token = fbAccessToken.tokenString;
            
        NSString *uid = fbAccessToken.userID;
            
        [manager POST:@"http://www.yeppo.site/api/v1/login" parameters:@{@"access_token":token,@"uid":uid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responese:%@",responseObject);
            
            NSString *message = responseObject[@"message"];
            
            if ([message isEqualToString:@"Ok"]) {
                
            
                
                NSString *loinToken = responseObject[@"auth_token"];
                NSString *userId = [NSString stringWithFormat:@"%@", responseObject[@"user_id"]];
                NSString *userName = responseObject[@"user_name"];

                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                
                NSLog(@"userName %@", userName);
                
                [userDefault setObject:loinToken forKey:@"loginToken"];
                [userDefault setObject:userId forKey:@"userId"];
                [userDefault setObject:userName forKey:@"name"];

                [userDefault synchronize];
                
                
                RootTabBar *controller =
                [self.storyboard instantiateViewControllerWithIdentifier:@"RootTabBar"];
                
                [self presentViewController:controller animated:YES completion:nil];
                
                /*

                NSString *url = [NSString stringWithFormat:@"http://www.yeppo.site/api/v1/users/%@?auth_token=%@", userId, loinToken];
                [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                    
                    
                    NSDictionary *dic = responseObject[@"data"];
                    [userDefault setObject:dic[@"name"] forKey:@""] ;
                    
                    RootTabBar *controller =
                    [self.storyboard instantiateViewControllerWithIdentifier:@"RootTabBar"];
                    
                    [self presentViewController:controller animated:YES completion:nil];
                    
                } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                    
                }];
                
                */
              

            }
            
            
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                
            if (fbAccessToken) {
                    

            };

                NSLog(@"Error: %@", error);
            
            }];
            
        }];
        
       
        
        
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//       
//        UITabBarController *rootViewController =
//        [storyboard instantiateViewControllerWithIdentifier:@"RootTabBar"];
//        
//        [[UIApplication sharedApplication].keyWindow setRootViewController:rootViewController];
        
        
      
    }

 
}







@end
