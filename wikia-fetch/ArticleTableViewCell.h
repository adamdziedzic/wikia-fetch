//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Article;

@interface ArticleTableViewCell : UITableViewCell

@property (strong) UILabel *titleLabel;
@property (strong) UILabel *descriptionLabel;
//fav icon
//image

@property(nonatomic) float thumbnailAspectRatio;

- (void)customizeCell:(Article *) article;

@end