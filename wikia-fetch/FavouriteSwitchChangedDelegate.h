//
// Created by Adam Dziedzic on 08.01.2017.
// Copyright (c) 2017 Adam Dziedzic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FavouriteSwitchChangedDelegate <NSObject>

- (void)switchWithId:(NSNumber *)objectId changedToState:(BOOL)state;
@end