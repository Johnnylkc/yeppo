//
//  MyTableViewCell.m
//  1012 table練習
//
//  Created by 劉坤昶 on 2015/10/16.
//  Copyright © 2015年 劉坤昶 Johnny. All rights reserved.
//

#import "MyTableViewCell.h"
#import "SecretView.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code

    self.likeButton.layer.cornerRadius = 5 ;
    self.keepButton.layer.cornerRadius = 5 ;
    self.messageButton.layer.cornerRadius = 5 ;

}




//按讚按鈕變化
int buttonCount = 1;
- (IBAction)iLikeButton:(id)sender
{
    buttonCount++;
    
    if (buttonCount % 2 == 0) {
    
        NSString *str = self.likeNumber.text;
        int num = [str intValue];
        num ++;
        self.likeNumber.text = [NSString stringWithFormat:@"%d",num];
        
        
        self.likeButton.backgroundColor = [UIColor yellowColor];
    
    }else{
    
        NSString *str = self.likeNumber.text;
        int num = [str intValue];
        num --;
        self.likeNumber.text = [NSString stringWithFormat:@"%d",num];


        self.likeButton.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
   
    }
    
}


//收藏按鈕變化
int buttonCount01 = 1;
- (IBAction)iKeepButton:(id)sender
{
    buttonCount01 ++;
    
    if (buttonCount01 % 2 == 0) {
        self.keepButton.backgroundColor = [UIColor yellowColor];
    }else{
        self.keepButton.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
