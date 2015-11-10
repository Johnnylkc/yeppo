//
//  MessageViewController.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/29.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import <AFNetworking/AFNetworking.h>

@interface MessageViewController () <UITableViewDataSource , UITableViewDelegate ,UITextFieldDelegate>
{
    
    NSMutableArray *talk;
    NSString *conversationId;
    
}

@property (weak, nonatomic) IBOutlet UIView *myView;

@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@property (weak, nonatomic) IBOutlet UIButton *sentButton;


@property (weak, nonatomic) IBOutlet UITableView *tableView;




@end

@implementation MessageViewController

-(void)createConversation
{
   
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefault objectForKey:@"loginToken"];
    NSString *userId = [userDefault objectForKey:@"userId"];
    NSString *url = @"http://www.yeppo.site/api/v1/conversations";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    NSDictionary *dic = @{@"sender_id":self.peopleId,
                          @"recipient_id":userId,
                          @"auth_token":token};
   
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        conversationId = responseObject[@"id"];
        
        [self getConversations];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"error %@", error);
        
    }];
}

-(void)getConversations {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"loginToken"];
    
    NSString *url = [NSString stringWithFormat:@"http://www.yeppo.site/api/v1/conversations/%@/messages?auth_token=%@", conversationId, token];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"getConversations %@", responseObject);
        
        talk = [responseObject[@"messages"] mutableCopy];
        [self.tableView reloadData];
        
       
        
        if (talk.count > 0) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:talk.count-1 inSection:0];
      
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"err %@", error);
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.myTextField.delegate = self;

    self.sentButton.layer.cornerRadius = 10;
    
    talk = [[NSMutableArray alloc]init];
    
    
    [self createConversation];

    


}


////回上頁
- (IBAction)doneButton:(id)sender
{

    [self dismissViewControllerAnimated:YES completion:nil];

}


-(void)createMessage {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [userDefault objectForKey:@"loginToken"];
    NSString *userId = [userDefault objectForKey:@"userId"];
    
    NSLog(@"createMessage");
    
    NSString *url = [NSString stringWithFormat:@"http://www.yeppo.site/api/v1/conversations/%@/messages", conversationId];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dic = @{@"body":self.myTextField.text,
                          @"user_id":userId,
                          @"auth_token":token} ;
    
    
    
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSLog(@"ok %@", responseObject);
        
        [talk addObject:@{@"body":self.myTextField.text,
                          @"user_id":userId}];
        
        [self.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:talk.count-1 inSection:0];
        //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
        self.myTextField.text = nil;
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        NSLog(@"error %@", error);
    }];
}

///傳送留言 發布廣播  收鍵盤
- (IBAction)sentButton:(id)sender
{

    [self createMessage];


}


///執行在viewdidliad接收廣播後 要執行的方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return talk.count;
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    MessageCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    
        NSDictionary *dic01 = talk[indexPath.row];
    
        cell.postMessageLabel.text = dic01[@"body"];
    
    NSString *userId =  [NSString stringWithFormat:@"%@", dic01[@"user_id"] ];
    
    if([userId isEqualToString:self.peopleId]) {
        cell.nameLabel.text = self.peopleName;

    }
    else {
        cell.nameLabel.text = [defaults objectForKey:@"name"];
    }
    /*
    NSString *timeStr = [NSString stringWithFormat:@"%@ +0000", dic01[@"created_at"]];
    
    NSLog(@" timeStr %@",  timeStr);

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    formatter.timeZone = [NSTimeZone localTimeZone];
    NSDate *date = [formatter dateFromString:timeStr];
    
    formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    timeStr = [formatter stringFromDate:date];
    
    NSLog(@" timeStr2 %@ %@", date, timeStr);
    
    cell.timeLabel.text = timeStr;
    */
    
    cell.timeLabel.text = @"";
    
    return cell;
}




- (IBAction)reload:(id)sender
{

    [self getConversations];

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
