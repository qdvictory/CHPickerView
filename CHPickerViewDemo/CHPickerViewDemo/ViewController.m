//
//  ViewController.m
//  CHPickerViewDemo
//
//  Created by Seamus on 13-12-30.
//  Copyright (c) 2013年 Seamus. All rights reserved.
//

#import "ViewController.h"
#import "CHPickerElement.h"
#import "CHPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CHPickerElement *vv = [[CHPickerElement alloc] initWithFrame:CGRectMake(180, 50, 50, 180)];
    vv.backgroundColor = [UIColor redColor];
    vv.contentHeight = 30;
    vv.lineCount = 6;
    vv.isImage = YES;
    vv.startIndex = -1;
    vv.labelFont = [UIFont systemFontOfSize:24];
//    vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
    vv.sourceArray = @[[UIImage imageNamed:@"a.png"],[UIImage imageNamed:@"a.png"],[UIImage imageNamed:@"a.png"],[UIImage imageNamed:@"a.png"],[UIImage imageNamed:@"a.png"],[UIImage imageNamed:@"a.png"]];
//    vv.labelTextColor = [UIColor redColor];
    [self.view addSubview:vv];

    {
        CHPickerElement *vv = [[CHPickerElement alloc] initWithFrame:CGRectMake(250, 50, 30, 130)];
        vv.backgroundColor = [UIColor greenColor];
        vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
        [self.view addSubview:vv];
    }
    
    {
        CHPickerElement *vv = [[CHPickerElement alloc] initWithFrame:CGRectMake(100, 350, 200, 50)];
        vv.backgroundColor = [UIColor redColor];
        vv.contentHeight = 30;
        vv.lineCount = 6;
        vv.labelFont = [UIFont systemFontOfSize:24];
        vv.onTransform = YES;
        [vv setDirection:CHPickerHorizontalDirection];
        vv.startIndex = -2;
        vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
        [self.view addSubview:vv];
    }
    
    {
        CHPickerElement *vv = [[CHPickerElement alloc] initWithFrame:CGRectMake(100, 420, 30, 30)];
        vv.backgroundColor = [UIColor redColor];
        vv.contentHeight = 30;
        vv.lineCount = 5;
        [vv setDirection:CHPickerHorizontalDirection];
        vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
        [self.view addSubview:vv];
    }
    
    {
        CHPickerView *vv = [[CHPickerView alloc] initWithFrame:CGRectMake(10, 40, 150, 80)];
        vv.direction = CHPickerHorizontalDirection;
        vv.pickerLabelTextAlignment = NSTextAlignmentCenter;
        vv.maskBackgroundColor = [UIColor greenColor];
        vv.pickerBackgroundColor = [UIColor grayColor];
        vv.maskLabelFont = [UIFont systemFontOfSize:30];
        vv.maskLabelTextAlignment = NSTextAlignmentCenter;
        vv.maskAtIndex = 2;
        vv.pickerStartIndex = -2;
        vv.delegate = self;
        vv.currentPointOffset = CGPointMake(vv.contentHeight*2,0);
        vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
        [self.view addSubview:vv];
    }
    
    {
        CHPickerView *vv = [[CHPickerView alloc] initWithFrame:CGRectMake(10, 140, 80, 150)];
        vv.direction = CHPickerVerticalDirection;
        vv.pickerLabelTextAlignment = NSTextAlignmentCenter;
        vv.maskLabelTextAlignment = NSTextAlignmentCenter;
        vv.maskAtIndex = 2;
        vv.pickerStartIndex = -2;
        vv.currentPointOffset = CGPointMake(0, vv.contentHeight*2);
        vv.onTransform = YES;
        vv.maskLabelFont = [UIFont systemFontOfSize:30];
        vv.maskBackgroundColor = [UIColor greenColor];
        vv.pickerBackgroundColor = [UIColor grayColor];
        vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
        [self.view addSubview:vv];
    }
    
    {
        CHPickerView *vv = [[CHPickerView alloc] initWithFrame:CGRectMake(10, 300, 80, 150)];
        vv.direction = CHPickerVerticalDirection;
        vv.pickerLabelTextAlignment = NSTextAlignmentCenter;
        vv.maskLabelTextAlignment = NSTextAlignmentCenter;
        vv.maskLabelFont = [UIFont systemFontOfSize:30];
        vv.maskBackgroundColor = [UIColor greenColor];
        vv.pickerBackgroundColor = [UIColor grayColor];
        vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
        [self.view addSubview:vv];
    }
}

- (void)indexDidSelected:(NSUInteger)_index
{
    NSLog(@"u selected index:%lu",(unsigned long)_index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
