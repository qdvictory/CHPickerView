//
//  CHPickerElement.h
//  CHPickerViewDemo
//
//  Created by Seamus on 13-12-30.
//  Copyright (c) 2013年 Seamus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHPickerElement;
@protocol CHPickerProtocol <NSObject>

@optional
- (void)indexDidSelected:(NSUInteger)_index;
- (void)pickerDidScrolling:(CHPickerElement *)_picker;

@end

typedef enum direction
{
    CHPickerHorizontalDirection,
    CHPickerVerticalDirection,
} CHPickerDirection;

#define CHPickerDirectionIsHorizontal(d) (CHPickerHorizontalDirection==d?YES:NO)
#define CHPickerDirectionIsVertical(d) (CHPickerVerticalDirection==d?YES:NO)

@interface CHPickerElement : UIView
<UIScrollViewDelegate>
{
    UIScrollView *_scrollview;
    CHPickerDirection direction;
    NSMutableArray *_contentArray;
    
    float _maxscrollheight;
    
    float _min,_max;
    
    float _centeroffset;
    
}
- (NSUInteger)indexOfCurrent:(CGPoint)p;
- (void)setContentOffset:(CGPoint)p;
- (CGPoint)contentOffset;
- (void)setPagingEnabled:(BOOL)_yes;
- (void)setContentOffset:(CGPoint)p animated:(BOOL)animated;

@property (assign,nonatomic) id<CHPickerProtocol> delegate;

@property (assign,nonatomic) CHPickerDirection direction;//direction default:CHPickerHorizontalDirection
@property (assign,nonatomic) float contentHeight;//one cell height
@property (assign,nonatomic) NSInteger lineCount;//how mush cell preload
@property (assign,nonatomic) float startIndex;//which index at first
@property (strong,nonatomic) NSArray *sourceArray;//source array

@property (strong,nonatomic) UIFont *labelFont;
@property (assign,nonatomic) NSTextAlignment labelTextAlignment;
@property (strong,nonatomic) UIColor *labelTextColor;

@property (assign,nonatomic) BOOL isImage;//if sourceArray all objects are UIImage, set isImage=Yes; Default is NO;
@property (assign,nonatomic) BOOL onTransform;
@property (assign,nonatomic) float transformValue;//transform value. Default is 1.8

@property (assign,nonatomic) CGPoint currentPointOffset;//calculate selected index offset from CGPointZero.
@property (assign,nonatomic) NSUInteger currentIndex;//selected index

@property (assign,nonatomic) float maxScrollHeight;//content max height
@end
