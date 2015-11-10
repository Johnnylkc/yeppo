//
//  MyTableViewCell.h
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/16.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *detailButton;

@property (weak, nonatomic) IBOutlet UIImageView *headPhoto;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UIImageView *postPhoto;


@property (weak, nonatomic) IBOutlet UIButton *messageButton;

@property (weak, nonatomic) IBOutlet UIButton *keepButton;


@property (weak, nonatomic) IBOutlet UIButton *likeButton;


@property (weak, nonatomic) IBOutlet UILabel *likeNumber;









@end
