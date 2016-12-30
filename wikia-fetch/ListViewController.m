//
//  ViewController.m
//  wikia-fetch
//
//  Created by Adam Dziedzic on 26.12.2016.
//  Copyright (c) 2016 Adam Dziedzic. All rights reserved.
//

#import "ListViewController.h"
#import "Article.h"
#import "ArticleTableViewCell.h"
#import "DetailsViewController.h"


@interface ListViewController () <NSURLSessionDataDelegate>

@property NSURLSession *session;
@property NSArray *articles;
@property NSMutableData *tempData;

@end

@implementation ListViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"background"] delegate:self delegateQueue:nil];
        _articles = @[];
        self.title = @"Characters";
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
}

#pragma mark - UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:REUSE_IDENTIFIER];
    if (!cell) {
        cell = [[ArticleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:REUSE_IDENTIFIER];
    }
    [cell customizeCell:self.articles[(NSUInteger) indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    DetailsViewController *viewController = [[DetailsViewController alloc] initWithArticle:self.articles[(NSUInteger) indexPath.row]];
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.tempData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (!error) {
        NSError *errorPlaceholder;
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:self.tempData options:nil error:&errorPlaceholder];
        //todo if (errorPlaceholder) {alert about error}
        NSArray *unparsedItems = response[@"items"];
        NSMutableArray *parsedItems = [NSMutableArray new];
        for (uint i = 0; i < unparsedItems.count; i++) {
            parsedItems[i] = [Article fromDictionary:unparsedItems[i]];
        }
        self.articles = parsedItems;
        [self.tableView performSelectorOnMainThread:@selector(reloadData)
                                         withObject:nil
                                      waitUntilDone:NO];
    } else {
        NSLog(@"error localized: %@", error.localizedDescription);
        NSLog(@"error localized reason: %@", error.localizedFailureReason);
    }
}


- (void)fetchData {
    NSURL *url = [[NSURL alloc] initWithString:@"https://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&limit=75&category=Characters"];
    self.tempData = [NSMutableData new];
    [[self.session dataTaskWithURL:url] resume];
}

@end