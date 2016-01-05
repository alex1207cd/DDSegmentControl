//
//  DDSegmentControl.h
//  DDSegmentControl
//
//  Created by Alex on 15/12/29.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSegmentControl : UIControl

@property(nonatomic,assign)NSUInteger selectedSegmentIndex;
@property(nonatomic,strong)UIColor *selectedViewColor;
@property(nonatomic,strong)UIColor *selectedTextColor;
@property(nonatomic,strong)UIColor *titlesTextColor;
@property(nonatomic,readonly) NSUInteger numberOfSegments;

-(instancetype)initWithItems:(NSArray *)items;

@end
