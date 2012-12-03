//
//  ViewController.m
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 11/25/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import "ViewController.h"
#import <RestKit/RestKit.h>
#import "Post.h"
#import "AppDelegate.h"


@interface ViewController ()
@property (strong, nonatomic) NSArray *data;

@end

@implementation ViewController
@synthesize viewWeb;
@synthesize data;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)sendRequest
{
    //NSString *latLon = @"37.33,-122.03";
    //NSString *clientID = [NSString stringWithUTF8String:kCLIENTID];
    //NSString *clientSecret = [NSString stringWithUTF8String:kCLIENTSECRET];
    
    //NSDictionary *queryParams;
    //queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"client_id", c @"posts", @"query", @"20120602", @"v", nil];
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    objectManager.serializationMIMEType = RKMIMETypeJSON;
    
    RKURL *URL = [RKURL URLWithBaseURL:[objectManager baseURL] resourcePath:@"/datasets" ];//queryParameters:queryParams];
    [objectManager loadObjectsAtResourcePath:[NSString stringWithFormat:@"%@?%@", [URL resourcePath], [URL query]] delegate:self];
    
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSString *fullURL = @"http://abqcity.herokuapp.com/pages/about";
    //NSString *fullURL = @"http://0.0.0.0:3000/";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [viewWeb loadRequest:requestObj];

    RKURL *baseURL = [RKURL URLWithBaseURLString:@"http://abqcity.herokuapp.com/"];

    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.client.baseURL = baseURL;
    //objectManager.serializationMIMEType = RKMIMETypeJSON;
    
    [RKObjectManager sharedManager].serializationMIMEType = RKMIMETypeJSON;
    
    RKObjectMapping *postMapping = [RKObjectMapping mappingForClass:[Post class]];
    [postMapping mapKeyPathsToAttributes:@"name", @"name", nil];
    /*[postMapping mapKeyPathsToAttributes:@"source_link", @"name", nil];
    [postMapping mapKeyPathsToAttributes:@"title", @"title", nil];
    [postMapping mapKeyPathsToAttributes:@"description", @"description", nil];
    [postMapping mapKeyPathsToAttributes:@"latitude", @"latitude", nil];
    [postMapping mapKeyPathsToAttributes:@"longitude", @"longitude", nil];*/
    //[postMapping mapKeyPathsToAttributes:@"imageData", @"image", nil];

    //sobj.issueList = [[NSArray alloc] init];
    

    
    
    [objectManager.mappingProvider setMapping:postMapping forKeyPath:@""];
    [objectManager.mappingProvider setSerializationMapping:postMapping forClass:[Post class]];

  
    [objectManager.router routeClass:[Post class] toResourcePath:@"/issues" forMethod:RKRequestMethodPOST];
    
    //[self performSelector:@selector(DoSomethingCool) withObject:nil afterDelay:1.5];
    
    [self sendRequest];
    
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(refresh) userInfo:nil repeats:TRUE];

    
}

-(void)refresh{
	
    [self reloadInputViews];
    [self sendRequest];
                                                            
}
                                                            
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)cancel:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"CancelInput"]) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
    
    
    //[[self viewWeb] reload];
    //[self reloadInputViews];
    [self sendRequest];
    
}

#pragma mark - RKObjectLoaderDelegate

- (void)request:(RKRequest*)request didLoadResponse:(RKResponse*)response {
    if ([request isGET]) {
        if ([response isOK]) {
          // NSLog(@"Retrieved JSON: %@", [response bodyAsString]);

        }
    } else if ([request isPOST]) {
        if ([response isJSON]) {
            NSLog(@"Got a JSON response back from our POST!");
            
        }
    }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", [error localizedDescription]);
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    
    NSLog(@"objects[%d]", [objects count]);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.data removeAllObjects];
    for (Post *post in objects) {
        [appDelegate.data addObject:[post name]];
    }


    data = objects;


    
}

- (IBAction)done:(UIStoryboardSegue *)segue
{
    if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
        AddPostViewController *addController = [segue sourceViewController];
        NSLog(@"response code: %s", __FUNCTION__);
        
        if (addController.post) {
            ///[self.dataController addPost:addController.post];
            //RKURL *baseURL = [RKURL URLWithBaseURLString:@"http://abqcity.herokuapp.com/"];
            RKURL *baseURL = [RKURL URLWithBaseURLString:@"http://0.0.0.0:3000/"];
            RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
            objectManager.client.baseURL = baseURL;
            // [RKObjectManager sharedManager].serializationMIMEType = RKMIMETypeJSON;
            
            RKObjectMapping *postMapping = [RKObjectMapping mappingForClass:[Post class]];
            
            [postMapping mapKeyPath:@"name"
                        toAttribute:@"category"];
            [postMapping mapKeyPath:@"title"
                        toAttribute:@"title"];
            
            [postMapping mapKeyPath:@"description"
                        toAttribute:@"description"];
            
            [postMapping mapKeyPath:@"latitude"
                        toAttribute:@"latitiude"];
            
            [postMapping mapKeyPath:@"longitude"
                        toAttribute:@"longitude"];

            
            
            objectManager.serializationMIMEType = RKMIMETypeJSON;

            [objectManager.mappingProvider setMapping:postMapping forKeyPath:@""];
            [objectManager.mappingProvider setSerializationMapping:postMapping forClass:[Post class]];
            objectManager.serializationMIMEType = RKMIMETypeJSON;
            
            [objectManager.router routeClass:[Post class] toResourcePath:@"/issues" forMethod:RKRequestMethodPOST];
            
            // [[RKObjectManager sharedManager] postObject:addController.post delegate:self];
            
            
            
            RKParams* params = [RKParams params];
            
            [params setValue:addController.post.name forParam:@"issue[category]"];
            [params setValue:addController.post.title forParam:@"issue[title]"];
            [params setValue:addController.post.latitude forParam:@"issue[latitude]"];
            
            [params setValue:addController.post.longitude forParam:@"issue[longitude]"];
            
            [params setValue:addController.post.description forParam:@"issue[description]"];

            [params setData:addController.post.imageData MIMEType:@"image/png" forParam:@"issue[image]"];
            

            
            // Send a Request!
            [[RKClient sharedClient] post:@"/issues" params:params delegate:self];
            
            

            [self reloadInputViews];
            [self sendRequest];
            
            
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)viewDidUnload {
    [self setViewWeb:nil];
    [self setViewWeb:nil];
    [self setViewWeb:nil];
    [super viewDidUnload];
}



@end
