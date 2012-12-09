//
//  ZYtemsSelectorViewController.m
//  ZYInstapaperActivity
//
//  Created by Mariano Abdala on 10/6/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYAddItemsViewController.h"

@interface ZYAddItemsViewController () <
    UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *activityItems;
@property (strong, nonatomic) NSMutableArray *selectedActivityItems;

- (void)initializeNavigationBar;
- (void)cancelButtonTapped;
- (void)saveButtonTapped;

@end

@implementation ZYAddItemsViewController

#pragma mark - Self
#pragma mark ZYtemsSelectorViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil activityItems:(NSArray *)activityItems {
    
    if (activityItems == nil) {
        
        return nil;
    }
    
    if (activityItems.count == 0) {
        
        return nil;
    }
    
    self =
    [self initWithNibName:nibNameOrNil
                   bundle:nibBundleOrNil];
    
    if (self != nil) {
        
        self.activityItems = activityItems;
        
        [self initializeNavigationBar];
    }
    
    return self;
}

#pragma mark ZYtemsSelectorViewController ()
- (void)initializeNavigationBar {
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"")
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(cancelButtonTapped)];
    
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Save", @"")
                                     style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(saveButtonTapped)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancelButtonTapped {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (void)saveButtonTapped {

    //Save!
}

@end
