//
//  StadiumDetail.m
//  NFLStadiums
//
//  Created by Michael Sevy on 12/3/15.
//  Copyright © 2015 Michael Sevy. All rights reserved.
//

#import "StadiumDetail.h"
#import "VenueData.h"
#import "ViewController.h"
#import "Color.h"

@interface ViewController()


@end

@implementation StadiumDetail


- (void)viewDidLoad {
    [super viewDidLoad];


    self.navigationItem.title = self.sName;
    [self.navigationController.navigationBar setBarTintColor:[Color nflRed]];

    self.venueImage.image = [UIImage imageWithData:self.sImageData];
    self.name.text = self.self.sName;
    self.fullAddress.text = [NSString stringWithFormat:@"%@\n%@", self.sAddress, self.sCityStateZip];
    if (self.sSchdeule) {
        for (NSDictionary *dates in self.sSchdeule) {
           // NSLog(@"dates: %@", dates[@"end_date"]);


            NSString *startDate = dates[@"start_date"];
//            NSString *endDate = dates[@"start_date"];

            //Time Zone calc
            NSString *startZone = dates[@"start_date"];
            NSDateFormatter *formatterForZone = [NSDateFormatter new];
            [formatterForZone setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
            NSDate *dateObjForZone = [formatterForZone dateFromString:startZone];
            [formatterForZone setDateFormat:@"Z"];

            NSString *startDateString = [formatterForZone stringFromDate:dateObjForZone];
         //   NSLog(@"NFL Zone: %@", startDateString);
            //Current Time Zone
            NSDate *currentZone = [NSDate date];
            NSDateFormatter *format = [NSDateFormatter new];
            [format setDateFormat:@"Z"];
            NSString *currentZoneString = [format stringFromDate:currentZone];
         //   NSLog(@"current Zone: %@", currentZoneString);


            float timeZoneDiff = [currentZone timeIntervalSinceDate:dateObjForZone];
           // NSLog(@"zone %f", timeZoneDiff);
            NSTimeZone *timy = [NSTimeZone new];

            NSInteger secondFromGMTDate = ABS([timy secondsFromGMTForDate:dateObjForZone]);
            NSInteger secondsFromGMTNow = ABS([timy secondsFromGMTForDate:currentZone]);
            NSInteger timeDiff = secondsFromGMTNow - secondFromGMTDate;
            NSLog(@"time diff: %ld", (long)timeDiff);

            //date for Display
            NSDateFormatter *formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
            NSDate *dateObj = [formatter dateFromString:startDate];
            [formatter setDateFormat:@"EEEE MM/dd hh:mm a"];

            NSDate *newDate = [dateObj dateByAddingTimeInterval:timeDiff];
            NSString *newDateString = [formatter stringFromDate:newDate];
            NSLog(@"format: %@", newDateString);



//            for (NSString *dates in venue.schedules) {
//
//                NSString *date
//                dateAndTimes = [date stringByAppendingString:newStep];
//                dateAndTimes = [date stringByAppendingString:@"\n\n"];
//            }

        }
    }

    //
//    self.scheduleTextView.text = venue.schedules;

    
    
}


@end
