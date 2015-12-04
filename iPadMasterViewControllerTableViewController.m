//
//  iPadMasterViewControllerTableViewController.m
//  NFLStadiums
//
//  Created by Michael Sevy on 12/3/15.
//  Copyright © 2015 Michael Sevy. All rights reserved.
//

#import "iPadMasterViewControllerTableViewController.h"
#import "Color.h"
#import "VenueData.h"
#import "DetailiPadViewController.h"


@interface iPadMasterViewControllerTableViewController ()


@property NSArray *venues;
@property NSMutableArray *pertinentData;


@end

@implementation iPadMasterViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;

    self.venues = [NSArray new];
    self.pertinentData = [NSMutableArray new];

    self.navigationController.hidesBarsOnSwipe = YES;
    self.navigationItem.title = @"NFL 12";
    [self.navigationController.navigationBar setBarTintColor:[Color nflBlue]];

    self.automaticallyAdjustsScrollViewInsets = NO;

}

-(void)viewDidAppear:(BOOL)animated{
    [self getNFLVenueData];

    [self.navigationController.navigationBar setBarTintColor:[Color nflBlue]];
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pertinentData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    VenueData *venue = [self.pertinentData objectAtIndex:indexPath.row];

    cell.textLabel.text = venue.venueName;
    cell.detailTextLabel.text = venue.address;
    cell.imageView.image = [UIImage imageWithData:venue.imageData];

    return cell;
}



- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {

    if ([secondaryViewController isKindOfClass:[UINavigationController class]]
        && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailiPadViewController class]])   {
        return YES;

    } else {

        return NO;
    }
}


#pragma mark -- segue method
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"Detail"]) {

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        VenueData *ven = [self.pertinentData objectAtIndex:indexPath.row];
        DetailiPadViewController *detailVC = (DetailiPadViewController *)[[segue destinationViewController]topViewController];

        detailVC.sAddress = ven.streetNo;
        detailVC.sCityStateZip = ven.cityStateZip;
        detailVC.sName = ven.venueName;
        detailVC.sImageData = ven.imageData;
        detailVC.sSchdeule = ven.schedules;
    }
}


#pragma mark -- helper
-(void)getNFLVenueData  {

    NSString *urlString = [NSString stringWithFormat:@"https://s3.amazonaws.com/jon-hancock-phunware/nflapi-static.json"];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData * _Nullable data,
                                NSURLResponse * _Nullable response,
                                NSError * _Nullable error) {
                if (!error) {

                    self.venues = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

                    for (NSDictionary *item in self.venues) {

                        VenueData *ven = [VenueData new];

                        NSString *name = item[@"name"];
                        NSString *address = item[@"address"];
                        NSString *image = item[@"image_url"];
                        NSString *city = item[@"city"];
                        NSString *state = item[@"state"];
                        NSString *zip = item[@"zip"];
                        NSString *addressCityStateZip = [NSString stringWithFormat:@"%@, %@, %@ %@", address, city, state, zip];
                        NSString *cityStateZip = [NSString stringWithFormat:@"%@, %@ %@", city, state, zip];
                        NSArray *array = item[@"schedule"];

                        ven.streetNo = address;
                        ven.address = addressCityStateZip;
                        ven.cityStateZip = cityStateZip;
                        ven.schedules = array;
                        ven.venueName = name;
                        ven.imageURLString = image;
                        [ven convertStringToData:image];

                        [self.pertinentData addObject:ven];

                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                    }
                }
            }]
     resume];
}

@end
