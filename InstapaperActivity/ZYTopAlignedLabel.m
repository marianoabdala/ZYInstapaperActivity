//
//  ZYTopAlignedLabel.m
//  Zerously Toolkit.
//
//  Created by Mariano Abdala on 11/3/11.
//  Copyright (c) 2011 Zerously.com. All rights reserved.
//
// https://github.com/marianoabdala/Zerously-toolkit

#import "ZYTopAlignedLabel.h"

@interface ZYTopAlignedLabel ()

@property (nonatomic, unsafe_unretained) CGRect originalFrame;

@end

@implementation ZYTopAlignedLabel

@synthesize originalFrame = _originalFrame;

#pragma mark - Hierarchy
#pragma mark NSObject
- (id)initWithFrame:(CGRect)frame {

    self =
    [super initWithFrame:frame];
    
    if (self != nil) {
        
        self.originalFrame = frame;
    }
    
    return self;
}

#pragma mark UIView
- (void)awakeFromNib {
    
    self.originalFrame =
    self.frame;
}

#pragma mark UILabel
- (void)setText:(NSString *)text {
 
    [super setText:text];
    
    self.frame =
    self.originalFrame;
    
    CGSize newSize =
    [self.text sizeWithFont:self.font
          constrainedToSize:self.frame.size
              lineBreakMode:self.lineBreakMode];
    
    CGRect newFrame =
    CGRectMake(self.frame.origin.x,
               self.frame.origin.y,
               self.frame.size.width,
               newSize.height);
    
    self.frame =
    newFrame;
}

#pragma mark - Self
#pragma mark ZYTopAlignedLabel

#pragma mark ZYTopAlignedLabel ()

@end
