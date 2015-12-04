//
//  DetailiPadViewController.h
//  NFLStadiums
//
//  Created by Michael Sevy on 12/3/15.
//  Copyright © 2015 Michael Sevy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VenueData.h"


@interface DetailiPadViewController : UIViewController


@property NSString *sName;
@property NSString *sAddress;
@property NSString *sCityStateZip;
@property NSData *sImageData;
@property NSArray *sSchdeule;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UITextView *scheduleTextView;

@end
