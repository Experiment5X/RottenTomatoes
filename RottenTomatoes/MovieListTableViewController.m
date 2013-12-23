//
//  MovieListTableViewController.m
//  RottenTomatoes
//
//  Created by Adam Spindler on 12/20/13.
//  Copyright (c) 2013 Adam Spindler. All rights reserved.
//

#import "MovieListTableViewController.h"

@interface MovieListTableViewController ()

@end

@implementation MovieListTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MovieTableViewController class]])
    {
        MovieTableViewController *destination = segue.destinationViewController;
        destination.listType = self.tableView.indexPathForSelectedRow.row;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.title = @"Movie Lists";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *lists = @[ @"Box Office", @"Opening", @"Upcoming Movies", @"In Theaters", @"Top Rentals", @"Current Release DVDs", @"New Release DVDs", @"Upcoming DVDs" ];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieListCell" forIndexPath:indexPath];
    cell.textLabel.text = lists[indexPath.row];
    
    return cell;
}

@end
