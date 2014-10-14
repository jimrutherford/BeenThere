//
//  JVFloatLabeledTextField+Styles.h
//  BeenThere
//
//  Created by Jim Rutherford on 2014-10-14.
//  Copyright (c) 2014 Taptonics. All rights reserved.
//

#import "JVFloatLabeledTextField.h"

@interface JVFloatLabeledTextField (Styles)

- (void) applyBeenThereDarkStyle;
- (void) applyBeenThereLightStyle;

- (void) darkStyledAttributedPlaceholder:(NSString*) placeholder;

@end
