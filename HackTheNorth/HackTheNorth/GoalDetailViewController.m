//
//  GoalDetailViewController.m
//  HackTheNorth
//
//  Created by Lan Xu on 1/9/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import "GoalDetailViewController.h"
#import "HNScrollListCell.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "UserInterfaceConstants.h"
#import "UIColor+RGBValues.h"
#import "HNAvatarView.h"
#import "NSDate+HNConvenience.h"
#import "SVStatusHUD.h"
#import "HNBorderButton.h"
#import "SVStatusHUD.h"
#import "NSString+HNConvenience.h"
#import "HNAutoresizingLabel.h"

@interface GoalDetailViewController ()

@end

@implementation GoalDetailViewController

- (id)initWithCell: (HNScrollListCell*)cell
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.view.backgroundColor = cell.backgroundColor;
        
        self.cell = cell;
        
        self.title = @"目标详情";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 10, kiPhoneWidthPortrait-10, 40)];
    nameLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:35];
    nameLabel.textColor = [[JPStyle interfaceTintColor] darkerColor];
    [self.view addSubview:nameLabel];
    
    ///////////////////////
    UILabel* twitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 60, kiPhoneWidthPortrait-20, 25)];
    twitterLabel.text = @"Twitter";
    twitterLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:twitterLabel];
    
    twitterVal = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 85, kiPhoneWidthPortrait-130, 20)];
    twitterVal.font = [JPFont fontWithName:[JPFont defaultThinFont] size:16];
    twitterVal.textColor = [UIColor darkGrayColor];
    [self.view addSubview:twitterVal];
    
    UILabel* contactLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 115, kiPhoneWidthPortrait-130, 25)];
    contactLabel.text = @"Contact";
    contactLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    [self.view addSubview:contactLabel];
    
    phoneButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(10, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 90, 44)];
    [phoneButton addTarget:self action:@selector(startPhoneCall) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setTitle:@"Phone" forState:UIControlStateNormal];
    [self.view addSubview:phoneButton];
    
    sendEmailButton = [[HNBorderButton alloc] initWithFrame:CGRectMake(10 + 110, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 145, 90, 44)];
    [sendEmailButton setTitle:@"Send Email" forState:UIControlStateNormal];
    [sendEmailButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendEmailButton];
    
    /////////////////////////////////////////////////////
    
    UIView* skillBackground = [[UIView alloc] initWithFrame:CGRectMake(0, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 210, kiPhoneWidthPortrait, kiPhoneHeightPortrait - 275)];
    skillBackground.backgroundColor = [[JPStyle interfaceTintColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:skillBackground];
    
    UILabel* rolesLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 220, kiPhoneWidthPortrait-20, 30)];
    rolesLabel.text = @"Roles";
    rolesLabel.font = [JPFont fontWithName:[JPFont defaultThinFont] size:20];
    rolesLabel.textColor = [UIColor blackColor];
    [self.view addSubview:rolesLabel];
    
    
    rolesVal = [[UITextView alloc] initWithFrame:CGRectMake(20, kiPhoneStatusBarHeight+kiPhoneNavigationBarHeight+ 250, kiPhoneWidthPortrait-30, 200)];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = rolesVal.frame;
        frame.size.height -= 88;
        rolesVal.frame = frame;
    }
    rolesVal.showsVerticalScrollIndicator = NO;
    rolesVal.backgroundColor = [UIColor clearColor];
    rolesVal.editable = NO;
    rolesVal.selectable = NO;
    rolesVal.textColor = [[JPStyle interfaceTintColor] darkerColor];
    rolesVal.font = [JPFont fontWithName:[JPFont defaultBoldFont] size:26];
    rolesVal.textContainer.lineFragmentPadding = 0;
    rolesVal.textContainerInset = UIEdgeInsetsZero;
    [self.view addSubview:rolesVal];
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
