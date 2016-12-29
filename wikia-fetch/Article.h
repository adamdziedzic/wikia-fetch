//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Article : NSObject

@property (nonatomic, strong) NSNumber *myId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *abstract;
@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, strong) NSNumber *originalWidth;
@property (nonatomic, strong) NSNumber *originalHeight;
@property (nonatomic, strong) NSString *url;

+ (Article *)fromDictionary:(NSDictionary *)dict;

@end