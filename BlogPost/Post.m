//
//  Post.m
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 10/27/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import "Post.h"

@implementation Post
/*
@synthesize name;
@synthesize title;
@synthesize description;
@synthesize date;
@synthesize latitude;
@synthesize longitude;
@synthesize imageData;*/

-(id)initWithName:(NSString *)name description:(NSString *)description title:(NSString *)title latitude:(NSString *)latitude longitude:(NSString *)longitude imageData:(NSData *)imageData date:(NSDate *)date
{
    self = [super init];
    if (self) {
        _name = name;
        _description = description;
        _title = title;
        _date = date;
        _latitude = latitude;
        _longitude = longitude;
        _imageData = imageData;
        return self;
    }
    return nil;
}

@end
