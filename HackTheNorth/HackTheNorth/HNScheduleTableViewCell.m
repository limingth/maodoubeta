//
//  NSScheduleTableViewCell.m
//  HackTheNorth
//
//  Created by Si Te Feng on 7/29/14.
//  Copyright (c) 2014 Si Te Feng. All rights reserved.
//

#import "HNScheduleTableViewCell.h"
#import "UserInterfaceConstants.h"
#import "JPFont.h"
#import "JPStyle.h"
#import "HNAvatarView.h"

#import "NSDate+HNConvenience.h"

@implementation HNScheduleTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // Initialization code
    self.separatorInset = UIEdgeInsetsZero;
    //UIEdgeInsetsMake(0, kiPhoneWidthPortrait, 0, 0);
    self.accessoryType = UITableViewCellAccessoryNone;
    
    avatarView = [[HNAvatarView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    avatarView.letter = self.type;
    [self addSubview:avatarView];
    
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 10, kiPhoneWidthPortrait - 70, 40)];
    nameLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:17];
    nameLabel.numberOfLines = 2;

    [self addSubview:nameLabel];
    
    UIImageView* timeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(8, 64.5, 12, 12)];
    [timeIcon setImage:[UIImage imageNamed:@"timeIcon"]];
    [self addSubview:timeIcon];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 60, 90, 20)];
    timeLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    timeLabel.textColor = [UIColor grayColor];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:timeLabel];
    
    ////////////////////////
    
    UIImageView* locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(100, 64.5, 12, 12)];
    [locationIcon setImage:[UIImage imageNamed:@"locationIcon"]];
    [self addSubview:locationIcon];
    
    locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(114, 60, kiPhoneWidthPortrait-120, 20)];
    locationLabel.font = [UIFont fontWithName:[JPFont defaultFont] size:15];
    locationLabel.textColor = [UIColor grayColor];
    locationLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:locationLabel];
    
    return self;
}


- (void)setName:(NSString *)name
{
    _name = name;
    nameLabel.text = name;
    
}


- (void)setLocation:(NSString *)location
{
    _location = location;
    if(!_location || [_location isEqualToString:@""])
        _location = @"TBD";
    
    locationLabel.text = _location;
}

- (void)setStartTime:(NSString *)startTime
{
    _startTime = startTime;
    
    NSDate* startDate = [NSDate dateWithISO8601CompatibleString:self.startTime];
    timeLabel.text = [startDate timeStringForTableCell];
    
}



- (void)setSpeaker:(NSString *)speaker
{
    _speaker = speaker;
    if(!speaker || [speaker isEqualToString:@""])
        _speaker = @"TBD";
}


- (void)setType:(NSString *)type
{
    _type = type;
    
    avatarView.letter = type;
}


- (id)copy
{
    HNScheduleTableViewCell* newCell = [[HNScheduleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    newCell.name = self.name;
    newCell.startTime = self.startTime;
    newCell.location = self.location;
    newCell.speaker = self.speaker;
    newCell.descriptor = self.descriptor;
    newCell.type = self.type;
    newCell.endTime = self.endTime;
    
    return newCell;
}


@end
