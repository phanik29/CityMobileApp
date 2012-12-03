//
//  AddPostViewController.m
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 11/13/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import "AddPostViewController.h"
#import "Post.h"
#import "AppDelegate.h"

@interface AddPostViewController ()

@end

@implementation AddPostViewController


//@synthesize mapView;
@synthesize latitude;
@synthesize longitude;
@synthesize imgPicker;
@synthesize image;
@synthesize postNameInput;
//@synthesize issueList;



- (IBAction)hideKeyboard:(id)sender {
    [sender resignFirstResponder];

    
}

- (IBAction)tapBackground:(id)sender {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.postNameInput) || (textField == self.postTitleInput)|| (textField == self.postDescriptionInput)) {
        [textField resignFirstResponder];
    }
    
    return YES;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    
    
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.allowsImageEditing = YES;
    self.imgPicker.delegate = self;
    self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    issueList = [[NSArray alloc] initWithArray:appDelegate.data];
    
 
    UIPickerView *cityPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    [cityPicker setShowsSelectionIndicator:YES];
    postNameInput.inputView = cityPicker;
    
    // Create done button in UIPickerView
    
    UIToolbar*  mypickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 56)];
    mypickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [mypickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked)];
    [barItems addObject:doneBtn];
    
    [mypickerToolbar setItems:barItems animated:YES];
    
    postNameInput.inputAccessoryView = mypickerToolbar;
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image.png"]];
    backgroundView.frame = CGRectMake(0, 0, self.navigationController.view.frame.size.width, self.navigationController.view.frame.size.height);
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.navigationController.view insertSubview:backgroundView atIndex:0];
    
    //[backgroundView release];
    
    self.tableView.backgroundColor = [UIColor clearColor];

    
}

-(void)pickerDoneClicked
{
    NSLog(@"Done Clicked");
    [postNameInput resignFirstResponder];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSLog(@"This is %s", __func__);
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     NSLog(@"This is %s", __func__);
    //return 1;
    return issueList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return [issueList objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    postNameInput.text = (NSString *)[issueList objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
    
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


*/
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    /* <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];*/
     
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        if ([self.postNameInput.text length] || [self.postTitleInput.text length] ||
            [self.postDescriptionInput.text length]) {
            Post    *post;
            NSDate *today = [NSDate date];
            post = [[Post alloc] initWithName:self.postNameInput.text description:self.postDescriptionInput.text title:self.postTitleInput.text latitude:self.latitude.text  longitude:self.longitude.text imageData:UIImagePNGRepresentation(self.image.image) date:today];
            self.post   = post;
        }
    }
} 


- (void)viewDidUnload {
    [self setPostNameInput:nil];
    [self setPostTitleInput:nil];
    [self setPostDescriptionInput:nil];

    [self setGetCurrentLocation:nil];
    [self setLatitude:nil];
    [self setLongitude:nil];
    [self setGrabImage:nil];
    [self setImage:nil];
    [self setGrabImage:nil];
    [super viewDidUnload];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    int degrees = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - degrees);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    float lat1;
    NSString *lat = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                     degrees, minutes, seconds];
    //latitude.text = lat;
    //latitude.text.floatValue = [[NSString alloc]initWithFormat:@"%6.f", newLocation.coordinate.longitude];
    lat1 = newLocation.coordinate.latitude;
    latitude.text = [NSString stringWithFormat:@"%f", lat1];
    decimal = fabs(newLocation.coordinate.longitude - degrees);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%d° %d' %1.4f\"",
                       degrees, minutes, seconds];
    lat1 = newLocation.coordinate.longitude;
    longitude.text = [NSString stringWithFormat:@"%f", lat1];
    //longitude.text = longt;
    
}

- (IBAction)grabImage {
    [self presentModalViewController:self.imgPicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    image.image = img;
    [picker dismissModalViewControllerAnimated:YES];
}

@end
