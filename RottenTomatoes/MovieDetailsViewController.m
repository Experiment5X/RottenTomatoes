//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/19/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import "MovieDetailsViewController.h"

@interface MovieDetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblReleaseDate;
@property (weak, nonatomic) IBOutlet UILabel *lblMPAARating;
@property (weak, nonatomic) IBOutlet UILabel *lblCritcs;
@property (weak, nonatomic) IBOutlet UILabel *lblFans;

@property (weak, nonatomic) IBOutlet UIProgressView *prgCritics;
@property (weak, nonatomic) IBOutlet UIProgressView *prgFans;

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

@property (weak, nonatomic) IBOutlet UITextView *txtSynopsis;

@end

@implementation MovieDetailsViewController

- (void)viewDidLoad
{
    self.navigationItem.title = self.movie.title;
    self.lblReleaseDate.text = self.movie.theaterDate;
    self.lblMPAARating.text = self.movie.rating;
    self.imgIcon.image = self.movie.icon;
    
    // if there isn't a synopsis, then tell the user that
    NSString *trimmed = [self.movie.synopsis stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (![trimmed isEqualToString:@""])
    	self.txtSynopsis.text = self.movie.synopsis;
    else
        self.txtSynopsis.text = @"No synopsis available";
    
    // make sure that there's a rating for this movie
    if (self.movie.criticRating != -1)
    {
        self.lblCritcs.text = [NSString stringWithFormat:@"%d/100", self.movie.criticRating];
        self.prgCritics.progress = self.movie.criticRating / 100.0;
    }
    else
    {
        self.lblCritcs.text = @"No Rating";
        self.prgCritics.progress = 0;
    }
    
    // ditto
    if (self.movie.fanRating != -1)
    {
        self.lblFans.text = [NSString stringWithFormat:@"%d/100", self.movie.fanRating];
        self.prgFans.progress = self.movie.fanRating / 100.0;
    }
    else
    {
        self.lblFans.text = @"No Rating";
        self.prgFans.progress = 0;
    }
}

@end
