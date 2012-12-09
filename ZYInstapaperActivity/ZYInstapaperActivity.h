//
//  ZYInstapaperActivity.h
//  ZYInstapaperActivity
//
//  Created by Mariano Abdala on 9/29/12.
//  Copyright (c) 2012 Zerously. All rights reserved.
//
//  https://github.com/marianoabdala/ZYInstapaperActivity
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "ZYActivity.h"

@interface ZYInstapaperActivity : ZYActivity

+ (ZYInstapaperActivity *)instance;

@end

//Requires at least one activity item that's a NSURL or a NSString that contains a valid URL.
//If many are found, the user will be presented with all the options and will be able to select those to act upon.
//For finer detail control, add ZYInstapaperActivityItem's to the activityItems.
