//
// Created by Adam Dziedzic on 29.12.2016.
// Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/View+MASAdditions.h>
#import "DetailsViewController.h"
#import "Article.h"
#import "Constants.h"

@interface DetailsViewController ()

@property UILabel *titleLabel;
@property UILabel *descriptionLabel;
@property UIImageView *thumbnail;
@property UIButton *linkButton;

@property Article *article;

@end

@implementation DetailsViewController {

}
- (instancetype)initWithArticle:(Article *)article {
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = article.title;
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.text = article.abstract;
        _descriptionLabel.numberOfLines = 100;
        _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _thumbnail = [[UIImageView alloc] init];
        [_thumbnail sd_setImageWithURL:[NSURL URLWithString:article.thumbnailURL]];
        _linkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_linkButton setTitle:@"Show in Safari" forState:UIControlStateNormal];
        [_linkButton addTarget:self action:@selector(goToSafari:) forControlEvents:UIControlEventTouchUpInside];
        _article = article;

        self.view.backgroundColor = [UIColor whiteColor];
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_descriptionLabel];
    [self.view addSubview:_thumbnail];
    [self.view addSubview:_linkButton];

    __weak typeof(self) wself = self;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.view.mas_top).offset(SMALL_OFFSET);
        make.left.equalTo(wself.view.mas_left).offset(SMALL_OFFSET);
        make.right.equalTo(wself.view.mas_right).offset(-SMALL_OFFSET);
    }];

    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.titleLabel.mas_bottom).offset(SMALL_OFFSET);
        make.left.equalTo(wself.view.mas_left).offset(SMALL_OFFSET);
        make.right.equalTo(wself.view.mas_right).offset(-SMALL_OFFSET);
    }];

    [self.thumbnail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.descriptionLabel.mas_bottom).offset(SMALL_OFFSET);
        make.left.equalTo(wself.view.mas_left).offset(SMALL_OFFSET);
        make.right.equalTo(wself.view.mas_right).offset(-SMALL_OFFSET);
        make.width.equalTo(wself.thumbnail.mas_height).multipliedBy(wself.thumbnailAspectRatio);
    }];

    [self.linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wself.thumbnail.mas_bottom).offset(SMALL_OFFSET);
        make.left.equalTo(wself.view.mas_left).offset(SMALL_OFFSET);
        make.right.equalTo(wself.view.mas_right).offset(-SMALL_OFFSET);
    }];
}

- (CGFloat)thumbnailAspectRatio {
    return [self.article.originalHeight floatValue] / [self.article.originalWidth floatValue];;
}


- (void)goToSafari:(id)action {
    //todo fetch base url from response
    NSString *urlString = [@"http://gameofthrones.wikia.com" stringByAppendingString:self.article.url];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"going into safari, can open url: %d", [[UIApplication sharedApplication] canOpenURL:url]);
    [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
}

@end