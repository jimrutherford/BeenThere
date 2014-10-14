//
//  JVFloatLabeledTextField+Styles.m
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-14.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "JVFloatLabeledTextField+Styles.h"

@implementation JVFloatLabeledTextField (Styles)


- (void) applyBeenThereDarkStyle
{
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.background = [UIImage imageNamed:@"textFieldBackgroundLight"];
    
    UIView *leftPaddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, self.frame.size.height)];
    self.leftView = leftPaddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void) applyBeenThereLightStyle
{
    
}

- (void) darkStyledAttributedPlaceholder:(NSString*) placeholder
{
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    self.attributedPlaceholder = text;
}

@end
