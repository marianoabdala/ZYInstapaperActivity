//
//  ZYInstapaperActivitySecurity.m
//  InstapaperActivity
//
//  Created by Mariano Abdala on 10/1/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYInstapaperActivitySecurity.h"
#import "KeychainItemWrapper.h"

#define KEYCHAIN_IDENTIFIER     @"YOUR_APP_ID_HERE.com.zerously.instapaper_activity"
#define KEYCHAIN_USERNAME_KEY   (__bridge id)kSecAttrAccount
#define KEYCHAIN_PASSWORD_KEY   (__bridge id)kSecValueData

@interface ZYInstapaperActivitySecurity ()

@property (strong, nonatomic) KeychainItemWrapper *keychainItemWrapper;

@end

@implementation ZYInstapaperActivitySecurity

#pragma mark - Self
#pragma mark ZYInstapaperActivitySecurity
- (NSString *)username {
    
    return [self.keychainItemWrapper objectForKey:KEYCHAIN_USERNAME_KEY];
}

- (NSString *)password {
    
    return [self.keychainItemWrapper objectForKey:KEYCHAIN_PASSWORD_KEY];
}

- (BOOL)hasCredentials {
    
    return self.username.length > 0 &&
            self.password.length > 0;
}

- (void)storeUsername:(NSString *)username password:(NSString *)password {
    
    [self.keychainItemWrapper setObject:username
                                 forKey:KEYCHAIN_USERNAME_KEY];
    
    [self.keychainItemWrapper setObject:password
                                 forKey:KEYCHAIN_PASSWORD_KEY];
}

#pragma mark ZYInstapaperActivitySecurity ()
- (KeychainItemWrapper *)keychainItemWrapper {

    if (_keychainItemWrapper == nil) {

        self.keychainItemWrapper =
        [[KeychainItemWrapper alloc] initWithIdentifier:KEYCHAIN_IDENTIFIER
                                            accessGroup:nil];
    }
    
    return _keychainItemWrapper;
}


@end
