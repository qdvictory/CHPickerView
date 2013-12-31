This repositories contains two parts.

`CHPickerView` is ios7 style picker on ios5.    
`CHPickerElement` is infint scrollview.

Both of them can support horizontal and vertical.

It's easy to use.


	CHPickerElement *vv = [[CHPickerElement alloc] initWithFrame:CGRectMake(250, 50, 30, 130)];
	vv.backgroundColor = [UIColor greenColor];
	vv.sourceArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"];
	[self.view addSubview:vv];


or 

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
        
you can see more in the demo.

<img width=50% src="preview.gif">

more info: [go to my blog](http://minroad.com)
