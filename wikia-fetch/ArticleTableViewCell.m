//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "Article.h"
#import "View+MASAdditions.h"
#import "UIImageView+WebCache.h"


@interface ArticleTableViewCell ()

@property UIImageView *thumbnail;

@end

@implementation ArticleTableViewCell {


}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _detailsLabel = [[UILabel alloc] init];
        _detailsLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _detailsLabel.numberOfLines = 2;
        _thumbnail = [[UIImageView alloc] init];
        [self addSubview:_titleLabel];
        [self addSubview:_detailsLabel];
        [self addSubview:_thumbnail];
    }

    return self;
}


- (void)layoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.thumbnail.mas_right).offset(5);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-5);
    }];
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumbnail.mas_right).offset(5);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.right.lessThanOrEqualTo(self.mas_right).offset(-5);
    }];
    [self.thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.equalTo(self.thumbnail.mas_height).multipliedBy(self.thumbnailAspectRatio);
    }];
    [super layoutSubviews];
}


- (void)customizeCell:(Article *)article {
    self.titleLabel.text = article.title;
    self.detailsLabel.text = article.abstract;
    self.thumbnailAspectRatio = [article.originalHeight floatValue] / [article.originalWidth floatValue];
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL] ];
}


@end