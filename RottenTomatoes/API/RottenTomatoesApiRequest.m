//
//  RottenTomatoesApiRequest.m
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/15/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import "RottenTomatoesApiRequest.h"

@implementation RottenTomatoesApiRequest

static const NSString *apiKey = @"ntk3a8cjhrxvp9rsmt3kvurx";

- (NSDictionary *)makeRequest:(NSString *)request
{
    return [self makeRequest:request withArguments:nil];
}

- (NSDictionary *)makeRequest:(NSString *)request withArguments:(NSDictionary *)args
{
    // create the request URL with the actual request and the api key
    NSMutableString *urlBuilder = [[NSMutableString alloc] initWithString:@"http://api.rottentomatoes.com/api/public/v1.0/"];
    [urlBuilder appendFormat:@"%@.json?apikey=%@", request, apiKey];
    
    // append all of the arguments
    for (NSString *argName in args)
        [urlBuilder appendFormat:@"&%@=%@", argName, [args objectForKey:argName]];
    
    // send the request to the server
    NSData *response = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlBuilder]];
    
    // attempt to serialize the json
    NSError *jsonError = nil;
    id serializedJson = [NSJSONSerialization JSONObjectWithData:response options:0 error:&jsonError];
    
    // an error occurred, give them back nil
    if (jsonError != nil || ![serializedJson isKindOfClass:[NSDictionary class]])
        return nil;
    
    return serializedJson;
}

@end
