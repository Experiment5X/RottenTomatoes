//
//  RottenTomatoesMovie.h
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/15/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RottenTomatoesMovie : NSObject

@property (strong) NSString *title;
@property (strong) NSString *movieId;
@property (strong) NSString *rating;
@property (strong) NSString *synopsis;
@property (strong) NSString *theaterDate;
@property (strong) NSString *dvdDate;
@property (strong, nonatomic) UIImage *icon;

@property NSUInteger year;
@property NSInteger criticRating;
@property NSInteger fanRating;

-(instancetype)init:(NSDictionary *)movieData;

@end
