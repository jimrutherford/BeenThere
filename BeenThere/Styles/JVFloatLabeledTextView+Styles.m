//
//  JVFloatLabeledTextView+Styles.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-22.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "JVFloatLabeledTextView+Styles.h"

@implementation JVFloatLabeledTextView (Styles)

- (void) applyBeenThereLightStyle
{
    self.textColor = [UIColor btDeepGrayColor];
    self.backgroundColor = [UIColor clearColor];
    
    //self.background = [UIImage imageNamed:@"textFieldBackgroundDark"];
    
    //UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    //self.leftView = leftPaddingView;
    //self.leftViewMode = UITextFieldViewModeAlways;
}


- (void) lightStyledAttributedPlaceholder:(NSString*) placeholder
{
    self.placeholder = placeholder;
    self.placeholderTextColor = [UIColor btMediumGrayColor];
    
}

@end
