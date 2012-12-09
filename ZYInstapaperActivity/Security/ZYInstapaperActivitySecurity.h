//
//  ZYInstapaperActivitySecurity.h
//  ZYInstapaperActivity
//
//  Created by Mariano Abdala on 10/1/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYInstapaperActivitySecurity : NSObject

@property (copy, nonatomic, readonly) NSString *username;
@property (copy, nonatomic, readonly) NSString *password;
@property (assign, nonatomic, readonly) BOOL hasCredentials;

- (void)storeUsername:(NSString *)username password:(NSString *)password;

@end
