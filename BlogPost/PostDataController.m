//
//  PostDataController.m
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 11/6/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import "PostDataController.h"
#import "Post.h"
#import <RestKit/RestKit.h>


@interface PostDataController ()
- (void)initializeDefaultDataList;
@end

@implementation PostDataController
- (void)initializeDefaultDataList {
    NSMutableArray *postList = [[NSMutableArray alloc] init];
    self.postList = postList;
    //Post *post;
   // NSDate *today = [NSDate date];
    //post = [[Post alloc] initWithName:@"Pigeon" location:@"Everywhere" date:today];
    //[self addPost:post];
}


- (void)setPostList:(NSMutableArray *)newList {
    if (_postList != newList) {
        _postList = [newList mutableCopy];
    }
}
- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}
- (NSUInteger)countOfList {
    return [self.postList count];
}

- (Post *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.postList objectAtIndex:theIndex];
}

- (void)addPost:(Post *)post {

    [self.postList addObject:post];

    RKURL *baseURL = [RKURL URLWithBaseURLString:@"http://abqcity.herokuapp.com/pages/about"];
    RKObjectManager *objectManager = [RKObjectManager objectManagerWithBaseURL:baseURL];
    objectManager.client.baseURL = baseURL;
    [objectManager setSerializationMIMEType:RKMIMETypeJSON];
 
    RKObjectMapping *postMapping = [RKObjectMapping mappingForClass:[Post class]];
    [postMapping mapKeyPathsToAttributes:@"category", @"category", nil];
    [postMapping mapKeyPathsToAttributes:@"title", @"title", nil];
    [postMapping mapKeyPathsToAttributes:@"description", @"description", nil];
    [RKObjectManager sharedManager].serializationMIMEType = RKMIMETypeFormURLEncoded;
    [objectManager.router routeClass:[Post class] toResourcePath:@"/issues" forMethod:RKRequestMethodPOST];
    [RKObjectManager sharedManager].acceptMIMEType = RKMIMETypeJSON;
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:postMapping forClass:[Post class]];

    
    //[[RKObjectManager sharedManager] postObject:post delegate:self];
    

}


@end
