//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "Article.h"
#import "View+MASAdditions.h"
#import "UIImageView+WebCache.h"
#import "Constants.h"
#import "FavouriteSwitchChangedDelegate.h"

@interface ArticleTableViewCell ()

@property UIImageView *thumbnail;
@property UILabel *titleLabel;
@property UILabel *descriptionLabel;
@property float thumbnailAspectRatio;
@property UISwitch *favourite;
@property(nonatomic, strong) Article *article;

@end

@implementation ArticleTableViewCell {


}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descriptionLabel.numberOfLines = 2;
        _thumbnail = [[UIImageView alloc] init];
        _favourite = [[UISwitch alloc] init];
        [_favourite addTarget:self action:@selector(stateChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_titleLabel];
        [self addSubview:_descriptionLabel];
        [self addSubview:_thumbnail];
        [self addSubview:_favourite];
    }

    return self;
}


- (void)layoutSubviews {
    __weak typeof(self) wself = self;
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wself.thumbnail.mas_right).offset(SMALL_OFFSET);
        make.top.equalTo(wself.favourite.mas_bottom).offset(SMALL_OFFSET);
        make.right.lessThanOrEqualTo(wself.mas_right).offset(-SMALL_OFFSET);
    }];
    [self.thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.mas_top).offset(SMALL_OFFSET);
        make.left.equalTo(wself.mas_left).offset(SMALL_OFFSET);
        make.bottom.equalTo(wself.mas_bottom).offset(-SMALL_OFFSET);
        make.width.equalTo(wself.thumbnail.mas_height).multipliedBy(wself.thumbnailAspectRatio);
    }];
    [self.favourite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.mas_top).offset(SMALL_OFFSET);
        make.right.equalTo(wself.mas_right).offset(-SMALL_OFFSET).priorityHigh;
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.mas_top).offset(SMALL_OFFSET);
        make.left.equalTo(wself.thumbnail.mas_right).offset(SMALL_OFFSET);
        make.right.equalTo(wself.favourite.mas_left).offset(-SMALL_OFFSET);
    }];
    [super layoutSubviews];
}


- (void)customizeCell:(Article *)article isFavourite:(BOOL)favourite {
    self.article = article;
    self.titleLabel.text = article.title;
    self.descriptionLabel.text = article.abstract;
    self.thumbnailAspectRatio = [article.originalHeight floatValue] / [article.originalWidth floatValue];
    [self.favourite setOn:favourite animated:NO];
    [self.thumbnail sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL]];
}

- (void)stateChanged:(id)sender {
    if (self.switchDelegate) [self.switchDelegate switchWithId:self.article.myId changedToState:[sender isOn]];
}


@end