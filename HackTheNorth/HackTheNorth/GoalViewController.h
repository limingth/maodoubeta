//
//  GoalViewController.h
//  HackTheNorth
//
//  Created by Lan Xu on 1/9/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import "HNSearchViewController.h"

@class HNDataManager;
@interface GoalViewController : HNSearchViewController<UITableViewDataSource, UITableViewDelegate>
{
    HNDataManager*  manager;
    NSArray*     _infoArray;
    
}


@end
