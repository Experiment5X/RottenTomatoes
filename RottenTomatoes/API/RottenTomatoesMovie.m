//
//  RottenTomatoesMovie.m
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/15/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import "RottenTomatoesMovie.h"

@interface RottenTomatoesMovie ()

@property (strong) NSString *iconUrl;

@end

@implementation RottenTomatoesMovie

-(instancetype)init:(NSDictionary *)movieData
{
    self = [super init];
    if (self)
    {
        self.title =        [movieData objectForKey:@"title"];
        self.movieId =      [movieData objectForKey:@"id"];
        self.rating =       [movieData objectForKey:@"mpaa_rating"];
        self.synopsis =     [movieData objectForKey:@"synopsis"];
        self.year =			[self safeToInteger:[movieData objectForKey:@"year"]];
        
        self.criticRating = -1;
        self.fanRating = -1;
        
        // unfortunately some of these don't have ratings, so we need to check
        if ([movieData objectForKey:@"ratings"])
        {
            if ([[movieData objectForKey:@"ratings"] objectForKey:@"critics_score"])
                self.criticRating = [self safeToInteger: [[movieData objectForKey:@"ratings"] objectForKey:@"critics_score"]];
            if ([[movieData objectForKey:@"ratings"] objectForKey:@"audience_score"])
                self.fanRating = [self safeToInteger: [[movieData objectForKey:@"ratings"] objectForKey:@"audience_score"]];
        }
        
        self.theaterDate = @"Unknown";
        self.dvdDate = @"Unknown";
        
        // some also don't have dates, so we gotta check that too
        if ([movieData objectForKey:@"release_dates"])
        {
            if ([[movieData objectForKey:@"release_dates"] objectForKey:@"theater"])
                self.theaterDate = [self transformDate:[[movieData objectForKey:@"release_dates"] objectForKey:@"theater"]];
            if ([[movieData objectForKey:@"release_dates"] objectForKey:@"dvd"])
                self.theaterDate = [self transformDate:[[movieData objectForKey:@"release_dates"] objectForKey:@"dvd"]];
        }
        
        if ([movieData objectForKey:@"posters"])
        	self.iconUrl = 		[[movieData objectForKey:@"posters"] objectForKey:@"profile"];
    }
    
    return self;
}

-(UIImage *)icon
{
    if (!_icon)
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.iconUrl]];
        _icon = [[UIImage alloc] initWithData:imageData];
    }
    return _icon;
}

-(NSString *)transformDate:(NSString *)date
{
    if (!date)
        return @"Unknown date";
    
    NSArray *months = @[ @"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August",
                          @"Sepetember", @"October", @"November", @"December" ];
    
    NSArray *dateComponents = [date componentsSeparatedByString:@"-"];
    NSString *month = months[[dateComponents[1] intValue] - 1];
    NSString *year = dateComponents[0];
    int day = [dateComponents[2] intValue];
    
    return [NSString stringWithFormat:@"%@ %d, %@", month, day, year];
}

- (NSInteger)safeToInteger:(id)jsonValue
{
    if (jsonValue && ![jsonValue isKindOfClass:[NSString class]])
        return [jsonValue integerValue];
    return 0;
}

@end
