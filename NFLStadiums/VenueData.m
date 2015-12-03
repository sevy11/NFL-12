//
//  VenueData.m
//  NFLStadiums
//
//  Created by Michael Sevy on 12/2/15.
//  Copyright © 2015 Michael Sevy. All rights reserved.
//

#import "VenueData.h"

@implementation VenueData

-(NSData *)convertStringToData:(NSString *)urlString{

    NSString *imageString = urlString;
    NSURL *imageURL = [NSURL URLWithString:imageString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    self.imageData = imageData;
    
    return imageData;
}



@end
