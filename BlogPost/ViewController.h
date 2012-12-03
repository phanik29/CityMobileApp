//
//  ViewController.h
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 11/25/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "AddPostViewController.h"

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIWebView *viewWeb;
- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;
@end
