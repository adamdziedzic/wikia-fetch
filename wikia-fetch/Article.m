//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import "Article.h"


@implementation Article {

}
+ (Article *)fromDictionary:(NSDictionary *)dict {
    Article *article = [Article new];
    article.myId = dict[@"id"];
    article.abstract = dict[@"abstract"];
    article.thumbnailURL = dict[@"thumbnail"];
    article.title = dict[@"title"];
    article.originalHeight = dict[@"original_dimensions"][@"height"];
    article.originalWidth = dict[@"original_dimensions"][@"width"];
    return article;
}

@end