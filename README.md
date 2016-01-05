# DDSegmentControl
自定义颜色过渡选择器

![demo gif](https://github.com/alex1207cd/DDSegmentControl/blob/master/cd.gif?raw=true)

#使用方法
	NSArray *titlesArray=@[@"one",@"two",@"three",@"four"];
    
    DDSegmentControl *seg=[[DDSegmentControl alloc]initWithItems:titlesArray];
    seg.frame=CGRectMake(0, 0, 300, 40);
    seg.layer.borderWidth=1;
    seg.layer.cornerRadius=10;
    [seg addTarget:self action:@selector(segmentIndexChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
#
    - (void)segmentIndexChanged:(DDSegmentControl *)seg
	{
    	NSLog(@"%@",@(seg.selectedSegmentIndex));
	}
	
	
###有问题请联系本人：
###Email：59982435@qq.com
###[我的博客](www.alexcode.cn)
