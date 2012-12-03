//
//  AppDelegate.h
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 10/27/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddPostViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate> {

   UIWindow *window;
	
   CLLocationManager *locationManager;

   AddPostViewController *viewController;
    
    NSMutableArray *data;
    
        
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet AddPostViewController *viewController;

@property (nonatomic, retain) NSMutableArray *data;

@end
