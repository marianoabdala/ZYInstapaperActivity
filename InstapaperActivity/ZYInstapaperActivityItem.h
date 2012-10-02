//
//  ZYInstapaperActivityItem.h
//  InstapaperActivity
//
//  Created by Mariano Abdala on 9/29/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYInstapaperActivityItem : NSObject

@property (copy, nonatomic, readonly) NSURL *url;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *description;

- (id)initWithURL:(NSURL *)url;

@end
