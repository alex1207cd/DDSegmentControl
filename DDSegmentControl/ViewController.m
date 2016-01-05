//
//  ViewController.m
//  DDSegmentControl
//
//  Created by Alex on 15/12/28.
//  Copyright © 2015年 Alex. All rights reserved.
//

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "DDSegmentControl.h"

@interface ViewController ()<UIScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *titlesArray=@[@"one",@"two",@"three",@"four"];
    
    DDSegmentControl *seg=[[DDSegmentControl alloc]initWithItems:titlesArray];
    seg.frame=CGRectMake(0, 0, 300, 40);
    seg.layer.borderWidth=1;
    seg.layer.cornerRadius=10;
    [seg addTarget:self action:@selector(segmentIndexChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    
    seg.center=self.view.center;

}

- (void)segmentIndexChanged:(DDSegmentControl *)seg
{
    NSLog(@"%@",@(seg.selectedSegmentIndex));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
