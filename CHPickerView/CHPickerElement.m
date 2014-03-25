//
//  CHPickerElement.m
//  CHPickerViewDemo
//
//  Created by Seamus on 13-12-30.
//  Copyright (c) 2013年 Seamus. All rights reserved.
//

#import "CHPickerElement.h"
#import <QuartzCore/QuartzCore.h>

@implementation CHPickerElement
@synthesize direction;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        
        self.contentHeight = 30;
        self.lineCount = 5;
        self.startIndex = 0;
        self.transformValue = 1.8;
        self.currentPointOffset = CGPointZero;
        _maxscrollheight = 3000;
        
        
        _contentArray = [[NSMutableArray alloc] init];
        
        _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_scrollview];
        [_scrollview setContentSize:CGSizeMake(self.frame.size.width, _maxscrollheight)];
        [self setDirection:CHPickerVerticalDirection];
        [_scrollview setShowsHorizontalScrollIndicator:NO];
        [_scrollview setShowsVerticalScrollIndicator:NO];
        
    }
    return self;
}

- (void)setPagingEnabled:(BOOL)_yes
{
    [_scrollview setPagingEnabled:YES];
}

- (void)setDirection:(CHPickerDirection)_direction
{
    direction = _direction;
    if (CHPickerDirectionIsHorizontal(direction)) {
        [_scrollview setContentSize:CGSizeMake(_maxscrollheight, self.frame.size.height)];
    }
    else
    {
        [_scrollview setContentSize:CGSizeMake(self.frame.size.width, _maxscrollheight)];
    }
    
}
- (void)setContentOffset:(CGPoint)p animated:(BOOL)animated
{
    [_scrollview setContentOffset:p animated:animated];
}

- (void)setContentOffset:(CGPoint)p
{
    _scrollview.contentOffset = p;
}

- (CGPoint)contentOffset
{
    return _scrollview.contentOffset;
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(pickerDidScrolling:)]) {
        [self.delegate pickerDidScrolling:self];
    }
    
    float scrolloffset = [self.sourceArray count]*self.contentHeight;
    if (CHPickerDirectionIsHorizontal(direction)) {
        float offset = scrollView.contentOffset.x;
//        NSLog(@"%f,min:%f,max:%f",offset,_min,_max);
        if (offset < 500) {
            scrollView.contentOffset=CGPointMake(offset+scrolloffset,0);
            _min=_max=_min+scrolloffset;
            [self removeAllContent];
        }
        else if (offset > _maxscrollheight-500)
        {
            scrollView.contentOffset = CGPointMake(offset-scrolloffset,0);
            _min=_max=_max-scrolloffset;
            [self removeAllContent];
        }
    }
    else
    {
        float offset = scrollView.contentOffset.y;
//        NSLog(@"%f",offset);
        if (offset < 500) {
            scrollView.contentOffset=CGPointMake(0, offset+scrolloffset);
            _min=_max=_min+scrolloffset;
            [self removeAllContent];
        }
        else if (offset > _maxscrollheight-500)
        {
            scrollView.contentOffset = CGPointMake(0, offset-scrolloffset);
            _min=_max=_max-scrolloffset;
            [self removeAllContent];
        }
    }
    
    [self addContentIfNeed];
    [self removeContentIfNeed];
    
    [self transformContent];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.pagingEnabled && !decelerate) {
//        NSLog(@"%ld",[self indexOfCurrent:scrollView.contentOffset]);
        self.currentIndex = [self indexOfCurrent:scrollView.contentOffset];
        
        if ([self.delegate respondsToSelector:@selector(indexDidSelected:)]) {
            [self.delegate indexDidSelected:self.currentIndex];
        }
    }
    
    if (!scrollView.pagingEnabled && !decelerate)
    {
        [self pageScrollview];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"%ld",[self indexOfCurrent:scrollView.contentOffset]);
    
    if (!scrollView.pagingEnabled) {
        [self pageScrollview];
    }
    else
    {
        self.currentIndex = [self indexOfCurrent:scrollView.contentOffset];
        
        if ([self.delegate respondsToSelector:@selector(indexDidSelected:)]) {
            [self.delegate indexDidSelected:self.currentIndex];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    self.currentIndex = [self indexOfCurrent:scrollView.contentOffset];
    
    if ([self.delegate respondsToSelector:@selector(indexDidSelected:)]) {
        [self.delegate indexDidSelected:self.currentIndex];
    }
}

#pragma mark -
- (void)pageScrollview
{
    if (CHPickerDirectionIsHorizontal(direction) && (_scrollview.contentOffset.x)/self.contentHeight!=0) {
        float c = (_scrollview.contentOffset.x)/self.contentHeight;
        c = c-(int)(c) > 0.5 ? (int)c+1 : (int)c;
        [_scrollview setContentOffset:CGPointMake((int)((_scrollview.contentOffset.x)/self.contentHeight)*self.contentHeight, 0) animated:YES];
    
    }
    else if (!CHPickerDirectionIsHorizontal(direction) && (_scrollview.contentOffset.y)/self.contentHeight!=0)
    {
        float c = ((_scrollview.contentOffset.y)/self.contentHeight);
        c = c-(int)(c) > 0.5 ? (int)c+1 : (int)c;
        [_scrollview setContentOffset:CGPointMake(0, c*self.contentHeight) animated:YES];
        
    }
}

- (NSUInteger)indexOfCurrent:(CGPoint)p
{
    for (UIView *l in _contentArray) {
        if (CGRectContainsPoint(l.frame, CGPointMake(p.x+self.currentPointOffset.x+l.frame.size.width/2, p.y+self.currentPointOffset.y+l.frame.size.height/2))) {
//            NSLog(@"%@,%@",NSStringFromCGRect(l.frame),NSStringFromCGPoint(p));
            return l.tag;
        }
    }
    return NSNotFound;
}

#pragma mark -
- (UIView *)contentView:(CGRect)frame
{
    if (self.isImage) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:frame];
        return img;
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:frame];
    lab.backgroundColor = [UIColor clearColor];
    lab.userInteractionEnabled = NO;
    if (self.labelTextAlignment) {
        lab.textAlignment = self.labelTextAlignment;
    }
    else
    {
        lab.textAlignment = NSTextAlignmentCenter;
    }
    if (self.labelFont) {
        lab.font = self.labelFont;
    }
    if (self.labelTextColor) {
        lab.textColor = self.labelTextColor;
    }
    return lab;
}

- (UIView *)minView:(float)_m
{
    CGRect frame;
    if (CHPickerDirectionIsHorizontal(direction))
    {
        frame = CGRectMake(_m, 0, self.contentHeight, self.frame.size.height);
    }
    else
    {
        frame = CGRectMake(0, _m, self.frame.size.width, self.contentHeight);
    }
    
    UIView *l = [self contentView:frame];
    
    return l;
}

- (UIView *)maxView:(float)_m
{
    CGRect frame;
    if (CHPickerDirectionIsHorizontal(direction))
    {
        frame = CGRectMake(_m, 0, self.contentHeight, self.frame.size.height);
    }
    else
    {
        frame = CGRectMake(0, _m, self.frame.size.width, self.contentHeight);
    }
    
    UIView *l = [self contentView:frame];
    
    return l;
}

#pragma mark -
- (void)addContentIfNeed
{
    float _offset;
    if (CHPickerDirectionIsHorizontal(direction))
    {
        _offset = _scrollview.contentOffset.x;
    }
    else
    {
        _offset = _scrollview.contentOffset.y;
    }
    
    if (_min == _max) {
        
        UIView *l = [self minView:_min];
        if (self.isImage) {
            ((UIImageView *)l).image = [self.sourceArray objectAtIndex:0];
        }
        else
        {
            ((UILabel *)l).text = [self.sourceArray objectAtIndex:0];
        }
        l.tag = 0;
//        l.backgroundColor = [UIColor blackColor];
        [_contentArray addObject:l];
        [_scrollview addSubview:l];
        
//        _min = _offset;
        _max += self.contentHeight;
//        _min -= self.contentHeight/2;
//        _max += self.contentHeight/2;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            while (_min > _offset-self.contentHeight*self.lineCount) {
                UIView *l = [self minView:_min-self.contentHeight];
                [_contentArray insertObject:l atIndex:0];
                [_scrollview addSubview:l];
                long index = [self.sourceArray count]-1-((int)((_centeroffset-_min)/self.contentHeight)%([self.sourceArray count]));
                if (self.isImage) {
                    ((UIImageView *)l).image = [self.sourceArray objectAtIndex:index];
                }
                else
                {
                    ((UILabel *)l).text = [self.sourceArray objectAtIndex:index];
                }
                l.tag = index;
                
                _min -= self.contentHeight;
            }
        });
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            while (_max < _offset+self.contentHeight*self.lineCount) {
                
                UIView *l = [self maxView:_max];
                [_contentArray addObject:l];
                [_scrollview addSubview:l];
                long index = (int)((_max-_centeroffset)/self.contentHeight)%([self.sourceArray count]);
                if (self.isImage) {
                    ((UIImageView *)l).image = [self.sourceArray objectAtIndex:index];
                }
                else
                {
                    ((UILabel *)l).text = [self.sourceArray objectAtIndex:index];
                }
                l.tag = index;
                
                _max += self.contentHeight;
                
            }
        });
    });
}

- (void)removeAllContent
{
    for (UIView *l in _contentArray) {
        [l removeFromSuperview];
    }
    [_contentArray removeAllObjects];
//    [[_scrollview subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)removeContentIfNeed
{
    NSMutableArray *_arr = [_contentArray copy];
    for (UIView *l in _arr) {
        float _y = (CHPickerDirectionIsHorizontal(direction)?([l frame].origin.x):([l frame].origin.y));
        
        float offset = CHPickerDirectionIsHorizontal(direction)?_scrollview.contentOffset.x:_scrollview.contentOffset.y;
        
        if (fabs(_y-offset) > self.contentHeight*self.lineCount) {
            if (_y-offset < 0) {
                _min += self.contentHeight;
            }
            else
            {
                _max -= self.contentHeight;
            }
            [l removeFromSuperview];
            [_contentArray removeObject:l];
        }
    }
    _arr = nil;
}

- (void)transformContent
{
    static int i = 0;
    i++;
    if (i < 20) {
        return;
    }
    i = 0;
    
    if (self.onTransform) {
        if (CHPickerDirectionIsHorizontal(direction)) {
            float center = _scrollview.contentOffset.x+self.frame.size.width/2;
            for (UIView *view in _contentArray) {
                CATransform3D rotationTransform = CATransform3DIdentity;
                [self.layer removeAllAnimations];
                float angle = -(center-view.center.x)/self.frame.size.width*self.transformValue;
//                NSLog(@"%f",angle);
                rotationTransform = CATransform3DRotate(rotationTransform, angle, 0.0, 1, 0);
                view.layer.transform = rotationTransform;
            }
        }
        else
        {
            float center = _scrollview.contentOffset.y+self.frame.size.height/2;
            for (UIView *view in _contentArray) {
                CATransform3D rotationTransform = CATransform3DIdentity;
                [self.layer removeAllAnimations];
                float angle = (center-view.center.y)/self.frame.size.height*self.transformValue;
//                NSLog(@"%f",angle);
                rotationTransform = CATransform3DRotate(rotationTransform, angle, 1, 0, 0);
                view.layer.transform = rotationTransform;
            }
        }
        
    }
}

#pragma mark -
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
//    NSLog(@"%d",((int)(_maxscrollheight)/(int)(self.contentHeight)));
    _centeroffset = ((int)(_maxscrollheight)/(int)(self.contentHeight))/2*self.contentHeight;
//    float offset = _maxscrollheight/2-self.contentHeight/2;
    _min = _centeroffset;
    _max = _centeroffset;
    
    if (self.onTransform) {
        if (CHPickerDirectionIsHorizontal(direction)) {
            _scrollview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 1);
        }
        else
        {
            _scrollview.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 0.8);
        }
        
    }
    
    [_scrollview setDelegate:self];
    if (CHPickerDirectionIsHorizontal(direction)) {
        [_scrollview setContentOffset:CGPointMake(_centeroffset+self.startIndex*self.contentHeight, 0)];
    }
    else
    {
        [_scrollview setContentOffset:CGPointMake(0, _centeroffset+self.startIndex*self.contentHeight)];
    }
    
}

- (void)dealloc
{
    self.delegate = nil;
    self.labelFont = nil;
    self.labelTextColor = nil;
    self.sourceArray = nil;
    [_contentArray removeAllObjects];
    _contentArray = nil;
    _scrollview = nil;
}
@end
