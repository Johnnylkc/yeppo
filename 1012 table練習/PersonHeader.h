//
//  PersonHeader.h
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/17.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonHeader : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIImageView *headPhoto01;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel01;

@property (weak, nonatomic) IBOutlet UIButton *followButton;//為了設計外觀


@property (weak, nonatomic) IBOutlet UIButton *talkButton;//為了設定外觀


@end
