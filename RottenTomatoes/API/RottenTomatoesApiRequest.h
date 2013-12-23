//
//  RottenTomatoesApiRequest.h
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/15/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RottenTomatoesApiRequest : NSObject

- (NSDictionary*)makeRequest:(NSString *)request;
- (NSDictionary*)makeRequest:(NSString *)request withArguments:(NSDictionary*)args;

@end
