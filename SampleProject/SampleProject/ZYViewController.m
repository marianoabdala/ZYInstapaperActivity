//
//  ZYViewController.m
//  SampleProject
//
//  Created by Mariano Abdala on 12/9/12.
//  Copyright (c) 2012 zerously. All rights reserved.
//

#import "ZYViewController.h"
#import "ZYInstapaperActivity.h"
#import "ZYInstapaperActivityItem.h"

@interface ZYViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) UIPopoverController *popover;

- (IBAction)shareButtonTapped:(id)sender;

@end

@implementation ZYViewController

- (IBAction)shareButtonTapped:(id)sender {
    
    NSURL *textFieldURL =
    [NSURL URLWithString:self.textField.text];
    
    ZYInstapaperActivityItem *item =
    [[ZYInstapaperActivityItem alloc] initWithURL:textFieldURL];
    
    //Actual implementation might obtain it somehow.
    //This is just to test capabilities.
    item.title = @"Fixed quotes";
    
    NSArray *activityItems =
    @[ item ];
    
    NSArray *applicationActivities =
    @[ [ZYInstapaperActivity instance] ];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                      applicationActivities:applicationActivities];
    
    //Show only Instapaper Activity.
    activityViewController.excludedActivityTypes =
    @[  UIActivityTypePostToFacebook,
    UIActivityTypePostToTwitter,
    UIActivityTypePostToWeibo,
    UIActivityTypeMessage,
    UIActivityTypeMail,
    UIActivityTypePrint,
    UIActivityTypeCopyToPasteboard,
    UIActivityTypeAssignToContact,
    UIActivityTypeSaveToCameraRoll  ];
    
    BOOL isRunningOniPhone =
    UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
    
    if (isRunningOniPhone == YES) {
        
        [self presentViewController:activityViewController
                           animated:YES
                         completion:nil];
        
    } else { //isRunnningOniPad
        
        self.popover =
        [[UIPopoverController alloc] initWithContentViewController:activityViewController];
        
        [self.popover presentPopoverFromBarButtonItem:self.shareButton
                             permittedArrowDirections:UIPopoverArrowDirectionAny
                                             animated:YES];
    }
}

@end
