//
//  ZYInstapaperActivity.m
//  ZYInstapaperActivity
//
//  Created by Mariano Abdala on 9/29/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYInstapaperActivity.h"
#import "ZYInstapaperActivityItem.h"
#import "ZYAddItemsViewController.h"
#import "ZYCredentialsViewController.h"
#import "ZYAddItemViewController.h"
#import "ZYInstapaperActivitySecurity.h"

@interface ZYInstapaperActivity ()

@property (copy, nonatomic) NSArray *activityItems;

- (void)removeDuplicateActivityItems;
- (void)boxActivityItems;

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
        if ([obj isKindOfClass:[ZYInstapaperActivityItem class]] == YES) {
            
            urlFound    = YES;
            *stop       = YES;
            return;
        }

        //If it's a non-empty URL.
        if ([obj isKindOfClass:[NSURL class]] == YES) {

            urlFound    = YES;
            *stop       = YES;
            return;
        }
        
        //If it's a well formated URL string.
        if ([obj isKindOfClass:[NSString class]] == YES &&
            [NSURL URLWithString:obj] != nil) {
            
            urlFound    = YES;
            *stop       = YES;
            return;
        }
    }];
    
    return urlFound;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    
    self.activityItems = activityItems;
    [self boxActivityItems];
    [self removeDuplicateActivityItems];
}

- (UIViewController *)activityViewController {

    UIViewController *controller = nil;
    
    ZYInstapaperActivitySecurity *security =
    [[ZYInstapaperActivitySecurity alloc] init];
    
    if (security.hasCredentials == NO) {

        ZYCredentialsViewController *credentialsViewController =
        [[ZYCredentialsViewController alloc] initWithNibName:@"ZYCredentialsViewController"
                                                      bundle:nil
                                               activityItems:self.activityItems];
        
        credentialsViewController.activity = self;
        
        controller = credentialsViewController;

    } else {
        
        if (self.activityItems.count == 1) {

            ZYAddItemViewController *addItemViewController =
            [[ZYAddItemViewController alloc] initWithNibName:@"ZYAddItemViewController"
                                                      bundle:nil
                                                activityItem:self.activityItems[0]];
            
            addItemViewController.activity = self;
            
            controller = addItemViewController;
            
        } else {
         
            ZYAddItemsViewController *addItemsViewController =
            [[ZYAddItemsViewController alloc] initWithNibName:@"ZYAddItemsViewController"
                                                       bundle:nil
                                                activityItems:self.activityItems];
            
            addItemsViewController.activity = self;
            
            controller = addItemsViewController;

        }
    }
    
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

#pragma mark ZYInstapaperActivity ()
- (void)removeDuplicateActivityItems {

    NSMutableArray *activityItemsToRemove =
    [NSMutableArray array];
    
    [self.activityItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[ZYInstapaperActivityItem class]] == YES) {
            
            ZYInstapaperActivityItem *item =
            (ZYInstapaperActivityItem *)obj;
            
            [self.activityItems enumerateObjectsUsingBlock:^(id objToRemove, NSUInteger idxToRemove, BOOL *stopToRemove) {
                
                if (item != objToRemove &&
                    [item isEqual:objToRemove] == YES) {
                    
                    [activityItemsToRemove addObject:objToRemove];
                    return;
                }
                
                if ([item.url isEqual:objToRemove] == YES) {
                    
                    [activityItemsToRemove addObject:objToRemove];
                    return;
                }
                
                if ([item.url.absoluteString isEqual:objToRemove] == YES) {
                    
                    [activityItemsToRemove addObject:objToRemove];
                    return;
                }
            }];
        }
    }];
    
    NSMutableArray *mutableActivityItems =
    [NSMutableArray arrayWithArray:self.activityItems];

    [mutableActivityItems removeObjectsInArray:activityItemsToRemove];
    
    self.activityItems =
    [NSArray arrayWithArray:mutableActivityItems];
}

- (void)boxActivityItems {
    
    NSMutableArray *mutableActivityItems =
    [NSMutableArray array];
    
    [self.activityItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([obj isKindOfClass:[ZYInstapaperActivityItem class]] == YES) {

            [mutableActivityItems addObject:obj];
            
            return;
        }
        
        if ([obj isKindOfClass:[NSURL class]] == YES) {
            
            ZYInstapaperActivityItem *item =
            [[ZYInstapaperActivityItem alloc] initWithURL:(NSURL *)obj];
            
            [mutableActivityItems addObject:item];
            
            return;
        }
        
        if ([obj isKindOfClass:[NSString class]] == YES &&
            [NSURL URLWithString:obj] != nil) {

            NSURL *url =
            [NSURL URLWithString:(NSString *)obj];
            
            ZYInstapaperActivityItem *item =
            [[ZYInstapaperActivityItem alloc] initWithURL:url];

            [mutableActivityItems addObject:item];

            return;
        }
    }];

    self.activityItems =
    [NSArray arrayWithArray:mutableActivityItems];
}

@end
