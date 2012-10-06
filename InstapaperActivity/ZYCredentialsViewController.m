//
//  ZYCredentialsViewController.m
//  InstapaperActivity
//
//  Created by Mariano Abdala on 10/1/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import "ZYCredentialsViewController.h"
#import "ZYInstapaperActivitySecurity.h"
#import "ZYInstapaperActivityItem.h"
#import "ZYAddItemViewController.h"
#import "ZYAddItemsViewController.h"

@interface ZYCredentialsViewController () <
    UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) NSArray *activityItems;

- (void)initializeNavigationBar;
- (void)cancelButtonTapped;

@end

@implementation ZYCredentialsViewController

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
    
    [self.usernameTextField becomeFirstResponder];
}

#pragma mark - Self
#pragma mark ZYCredentialsViewController
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
    }
    
    return self;
}

#pragma mark ZYCredentialsViewController ()
- (void)initializeNavigationBar {

    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"")
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(cancelButtonTapped)];
}

- (void)cancelButtonTapped {
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - Protocols
#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (textField == self.usernameTextField) {
        
        [self.passwordTextField becomeFirstResponder];
        
    } else if (textField == self.passwordTextField) {

        ZYInstapaperActivitySecurity *security =
        [[ZYInstapaperActivitySecurity alloc] init];
        
        [security storeUsername:self.usernameTextField.text
                       password:self.passwordTextField.text];
        
        UIViewController *controller = nil;
        
        if (self.activityItems.count == 1) {
            
            ZYAddItemViewController *addItemViewController =
            [[ZYAddItemViewController alloc] initWithNibName:@"ZYAddItemViewController"
                                                      bundle:nil
                                               activityItem:self.activityItems[0]];
            
            addItemViewController.activity =
            self.activity;
            
            controller = addItemViewController;
            
        } else {
            
            ZYAddItemsViewController *addItemsViewController =
            [[ZYAddItemsViewController alloc] initWithNibName:@"ZYAddItemsViewController"
                                                       bundle:nil
                                                activityItems:self.activityItems];
            
            addItemsViewController.activity =
            self.activity;
            
            controller = addItemsViewController;
            
        }
        
        [self.navigationController pushViewController:controller
                                             animated:YES];
    }
    
    return YES;
}

@end
