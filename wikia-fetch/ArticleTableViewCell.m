//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "Article.h"
#import "View+MASAdditions.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"

@interface ArticleTableViewCell ()

@property UIImageView *thumbnail;

@end

@implementation ArticleTableViewCell {


}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descriptionLabel.numberOfLines = 2;
        _thumbnail = [[UIImageView alloc] init];
        [self addSubview:_titleLabel];
        [self addSubview:_descriptionLabel];
        [self addSubview:_thumbnail];
    }

    return self;
}


- (void)layoutSubviews {
    __weak typeof(self) wself = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.mas_top).offset(SMALL_OFFSET);
        make.left.equalTo(wself.thumbnail.mas_right).offset(SMALL_OFFSET);
        make.right.lessThanOrEqualTo(wself.mas_right).offset(-SMALL_OFFSET);
    }];
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.thumbnail.mas_right).offset(SMALL_OFFSET);
        make.top.equalTo(wself.titleLabel.mas_bottom).offset(SMALL_OFFSET);
        make.right.lessThanOrEqualTo(wself.mas_right).offset(-SMALL_OFFSET);
    }];
    [self.thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.mas_top).offset(SMALL_OFFSET);
        make.left.equalTo(wself.mas_left).offset(SMALL_OFFSET);
        make.bottom.equalTo(wself.mas_bottom).offset(-SMALL_OFFSET);
        make.width.equalTo(wself.thumbnail.mas_height).multipliedBy(wself.thumbnailAspectRatio);
    }];
    [super layoutSubviews];
}


- (void)customizeCell:(Article *)article {
    self.titleLabel.text = article.title;
    self.descriptionLabel.text = article.abstract;
    self.thumbnailAspectRatio = [article.originalHeight floatValue] / [article.originalWidth floatValue];
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL] ];
}


@end