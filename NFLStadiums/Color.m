//
//  Color.m
//  NFLStadiums
//
//  Created by Michael Sevy on 12/3/15.
//  Copyright © 2015 Michael Sevy. All rights reserved.
//

#import "Color.h"

@implementation Color


+ (UIColor *)nflBlue    {
    return     [UIColor colorWithRed:1.0/255.0 green:51.0/255.0 blue:105.0/255.0 alpha:1.0];
}


+ (UIColor *)nflRed    {
    return [UIColor colorWithRed:213.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:1.0];
}

+ (UIColor *)fontWhite
{
    return [UIColor colorWithRed:245.0/255.0 green:248.0/255.0 blue:250.0/255.0 alpha:1];
}

+ (UIColor *)fontBlack
{
    return [UIColor colorWithRed:41.0/255.0 green:47.0/255.0 blue:51.0/255.0 alpha:1];
}

+ (UIColor *)fontGray
{
    return [UIColor colorWithRed:102.0/255.0 green:117.0/255.0 blue:127.0/255.0 alpha:1];
}

+ (UIColor *)fontYellow
{
    return [UIColor colorWithRed:253.0/255.0 green:208.0/255.0 blue:0.0 alpha:1];
}

+ (UIColor *)fontRed
{
    return [UIColor colorWithRed:203.0/255.0 green:51.0/255.0 blue:28.0/255.0 alpha:1];
}

@end
