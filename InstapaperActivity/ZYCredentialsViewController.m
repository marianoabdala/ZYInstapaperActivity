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
#import "ZYAddViewController.h"

@interface ZYCredentialsViewController () <
    UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) ZYInstapaperActivityItem *activityItem;

- (void)initializeCancelButton;
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
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeCancelButton];
    [self.usernameTextField becomeFirstResponder];
}

#pragma mark - Self
#pragma mark ZYCredentialsViewController
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

#pragma mark ZYCredentialsViewController ()
- (void)initializeCancelButton {

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
        
        
        ZYAddViewController *addViewController =
        [[ZYAddViewController alloc] initWithNibName:@"ZYAddViewController"
                                              bundle:nil
                                        activityItem:self.activityItem];
        
        addViewController.activity =
        self.activity;
        
        [self.navigationController pushViewController:addViewController
                                             animated:YES];
    }
    
    return YES;
}

@end
