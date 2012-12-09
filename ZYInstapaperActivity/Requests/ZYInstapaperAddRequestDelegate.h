//
//  ZYInstapaperAddRequestDelegate.h
//  ZYInstapaperActivity
//
//  Created by Mariano Abdala on 9/30/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZYInstapaperAddRequest;

@protocol ZYInstapaperAddRequestDelegate <NSObject>

- (void)instapaperAddRequestSucceded:(ZYInstapaperAddRequest *)request;
- (void)instapaperAddRequestFailed:(ZYInstapaperAddRequest *)request;
- (void)instapaperAddRequestIncorrectPassword:(ZYInstapaperAddRequest *)request;

@end
