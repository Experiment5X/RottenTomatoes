//
//  RottenTomatoesMovieList.m
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/15/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import "RottenTomatoesMovieList.h"

@interface RottenTomatoesMovieList ()

@property (strong, nonatomic) NSMutableArray *movies;

@end


@implementation RottenTomatoesMovieList

- (instancetype)initWithListType:(MovieListType)listType length:(int)listLength
{
    self = [super init];
    if (self)
    {
        RottenTomatoesApiRequest *request = [[RottenTomatoesApiRequest alloc] init];
        
        NSDictionary *response;
        NSDictionary *arguments = @{ @"limit" : [NSString stringWithFormat:@"%d", listLength] };
        
        // make a different request for each different list
        switch (listType)
        {
            case MovieListTypeBoxOfficeMovies:
                response = [request makeRequest:@"lists/movies/box_office" withArguments:arguments];
                break;
            case MovieListTypeInTheatersMovies:
                response = [request makeRequest:@"lists/movies/in_theaters" withArguments:arguments];
                break;
            case MovieListTypeOpeningMovies:
                response = [request makeRequest:@"lists/movies/opening" withArguments:arguments];
                break;
            case MovieListTypeUpcomingMovies:
                response = [request makeRequest:@"lists/movies/upcoming" withArguments:arguments];
                break;
            case MovieListTypeTopRentalDVDs:
                response = [request makeRequest:@"lists/dvds/top_rentals" withArguments:arguments];
                break;
            case MovieListTypeCurrentReleaseDVDs:
                response = [request makeRequest:@"lists/dvds/current_releases" withArguments:arguments];
                break;
            case MovieListTypeNewReleaseDVDs:
                response = [request makeRequest:@"lists/dvds/new_releases" withArguments:arguments];
                break;
            case MovieListTypeUpcomingDVDs:
                response = [request makeRequest:@"lists/dvds/upcoming" withArguments:arguments];
                break;
        }
        
        [self parseResponse:response];
    }
    
    return self;
}

- (instancetype)initWithListResponse:(NSDictionary *)movieListResponse
{
    self = [super init];
    if (self)
        [self parseResponse:movieListResponse];
    return self;
}

- (instancetype)initWithSearchQuery:(NSString *)movieSearchQuery length:(int)responseLength
{
    self = [super init];
    if (self)
    {
        RottenTomatoesApiRequest *request = [[RottenTomatoesApiRequest alloc] init];
        
        // all the spaces have to be replaces with %20 since it's a URL
        movieSearchQuery = [movieSearchQuery stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        // make a search request to the api
        NSDictionary *args = @{ @"page_limit": [NSString stringWithFormat:@"%d", responseLength], @"q": movieSearchQuery };
        [self parseResponse: [request makeRequest:@"movies" withArguments:args]];
    }
    
    return self;
}

- (void)parseResponse:(NSDictionary *)response
{
    // add all of the movies from the api response to the internal list
    for (NSDictionary *movieDict in [response objectForKey:@"movies"])
    {
        [self.movies addObject:[[RottenTomatoesMovie alloc] init:movieDict]];
    }
}

- (RottenTomatoesMovie *)movieAtIndex:(int)index
{
    return self.movies[index];
}

- (int)movieCount
{
    return [self.movies count];
}

- (NSMutableArray *)movies
{
    if (_movies == nil)
        _movies = [[NSMutableArray alloc] init];
    return _movies;
}

@end
