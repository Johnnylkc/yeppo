//
//  EditProfileTableViewController.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/11/6.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "EditProfileTableViewController.h"
#import "AFNetworking.h"


@interface EditProfileTableViewController ()

@end

@implementation EditProfileTableViewController


- (IBAction)doneButPressed:(id)sender {
    
    NSLog(@"done");
    
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"loginToken"];
    NSString *userId = [userDefault objectForKey:@"userId"];
    
    
    NSLog(@"token %@", token);
    
    if (token != nil) {
        
        
        NSString *apiName = [NSString stringWithFormat:@"http://www.yeppo.site/api/v1/users/%@",
                             userId];
        
                
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        NSDictionary *parameters = @{@"content": @"熱愛攝影 擅長人物拍攝",
                                     @"location":@"taipei",
                                     @"name":@"johnny",
                                     @"auth_token":token
                                     
                                     };
        
        NSLog(@"apiName:%@", apiName);
        
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PATCH" URLString:apiName parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            UIImage *image = [UIImage imageNamed:@"011"];
            
            
            CGSize size = CGSizeMake(300, image.size.height * 300 /
                                     image.size.width);
            UIGraphicsBeginImageContextWithOptions(size, NO, 0);
            [image drawInRect:CGRectMake(0, 0, size.width,
                                         size.height)];
            UIImage *resizeImage =
            UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            
            NSData *imageData = UIImagePNGRepresentation(resizeImage);
            
            
            [formData appendPartWithFileData:imageData name:@"head" fileName:@"photo.png"
                                    mimeType:@"image/png"];

            
            
        } error:nil];
        
        
        AFHTTPRequestOperation *op = [manager HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        op.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [[NSOperationQueue mainQueue] addOperation:op];
        
        return;
    
        [manager POST:apiName parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            //UIImage *image = self.imagePicked.image;
            
            
           // UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            
            UIImage *image = [UIImage imageNamed:@"011"];
            
            
            CGSize size = CGSizeMake(300, image.size.height * 300 /
                                     image.size.width);
            UIGraphicsBeginImageContextWithOptions(size, NO, 0);
            [image drawInRect:CGRectMake(0, 0, size.width,
                                         size.height)];
            UIImage *resizeImage =
            UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            
            NSData *imageData = UIImagePNGRepresentation(resizeImage);
            
            
            [formData appendPartWithFileData:imageData name:@"head" fileName:@"photo.png"
                                    mimeType:@"image/png"];
            

            
            
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
          
            NSLog(@"suc %@", responseObject);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            NSLog(@"err %@", error);


        }];
    }
    

    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
