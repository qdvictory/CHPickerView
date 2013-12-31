//
//  CHPickerView.h
//  CHPickerViewDemo
//
//  Created by Seamus on 13-12-31.
//  Copyright (c) 2013年 Seamus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHPickerElement.h"

@interface CHPickerView : UIView <CHPickerProtocol>
{
    CHPickerElement *pick;
    CHPickerElement *mask;
    
    float maskoffset;
    float pickoffset;
    
    CHPickerDirection direction;

}
@property (assign,nonatomic) id <CHPickerProtocol> delegate;

@property (assign,nonatomic) CHPickerDirection direction;//direction default:CHPickerHorizontalDirection
@property (assign,nonatomic) float contentHeight;//one cell height
@property (assign,nonatomic) NSInteger lineCount;//how mush cell preload
@property (assign,nonatomic) float pickerStartIndex;//picker which index at first
@property (assign,nonatomic) float maskStartIndex;//top picker which index at first
@property (assign,nonatomic) int maskAtIndex;//top picker on the frame of picker
@property (strong,nonatomic) NSArray *sourceArray;//source array
@property (assign,nonatomic) CGPoint currentPointOffset;//calculate selected index offset from CGPointZero.

@property (strong,nonatomic) UIFont *maskLabelFont;//top picker font
@property (assign,nonatomic) NSTextAlignment maskLabelTextAlignment;//top picker alignment
@property (strong,nonatomic) UIColor *maskLabelTextColor;//top picker text color

@property (strong,nonatomic) UIFont *pickerLabelFont;//picker font
@property (assign,nonatomic) NSTextAlignment pickerLabelTextAlignment;//picker alignment
@property (strong,nonatomic) UIColor *pickerLabelTextColor;//picker text color
@property (assign,nonatomic) BOOL onTransform;//show transform or not. Default:NO
@property (assign,nonatomic) UIColor *pickerBackgroundColor;//picker background color
@property (assign,nonatomic) UIColor *maskBackgroundColor;//top picker background color
@end
