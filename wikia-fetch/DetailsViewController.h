//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Article;

@interface DetailsViewController : UIViewController
- (instancetype)initWithArticle:(Article *)article;

- (CGFloat)thumbnailAspectRatio;
@end