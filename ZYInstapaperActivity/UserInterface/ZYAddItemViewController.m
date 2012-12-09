//
//  ZYAddItemViewController.m
//  ZYInstapaperActivity
//
//  Created by Mariano Abdala on 10/1/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYAddItemViewController.h"
#import "ZYInstapaperActivityItem.h"
#import "ZYInstapaperAddRequest.h"
#import "ZYCredentialsViewController.h"
#import "ZYTopAlignedLabel.h"

#define FAST_DISMISS_DELAY  0.5f
#define SLOW_DISMISS_DELAY  1.0f

@interface ZYAddItemViewController () <
    ZYInstapaperAddRequestDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet ZYTopAlignedLabel *urlLabel;
@property (strong, nonatomic) ZYInstapaperActivityItem *activityItem;
@property (strong, nonatomic) ZYInstapaperAddRequest *instapaperAddRequest;

- (void)initializeNavigationBar;
- (void)initializeItemDetails;
- (void)cancelButtonTapped;
- (void)launchAddRequest;
- (void)dismiss;

@end

@implementation ZYAddItemViewController

#pragma mark - Hierarchy
#pragma mark UIViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self =
    [super initWithNibName:nibNameOrNil
                    bundle:nibBundleOrNil];
    
    if (self != nil) {
        
        self.title =
        NSLocalizedString(@"Read Later", @"");
        
        [self initializeNavigationBar];
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeItemDetails];
    [self launchAddRequest];
}

#pragma mark - Self
#pragma ZYAddItemViewController
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

#pragma ZYAddItemViewController ()
- (void)initializeNavigationBar {
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"")
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(cancelButtonTapped)];
}

- (void)initializeItemDetails {
    
    if (self.activityItem.title != nil) {
        
        self.titleLabel.text =
        self.activityItem.title;

        self.urlLabel.text =
        self.activityItem.url.absoluteString;
    }
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

- (void)dismiss {
 
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Protocols
#pragma mark ZYInstapaperAddRequestDelegate
- (void)instapaperAddRequestSucceded:(ZYInstapaperAddRequest *)request {
    
    self.statusLabel.text =
    NSLocalizedString(@"Done!", @"");
    
    [self.activityIndicatorView stopAnimating];

    [self performSelector:@selector(dismiss)
               withObject:nil
               afterDelay:FAST_DISMISS_DELAY];
}

- (void)instapaperAddRequestFailed:(ZYInstapaperAddRequest *)request {
    
    self.statusLabel.text =
    NSLocalizedString(@"Error, try again later.", @"");
    
    self.titleLabel.text = nil;
    self.urlLabel.text = nil;
    
    [self.activityIndicatorView stopAnimating];

    [self performSelector:@selector(dismiss)
               withObject:nil
               afterDelay:SLOW_DISMISS_DELAY];
}

- (void)instapaperAddRequestIncorrectPassword:(ZYInstapaperAddRequest *)request {
    
    ZYCredentialsViewController *credentialsViewController =
    [[ZYCredentialsViewController alloc] initWithNibName:@"ZYCredentialsViewController"
                                                  bundle:nil
                                           activityItems:@ [ self.activityItem ]];
    
    credentialsViewController.activity =
    self.activity;
    
    [self.navigationController pushViewController:credentialsViewController
                                         animated:YES];
}

@end
