//
//  ZYInstapaperActivityItem.m
//  InstapaperActivity
//
//  Created by Mariano Abdala on 9/29/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYInstapaperActivityItem.h"

@interface ZYInstapaperActivityItem ()

@property (copy, nonatomic) NSURL *url;

@end

@implementation ZYInstapaperActivityItem

- (id)initWithURL:(NSURL *)url {

    if (url == nil) {
        
        return nil;
    }
    
    self =
    [super init];

    if (self != nil) {
    
        self.url = url;
    }

    return self;
}

@end
