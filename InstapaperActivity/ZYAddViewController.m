//
//  ZYAddViewController.m
//  InstapaperActivity
//
//  Created by Mariano Abdala on 10/1/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYAddViewController.h"
#import "ZYInstapaperActivityItem.h"
#import "ZYInstapaperAddRequest.h"

@interface ZYAddViewController () <
    ZYInstapaperAddRequestDelegate>

@property (strong, nonatomic) ZYInstapaperActivityItem *activityItem;
@property (strong, nonatomic) ZYInstapaperAddRequest *instapaperAddRequest;

- (void)initializeCancelButton;
- (void)cancelButtonTapped;
- (void)launchAddRequest;

@end

@implementation ZYAddViewController

#pragma mark - Hierarchy
#pragma mark UIViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self =
    [super initWithNibName:nibNameOrNil
                    bundle:nibBundleOrNil];
    
    if (self != nil) {
        
        self.title =
        NSLocalizedString(@"Read Later", @"");
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeCancelButton];
    [self launchAddRequest];
}

#pragma mark - Self
#pragma ZYAddViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil activityItem:(ZYInstapaperActivityItem *)activityItem {
    
    if (activityItem == nil) {
        
        return nil;
    }
    
    self =
    [self initWithNibName:nibNameOrNil
                   bundle:nibBundleOrNil];
    
    if (self != nil) {
        
        self.activityItem = activityItem;
    }
    
    return self;
}


#pragma ZYAddViewController ()
- (void)initializeCancelButton {
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"")
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(cancelButtonTapped)];
}


- (void)cancelButtonTapped {
    
    [self.instapaperAddRequest cancel];
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)launchAddRequest {

    self.instapaperAddRequest =
    [[ZYInstapaperAddRequest alloc] initWithItem:self.activityItem
                                        delegate:self];
}

#pragma mark - Protocols
#pragma mark ZYInstapaperAddRequestDelegate
- (void)instapaperAddRequestSucceded:(ZYInstapaperAddRequest *)request {
    
    //TODO: Change labels!
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)instapaperAddRequestFailed:(ZYInstapaperAddRequest *)request {
    
    //TODO: !!
}

- (void)instapaperAddRequestIncorrectPassword:(ZYInstapaperAddRequest *)request {
    
    //TODO: !!
}

@end
