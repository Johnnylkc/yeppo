//
//  MessageCell.h
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/29.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *postMessageLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
