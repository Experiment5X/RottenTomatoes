//
//  MovieSearchTableViewController.m
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/22/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import "MovieSearchTableViewController.h"

@interface MovieSearchTableViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *srchMovie;
@property (strong, nonatomic) NSMutableArray *searchResults;

@end

@implementation MovieSearchTableViewController

- (void)viewDidLoad
{
    self.srchMovie.delegate = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MovieDetailsViewController class]])
    {
        MovieDetailsViewController *details = segue.destinationViewController;
        details.movie = self.searchResults[self.tableView.indexPathForSelectedRow.row];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    RottenTomatoesMovieList *searchList = [[RottenTomatoesMovieList alloc] initWithSearchQuery:self.srchMovie.text length:20];
    self.searchResults = searchList.movies;
    
    [self.srchMovie resignFirstResponder];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    RottenTomatoesMovie *curMovie = self.searchResults[indexPath.row];
    
    movieCell.textLabel.text = curMovie.title;
    movieCell.detailTextLabel.text = [NSString stringWithFormat:@"%d", curMovie.year];
    
    return movieCell;
}

@end
