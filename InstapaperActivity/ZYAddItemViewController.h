//
//  ZYAddViewController.h
//  InstapaperActivity
//
//  Created by Mariano Abdala on 10/1/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYActivityViewController.h"

@class ZYInstapaperActivityItem;

@interface ZYAddViewController : ZYActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil activityItem:(ZYInstapaperActivityItem *)activityItem;

@end
