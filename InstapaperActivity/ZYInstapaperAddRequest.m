//
//  ZYInstapaperAddRequest.m
//  InstapaperActivity
//
//  Created by Mariano Abdala on 9/30/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYInstapaperAddRequest.h"
#import "ZYInstapaperActivityItem.h"
#import "ZYInstapaperActivity.h"
#import "ZYInstapaperActivitySecurity.h"

#define RESPONSE_SUCCESS            @"201"
#define RESPONSE_PASSWORD_INCORRECT @"403"

@interface ZYInstapaperAddRequest ()

@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *responseMutableData;
@property (assign, nonatomic) id<ZYInstapaperAddRequestDelegate> delegate;

- (void)startRequestWithItem:(ZYInstapaperActivityItem *)item;

@end

@implementation ZYInstapaperAddRequest

#pragma mark - Self
#pragma mark ZYInstapaperAddRequest
- (id)initWithItem:(ZYInstapaperActivityItem *)item delegate:(id<ZYInstapaperAddRequestDelegate>)delegate {

    if (item == nil) {
        
        return nil;
    }
    
    self =
    [super init];
    
    if (self != nil) {
        
        self.delegate = delegate;
        
        [self startRequestWithItem:item];
    }
    
    return self;
}

- (void)cancel {
    
    [self.connection cancel];
}

#pragma mark ZYInstapaperAddRequest ()
- (void)startRequestWithItem:(ZYInstapaperActivityItem *)item {
    
    
    NSString *urlToAdd =
    [item.url.absoluteString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    ZYInstapaperActivitySecurity *security =
    [[ZYInstapaperActivitySecurity alloc] init];

    NSString *urlString =
    [NSString stringWithFormat:
     @""
     "https://www.instapaper.com/api/add"
     "?username=%@"
     "&password=%@"
     "&url=%@"
     "&title=%@"
     "&selection=%@",
     security.username,
     security.password,
     urlToAdd,
     item.title != nil ? item.title : @"",
     item.description != nil ? item.description : @""];
    
    NSURL *url =
    [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLRequest *urlRequest =
    [NSURLRequest requestWithURL:url];
    
    NSURLConnection *urlConnection =
    [NSURLConnection connectionWithRequest:urlRequest
                                  delegate:self];
    
    if (urlConnection != nil) {
		
        self.responseMutableData =
        [NSMutableData data];
		
        [urlConnection start];
    }
}

#pragma mark - Protocols
#pragma mark NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    [self.responseMutableData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	
    [self.responseMutableData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    self.responseMutableData    = nil;
    self.connection             = nil;
    
    NSLog(@"Request for adding to instapaper failed.");

    [self.delegate instapaperAddRequestFailed:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *responseString =
    [[NSString alloc] initWithData:self.responseMutableData
                          encoding:NSUTF8StringEncoding];

    self.responseMutableData    = nil;
    self.connection             = nil;

    if ([responseString compare:RESPONSE_SUCCESS] == NSOrderedSame) {
        
        [self.delegate instapaperAddRequestSucceded:self];
        
    } else if ([responseString compare:RESPONSE_PASSWORD_INCORRECT] == NSOrderedSame) {

        [self.delegate instapaperAddRequestIncorrectPassword:self];
        
    } else {
        
        [self.delegate instapaperAddRequestFailed:self];
    }
}


@end
