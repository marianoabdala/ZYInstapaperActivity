//
//  ZYInstapaperAddRequest.h
//  ZYInstapaperActivity
//
//  Created by Mariano Abdala on 9/30/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYInstapaperAddRequestDelegate.h"

@class ZYInstapaperActivityItem;

@interface ZYInstapaperAddRequest : NSObject

- (id)initWithItem:(ZYInstapaperActivityItem *)item delegate:(id<ZYInstapaperAddRequestDelegate>)delegate;
- (void)cancel;

@end
