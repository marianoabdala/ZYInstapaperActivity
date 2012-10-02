//
//  ZYInstapaperActivity.m
//  InstapaperActivity
//
//  Created by Mariano Abdala on 9/29/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYInstapaperActivity.h"
#import "ZYInstapaperActivityItem.h"
#import "ZYCredentialsViewController.h"
#import "ZYAddViewController.h"
#import "ZYInstapaperActivitySecurity.h"

@interface ZYInstapaperActivity ()

@property (copy, nonatomic) NSArray *activityItems;

@end

@implementation ZYInstapaperActivity

#pragma mark - Hierarchy
#pragma mark UIActivity
- (NSString *)activityType {

    return @"com.zerously.instapaper_activity";
}

- (NSString *)activityTitle {

    return NSLocalizedString(@"Read Later", @"");
}

- (UIImage *)activityImage {
    
    UIUserInterfaceIdiom idiom = UI_USER_INTERFACE_IDIOM();
    
    UIImage *activityImage;
    
    if (idiom == UIUserInterfaceIdiomPhone) {
        
        activityImage =
        [UIImage imageNamed:@"instapaper"];
        
    } else if (idiom == UIUserInterfaceIdiomPad) {

        activityImage =
        [UIImage imageNamed:@"instapaper-ipad"];
        
    } else {
        
        NSLog(@"Unknown idiom, trying to acquire activityImage for ZYInstapaperActivity.");
    }
    
    return activityImage;
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {

    __block BOOL urlFound = NO;
    
    [activityItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {

        //If it's an InstapaperActivityItem (internal, non-empty URL is guaranteed).
        if ([obj class] == [ZYInstapaperActivityItem class]) {
            
            urlFound    = YES;
            *stop       = YES;
            return;
        }

        //If it's a non-empty URL.
        if ([obj class] == [NSURL class]) {

            urlFound    = YES;
            *stop       = YES;
            return;
        }
        
        //If it's a well formated URL string.
        if ([NSURL URLWithString:obj] != nil) {
            
            urlFound    = YES;
            *stop       = YES;
            return;
        }
    }];
    
    return urlFound;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    
    self.activityItems = activityItems;
}

- (UIViewController *)activityViewController {

    UIViewController *controller = nil;
    
    ZYInstapaperActivitySecurity *security =
    [[ZYInstapaperActivitySecurity alloc] init];
    
//    if (security.hasCredentials == NO) {

        ZYCredentialsViewController *credentialsViewController =
        [[ZYCredentialsViewController alloc] initWithNibName:@"ZYCredentialsViewController"
                                                      bundle:nil
                                                activityItem:self.activityItems[0]];
        
        credentialsViewController.activity = self;
        
        controller = credentialsViewController;

//    } else {
//        
//        //TODO: Obtain the right one.
//        ZYAddViewController *addViewController =
//        [[ZYAddViewController alloc] initWithNibName:@"ZYAddViewController"
//                                              bundle:nil
//                                        activityItem:self.activityItems[0]];
//        
//        addViewController.activity = self;
//        
//        controller = addViewController;
//    }
    
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:controller];
    
    return navigationController;
}

#pragma mark - Self
#pragma mark ZYInstapaperActivity
+ (id)instance {
    
    static dispatch_once_t pred = 0;
    __strong static id _instance = nil;
    
    dispatch_once(&pred, ^{
        
        _instance =
        [[self alloc] init];
    });
    
    return _instance;
}

@end
