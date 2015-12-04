//
//  DetailiPadViewController.m
//  NFLStadiums
//
//  Created by Michael Sevy on 12/3/15.
//  Copyright © 2015 Michael Sevy. All rights reserved.
//

#import "DetailiPadViewController.h"
#import "iPadMasterViewControllerTableViewController.h"
#import "VenueData.h"
#import "Color.h"

@interface DetailiPadViewController()

@end

@implementation DetailiPadViewController

-(void)viewDidLoad  {
    [super viewDidLoad];


    self.navigationItem.title = self.sName;
    [self.navigationController.navigationBar setBarTintColor:[Color nflBlue]];

    self.imageView.image = [UIImage imageWithData:self.sImageData];
    self.nameLabel.text = self.self.sName;
    self.addressLabel.text = [NSString stringWithFormat:@"%@\n%@", self.sAddress, self.sCityStateZip];
    if (self.sSchdeule) {
        for (NSDictionary *dates in self.sSchdeule) {

            NSString *startDate = dates[@"start_date"];
            NSString *endingDate = dates[@"end_date"];

            self.scheduleTextView.text = [self schedule:startDate andEndDate:endingDate];
        }
    }

}


#pragma mark -- helper

-(NSString *)schedule:(NSString *)sDate andEndDate:(NSString *)eDate{
    //Time Zone calc
    NSString *startZone = sDate;
    NSDateFormatter *formatterForZone = [NSDateFormatter new];
    [formatterForZone setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *dateObjForZone = [formatterForZone dateFromString:startZone];
    [formatterForZone setDateFormat:@"Z"];
    //cuurent time zone
    NSDate *currentZone = [NSDate date];
    //calc
    NSTimeZone *timy = [NSTimeZone new];
    NSInteger secondFromGMTDate = ABS([timy secondsFromGMTForDate:dateObjForZone]);
    NSInteger secondsFromGMTNow = ABS([timy secondsFromGMTForDate:currentZone]);
    NSInteger timeDiff = secondsFromGMTNow - secondFromGMTDate;

    //date for Display
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDateFormatter *endFormatter = [NSDateFormatter new];
    [endFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];

    NSDate *endDate = [endFormatter dateFromString:eDate];
    NSDate *dateObj = [formatter dateFromString:sDate];
    [formatter setDateFormat:@"EEEE MM/dd hh:mm a"];
    [endFormatter setDateFormat:@"hh:mm a"];

    NSDate *newEndDate = [endDate dateByAddingTimeInterval:timeDiff];
    NSString *endTimeString = [endFormatter stringFromDate:newEndDate];
    NSDate *newStartDate = [dateObj dateByAddingTimeInterval:timeDiff];
    NSString *newDateString = [formatter stringFromDate:newStartDate];
    NSString *finalScheduleFormat = [NSString stringWithFormat:@"%@ to %@", newDateString, endTimeString];

    return finalScheduleFormat;
}

@end



