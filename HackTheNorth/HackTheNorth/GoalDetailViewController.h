//
//  GoalDetailViewController.h
//  HackTheNorth
//
//  Created by Lan Xu on 1/9/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNScrollListCell, HNAvatarView, HNBorderButton, HNAutoresizingLabel;
@interface GoalDetailViewController : UIViewController {
    UILabel* nameLabel;
    HNAvatarView* imageView;
    
    UILabel* twitterVal;
    
    HNBorderButton* phoneButton;
    HNBorderButton* sendEmailButton;
    
    
    UITextView* rolesVal;
}

@property (nonatomic, strong) HNScrollListCell* cell;

- (id)initWithCell: (HNScrollListCell*)cell;

@end
