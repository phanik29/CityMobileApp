//
//  AddPostViewController.h
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 11/13/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@class Post;

@interface AddPostViewController : UITableViewController <UITextFieldDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    CLLocationManager *locationManager;
	MKMapView *mapView;
    UILabel *latitude;
    UILabel *longitude;
    UIImagePickerController *imagePicker;
    UITextField *postNameInput;
    NSArray *issueList;
	
}


@property (retain, nonatomic) IBOutlet UITextField *postNameInput;

@property (weak, nonatomic) IBOutlet UITextField *postTitleInput;
@property (weak, nonatomic) IBOutlet UITextField *postDescriptionInput;

@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UIButton *grabImage;
@property (weak, nonatomic) IBOutlet UIImageView *image;


@property (weak, nonatomic) IBOutlet UIButton *getCurrentLocation;
@property (strong, nonatomic) Post *post;

@property (nonatomic, retain) UIImagePickerController *imgPicker;

- (IBAction)grabImage;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)tapBackground:(id)sender;



@end
