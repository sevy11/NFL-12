//
//  StadiumDetail.h
//  NFLStadiums
//
//  Created by Michael Sevy on 12/3/15.
//  Copyright © 2015 Michael Sevy. All rights reserved.
//

#import "ViewController.h"
#import "VenueData.h"

@interface StadiumDetail : UIViewController

@property NSString *sName;
@property NSString *sAddress;
@property NSString *sCityStateZip;
@property NSData *sImageData;
@property NSArray *sSchdeule;

@property (weak, nonatomic) IBOutlet UIImageView *venueImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *fullAddress;
@property (weak, nonatomic) IBOutlet UITextView *scheduleTextView;


@end
