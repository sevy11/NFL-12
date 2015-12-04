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

//@property (strong, nonatomic) IBOutlet UITableView *tableView;
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
    [self.navigationController.navigationBar setBarTintColor:[Color nflRed]];

    self.automaticallyAdjustsScrollViewInsets = NO;

}

-(void)viewDidAppear:(BOOL)animated{
    [self getNFLVenueData];
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
//        && ([(DetailiPadViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {

        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;

    } else {

        return NO;
        
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
                        NSLog(@"name: %@", ven.venueName);
                        NSLog(@"image file url: %@", ven.imageURLString);
                        NSLog(@"address: %@\n %@", ven.address, ven.cityStateZip);

                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.tableView reloadData];
                        });
                    }
                }
            }]
     resume];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
