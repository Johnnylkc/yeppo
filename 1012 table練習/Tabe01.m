//
//  Tabe01.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/12.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "Tabe01.h"
#import "MyTableViewCell.h"
#import "SecretView.h"
#import "MessageViewController.h"
#import "PersonCollectionViewController.h"
#import "NotiViewController.h"


#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@interface Tabe01 ()
{

    NSArray *Models ;
    NSArray *ModelsHead;

    
}

@property (strong, nonatomic) IBOutlet UITableView *thisTable;
@property (nonatomic, strong) NSMutableArray *dataBag;
@property (nonatomic, strong) NSMutableDictionary *photoDic;

@end

@implementation Tabe01

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yeppo"]];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pdateFeedNoti:) name:@"UpdateFeedNoti" object:nil];
    
    [self loadData];
}

-(void)pdateFeedNoti:(NSNotification*)noti {
    
    [self loadData];
}





-(void)loadData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"loginToken"];
    NSString *urlStr = [NSString stringWithFormat:@"http://www.yeppo.site/api/v1/users?auth_token=%@", token];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull
    responseObject) {
        
        
        self.photoDic = [[NSMutableDictionary alloc] init];
        
        NSDictionary *data = (NSDictionary*)responseObject ;
        
        self.dataBag = [[NSMutableArray alloc] init];
        
        NSArray *array = data[@"users"];
        
        for (NSDictionary *dic in array) {
            
            
            
            NSString *userId = [NSString stringWithFormat:@"%@", dic[@"id"]];
            
            for(NSDictionary *shot in dic[@"shots"]) {
            
                NSMutableDictionary *feedDic = [[NSMutableDictionary alloc] init];
                
                feedDic[@"headPhoto"] = dic[@"head"];
                feedDic[@"postPhoto"] = shot[@"photo"];
                feedDic[@"userName"] = dic[@"name"];
                feedDic[@"created_at"] = shot[@"created_at"];
                feedDic[@"userId"] = userId;
                
                [self.dataBag addObject:feedDic];

            }
            
            
            [self.photoDic setObject:dic[@"shots"] forKey:userId];
            
        }
        
        [self.dataBag sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
           
            NSString *timeStr1 = obj1[@"created_at"];
            NSString *timeStr2 = obj2[@"created_at"];
        

            return [timeStr2 compare:timeStr1];
        }];
        
        
        for(NSDictionary *dic in self.dataBag) {
            NSLog(@"dic %@", dic);
        }
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"error %@", error);
    }];
    
    [operation start];

    
}




//篩選button
- (IBAction)selectButton:(id)sender
{
    
    //標題設定
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"篩選功能"
                                                                        message:@"選擇瀏覽對象"
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
    
    //第一欄要寫啥
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"全部瀏覽"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
                                                     
                                                        
    }];
    
    [controller addAction:action1];
    
   
    
    //第二欄要寫啥
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"攝影師作品"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * _Nonnull action) {
        
    
                                                        
                                                        
                                                        
    Models = [NSArray arrayWithObjects:
             [UIImage imageNamed:@"m1"],
             [UIImage imageNamed:@"m2"],
             [UIImage imageNamed:@"m3"],
             [UIImage imageNamed:@"m4"],
             [UIImage imageNamed:@"m5"],
             nil];
                                               
                                                    
                                                    
    Models = [NSArray arrayWithObjects:
             [UIImage imageNamed:@"m6"],
             [UIImage imageNamed:@"m7"],
             [UIImage imageNamed:@"m8"],
             [UIImage imageNamed:@"m9"],
             [UIImage imageNamed:@"m10"],
                                  nil];

                                                    
            [self.tableView reloadData];
                                                    
                                                    
     }];
    
    
    [controller addAction:action2];
    
    
    
    //第三欄要寫啥
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"模特兒作品" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                                
        
        Models = [NSArray arrayWithObjects:
                  [UIImage imageNamed:@"w1"],
                  [UIImage imageNamed:@"w2"],
                  [UIImage imageNamed:@"w3"],
                  [UIImage imageNamed:@"w4"],
                  [UIImage imageNamed:@"w5"],
                  [UIImage imageNamed:@"w6"],
                  [UIImage imageNamed:@"w7"],
                  [UIImage imageNamed:@"w8"],
                  [UIImage imageNamed:@"w9"],
                  [UIImage imageNamed:@"w10"],
                  nil];
        
        
        ModelsHead = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"w10"],
                      [UIImage imageNamed:@"w9"],
                      [UIImage imageNamed:@"w8"],
                      [UIImage imageNamed:@"w7"],
                      [UIImage imageNamed:@"w6"],
                      [UIImage imageNamed:@"w5"],
                      [UIImage imageNamed:@"w4"],
                      [UIImage imageNamed:@"w3"],
                      [UIImage imageNamed:@"w2"],
                      [UIImage imageNamed:@"w1"],
                      nil];

          [self.tableView reloadData];
        
        
    
    }];
  
    
    [controller addAction:action3];
    
    
    
    //最下面我要有一個取消的選項
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                                                            
        NSLog(@"取消");
                                                     
        
    }];
    
    
    [controller addAction:cancelButton];

    
    //執行以上動作
    [self presentViewController:controller animated:YES completion:nil];

    
}


////點了照片到下一頁secretView
- (IBAction)tapToSecret:(UIButton*)sender
{
    
    NSLog(@"tap");
    

    SecretView *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"SecretView"];
    
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve ;
    
    MyTableViewCell *cell = sender.superview;
    
    while ([cell isKindOfClass:[MyTableViewCell class]] == NO) {
        
        cell = cell.superview;
        
    }

    controller.catchImage = cell.postPhoto.image ;
    
    [self presentViewController:controller animated:YES completion:nil];
    
}




- (IBAction)reloadData:(id)sender
{

    NotiViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NotiViewController"];
    
    controller.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:controller animated:YES completion:nil];
    
    
    
    
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

    return self.dataBag.count;
}



-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell" forIndexPath:indexPath];
    
    NSDictionary *dataBag01 = self.dataBag[indexPath.row];
    
    
    cell.detailButton.tag = indexPath.row;
    
//大頭照
    
    
    NSLog(@"head %d %@", indexPath.row, [dataBag01 objectForKey:@"headPhoto"]);
    
    NSURL *url = [NSURL URLWithString:[dataBag01 objectForKey:@"headPhoto"]];
    NSURLRequest *request =  [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [cell.headPhoto setImageWithURLRequest:request
                         placeholderImage:placeholderImage
                                  success:nil
                                  failure:nil];
    
    
//po的照片
    url = [NSURL URLWithString:[dataBag01 objectForKey:@"postPhoto"]];
    request =  [NSURLRequest requestWithURL:url];
    placeholderImage = [UIImage imageNamed:@"placeholder"];
    
    [cell.postPhoto setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:nil
                                   failure:nil];
    
    
    cell.userName.text = dataBag01[@"userName"];

    cell.headPhoto.contentMode = UIViewContentModeScaleAspectFill;
    cell.headPhoto.layer.cornerRadius = cell.headPhoto.frame.size.height/2;
    cell.headPhoto.clipsToBounds = YES;
    
    
    return cell;
}




- (IBAction)homePageMessageButton:(UIButton*)sender
{

    
    MessageViewController *controller =
    [self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];

    CGPoint point = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    NSDictionary *dic = self.dataBag[indexPath.row];
    
    controller.peopleId = dic[@"userId"];
    controller.peopleName = dic[@"userName"];
    
    controller.modalPresentationStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:controller animated:YES completion:nil];


}






/*s
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:; forIndexPath:indexPath];
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    UIButton *button = sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    
    NSLog(@"prepareForSegue %d", indexPath.row);
    
    NSDictionary *dic = self.dataBag[indexPath.row];
    
    
    
    PersonCollectionViewController *controller = [segue destinationViewController];
    controller.userDic = dic;
    
    controller.photoArray = self.photoDic[dic[@"userId"]];
    
}


@end
