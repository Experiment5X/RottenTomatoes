//
//  RottenTomatoesMovieList.h
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/15/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RottenTomatoesMovie.h"
#import "RottenTomatoesApiRequest.h"

typedef NS_ENUM(NSInteger, MovieListType)
{
    MovieListTypeBoxOfficeMovies,
    MovieListTypeInTheatersMovies,
    MovieListTypeOpeningMovies,
    MovieListTypeUpcomingMovies,
    MovieListTypeTopRentalDVDs,
    MovieListTypeCurrentReleaseDVDs,
    MovieListTypeNewReleaseDVDs,
    MovieListTypeUpcomingDVDs
};

@interface RottenTomatoesMovieList : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *movies;

- (instancetype)initWithListType:(MovieListType)listType length:(int)listLength;
- (instancetype)initWithListResponse:(NSDictionary *)movieListResponse;
- (instancetype)initWithSearchQuery:(NSString *)movieSearchQuery length:(int)responseLength;

- (RottenTomatoesMovie *)movieAtIndex:(int)index;
- (int)movieCount;

@end
