//
//  CHPickerView.m
//  CHPickerViewDemo
//
//  Created by Seamus on 13-12-31.
//  Copyright (c) 2013年 Seamus. All rights reserved.
//

#import "CHPickerView.h"

@implementation CHPickerView
@synthesize direction;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.contentHeight = 30;
    }
    return self;
}


#pragma mark -
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    pick = [[CHPickerElement alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    if (CHPickerDirectionIsHorizontal(direction)) {
        mask = [[CHPickerElement alloc] initWithFrame:CGRectMake(0+self.maskAtIndex*self.contentHeight, 0, self.contentHeight, self.frame.size.height)];
    }
    else
    {
        mask = [[CHPickerElement alloc] initWithFrame:CGRectMake(0, self.maskAtIndex*self.contentHeight, self.frame.size.width, self.contentHeight)];
    }
    
    pick.direction = mask.direction = self.direction;
    
    if (self.sourceArray) {
        pick.sourceArray = mask.sourceArray = self.sourceArray;
    }
    
    if (self.contentHeight) {
        pick.contentHeight = mask.contentHeight = self.contentHeight;
    }
    if (self.lineCount) {
        pick.lineCount = mask.lineCount = self.lineCount;
    }
    if (self.pickerStartIndex) {
        pick.startIndex = self.pickerStartIndex;
    }
    if (self.maskStartIndex) {
        mask.startIndex = self.maskStartIndex;
    }
    if (self.pickerLabelFont) {
        pick.labelFont = self.pickerLabelFont;
    }
    if (self.maskLabelFont) {
        mask.labelFont = self.maskLabelFont;
    }
    if (self.pickerLabelTextAlignment) {
        pick.labelTextAlignment = self.pickerLabelTextAlignment;
    }
    if (self.maskLabelTextAlignment) {
        mask.labelTextAlignment = self.maskLabelTextAlignment;
    }
    if (self.pickerLabelTextColor) {
        pick.labelTextColor = self.pickerLabelTextColor;
    }
    if (self.maskLabelTextColor) {
        mask.labelTextColor = self.maskLabelTextColor;
    }
    if (!CGPointEqualToPoint(self.currentPointOffset,CGPointZero)) {
        pick.currentPointOffset = self.currentPointOffset;
    }
    
    
    pick.onTransform = self.onTransform;
    [mask setPagingEnabled:YES];
    
    [self addSubview:pick];
    [self addSubview:mask];
    
    mask.userInteractionEnabled = NO;
    pick.delegate = self;
    
    if (self.pickerBackgroundColor) {
        pick.backgroundColor = self.pickerBackgroundColor;
    }
    if (self.maskBackgroundColor) {
        mask.backgroundColor = self.maskBackgroundColor;
    }
}

#pragma mark - picker delegate
- (void)indexDidSelected:(NSUInteger)_index
{
    if ([self.delegate respondsToSelector:@selector(indexDidSelected:)]) {
        [self.delegate indexDidSelected:_index];
    }
}

- (void)pickerDidScrolling:(CHPickerElement *)_picker
{
//    if (CHPickerDirectionIsHorizontal(self.direction) && [_picker isEqual:mask]) {
//        if (maskoffset != 0) {
//            float offset = maskoffset-_picker.contentOffset.x;
//            [pick setContentOffset:CGPointMake([pick contentOffset].x-offset, 0)];
//            
//        }
//        maskoffset = _picker.contentOffset.x;
//    }

    if (CHPickerDirectionIsHorizontal(self.direction))
    {
        if (pickoffset != 0) {
            float offset = pickoffset-_picker.contentOffset.x;
            [mask setContentOffset:CGPointMake([mask contentOffset].x-offset, 0)];
            
        }
        pickoffset = _picker.contentOffset.x;
    }
    else
    {
        if (pickoffset != 0) {
            float offset = pickoffset-_picker.contentOffset.y;
            [mask setContentOffset:CGPointMake(0, [mask contentOffset].y-offset)];
            
        }
        pickoffset = _picker.contentOffset.y;
    }
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    [super hitTest:point withEvent:event];
//    return self;
//}

@end
