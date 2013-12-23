//
//  NewReleasesTableViewController.m
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/18/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import "MovieTableViewController.h"
#import "MovieDetailsViewController.h"

@interface MovieTableViewController ()

@property (strong, nonatomic) RottenTomatoesMovieList *movies;

@end

@implementation MovieTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destination = segue.destinationViewController;
    
    if ([destination isKindOfClass:[MovieDetailsViewController class]])
    {
        MovieDetailsViewController *movieDetails = destination;
        movieDetails.movie = [self.movies movieAtIndex: self.tableView.indexPathForSelectedRow.row];
    }
}

- (RottenTomatoesMovieList *)movies
{
    if (!_movies)
        _movies = [[RottenTomatoesMovieList alloc] initWithListType:self.listType length:50];
    return _movies;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.movies movieCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.movies movieAtIndex:indexPath.row].title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [self.movies movieAtIndex:indexPath.row].year];

    return cell;
}

@end
