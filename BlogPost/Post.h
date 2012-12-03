//
//  Post.h
//  BlogPost
//
//  Created by PHANI KUMAR KANDREGULA on 10/27/12.
//  Copyright (c) 2012 PHANI KUMAR KANDREGULA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong)  NSData *imageData;


-(id)initWithName:(NSString *)name description:(NSString *)description title:(NSString *)title latitude:(NSString *)latitude longitude:(NSString *)longitude imageData:(NSData *)imageData date:(NSDate *)date;
@end
