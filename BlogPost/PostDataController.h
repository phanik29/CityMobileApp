//
//  PostDataController.h
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 11/6/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Post;
@interface PostDataController : NSObject
@property (nonatomic, copy) NSMutableArray *postList;
- (NSUInteger)countOfList;
- (Post *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addPost:(Post *)post;
@end
