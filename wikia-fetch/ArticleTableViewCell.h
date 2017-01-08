//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Article;
@protocol FavouriteSwitchChangedDelegate;

@interface ArticleTableViewCell : UITableViewCell

@property (weak) id<FavouriteSwitchChangedDelegate> switchDelegate;

- (void)customizeCell:(Article *)article isFavourite:(BOOL)favourite;

@end