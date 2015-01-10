//
//  GoalViewController.m
//  HackTheNorth
//
//  Created by Lan Xu on 1/9/15.
//  Copyright (c) 2015 Si Te Feng. All rights reserved.
//

#import "GoalViewController.h"
#import "UserInterfaceConstants.h"
#import "HNScrollListCell.h"
#import "HNDataManager.h"
#import "SVStatusHUD.h"
#import "GoalDetailViewController.h"
#import "NSString+HNConvenience.h"
#import "HNAvatarView.h"
#import "JPStyle.h"
#import "DejalActivityView.h"

static NSString *const GOAL_PATH = @"goals";
static NSString* const kHNScrollListCellIdentifier = @"kHNScrollListCellIdentifier";


@implementation GoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    manager = [[HNDataManager alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44) style:UITableViewStylePlain];
    if(![JPStyle iPhone4Inch])
    {
        CGRect frame = self.tableView.frame;
        frame.size.height -= 88;
        self.tableView.frame = frame;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[HNScrollListCell class] forCellReuseIdentifier:kHNScrollListCellIdentifier];
    [self.view addSubview: self.tableView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadData:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:GOAL_PATH object:nil];
    [HNDataManager loadDataForPath:GOAL_PATH];
}


- (void)reloadData:(NSNotification *)notification
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    [mgr GET:@"http://maodou.io/goals.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        if ([responseObject isKindOfClass:[NSArray class]]){
//            NSLog(@"JSON: %@", responseObject);
//        }
        
        NSArray* headersArray = (NSArray *)responseObject;
//        @[
//          @{ @"name":@"iOS学习小组", @"email":@"limingth@maodou.io", @"phone":@"+86 15801420190", @"twitter": @"@硅谷", @"role":@[@"组长：李明"]},
//          @{ @"name":@"Html5开发学习小组", @"email":@"free2411@gmail.com", @"phone":@"+1 (647) 627-8630", @"twitter": @"@北京", @"role":@[@"组长：郭克"]},
//          @{ @"name":@"Ruby on Rails学习小组", @"email":@"free2411@gmail.com", @"phone":@"+1 (647) 627-8630", @"twitter": @"@北京", @"role":@[@"组长：刘吉洋"]},
//          @{ @"name":@"网络编程学习小组", @"email":@"free2411@gmail.com", @"phone":@"+1 (647) 627-8630", @"twitter": @"@山东临沂", @"role":@[@"组长：张乃乾"]},
//          @{ @"name":@"D3.js学习小组", @"email":@"free2411@gmail.com", @"phone":@"+1 (647) 627-8630", @"twitter": @"@北京", @"role":@[@"组长：刘吉洋"]}
//          ];
        
        NSDictionary* infoDict = [notification userInfo][HNDataManagerKeyData];
        //    if(!infoDict)
        //        return;
        
        NSMutableArray* array = [NSMutableArray array];
        NSArray* keyArray = [infoDict allKeys];
        for(NSString* key in keyArray)
        {
            NSMutableDictionary* dictionary = [[infoDict objectForKey:key] mutableCopy];
            [dictionary setObject:key forKey:@"id"];
            [array addObject:dictionary];
        }
        
        self.origCellDictArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSDictionary* obj1, NSDictionary* obj2) {
            
            NSString* name1 = @"zzzzzz";
            NSString* name2 = @"zzzzzz";
            
            if([obj1 objectForKey:@"id"])
                name1 = [obj1 objectForKey:@"id"];
            
            if([obj2 objectForKey:@"id"])
                name2 = [obj2 objectForKey:@"id"];
            return [name1 compare:name2];
        }];
        
        // We want the headers to be located at the top of the cellDictArray.
        NSArray* appendedArray = [headersArray arrayByAddingObjectsFromArray:self.origCellDictArray];
        
        self.origCellDictArray = [appendedArray copy];
        self.cellDictArray = [appendedArray copy];
        
        [self reloadDataForFiltering];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UI Table View Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellDictArray count];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HNScrollListCell* cell = (HNScrollListCell*)[self.tableView dequeueReusableCellWithIdentifier:kHNScrollListCellIdentifier];
    
    NSDictionary* infoDict = [self.cellDictArray objectAtIndex:indexPath.row];
    
    if(![infoDict isEqual: [NSNull null]])
    {
        cell.title = [infoDict objectForKey:@"title"];
        NSString* theSubtitle = [infoDict objectForKey:@"description"];
        cell.subtitle = theSubtitle;
        cell.detailList = @[[infoDict objectForKey:@"start"]];
        cell.imageURL = [NSURL URLWithString:[infoDict objectForKey:@"avatar"]];
        cell.email = [infoDict objectForKey:@"email"];
        
        id phoneId = [infoDict objectForKey:@"phone"];
        if([phoneId isKindOfClass:[NSNumber class]])
            cell.phone = (NSNumber*)phoneId;
        else if([phoneId isKindOfClass:[NSString class]])
            cell.phone = [(NSString*)phoneId convertFromPhoneStringToNumber];
        
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [HNScrollListCell getCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HNScrollListCell* cell = (HNScrollListCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    GoalDetailViewController* detailsController = [[GoalDetailViewController alloc] initWithCell:cell];
    [self.navigationController pushViewController:detailsController animated:YES];
    
}


#pragma mark - Search Bar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidBeginEditing:searchBar];
    
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(0, self.tableView.frame.origin.y, kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44+kiPhoneTabBarHeight-kiPhoneKeyboardHeightPortrait);
        if(![JPStyle iPhone4Inch])
        {
            CGRect frame = self.tableView.frame;
            frame.size.height -= 88;
            self.tableView.frame = frame;
        }
    } completion:nil];
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [super searchBarTextDidEndEditing:searchBar];
    
    [UIView animateWithDuration:kKeyboardRetractAnimationSpeed delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(_searchBar.frame), kiPhoneWidthPortrait, kiPhoneContentHeightPortrait-44);
        if(![JPStyle iPhone4Inch])
        {
            CGRect frame = self.tableView.frame;
            frame.size.height -= 88;
            self.tableView.frame = frame;
        }
    } completion:nil];
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
