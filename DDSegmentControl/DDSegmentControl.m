//
//  DDSegmentControl.m
//  DDSegmentControl
//
//  Created by Alex on 15/12/29.
//  Copyright © 2015年 Alex. All rights reserved.
//

#import "DDSegmentControl.h"

@interface DDSegmentControl()

@property(nonatomic,copy) NSArray *titlesArray;
@property(nonatomic,assign) CGPoint startPoint;
@property(nonatomic,assign) CGPoint lastMovePoint;
@property(nonatomic,assign) CGPoint startSelectedViewCenter;

@property(nonatomic,strong) UIView *titlesView;
@property(nonatomic,strong) UIView *selectedView;

@property(nonatomic,strong) UIView *DDmaskView;
@property(nonatomic,strong) UIImage *maskImage;
@property(nonatomic,strong) UIView *maskColorView;


@end

@implementation DDSegmentControl



- (instancetype)initWithItems:(NSArray *)items
{
    self=[super init];
    if (self) {
        _titlesArray=items;
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self setupBase];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupUI];
}

- (void)setupBase
{
    if (!_selectedSegmentIndex) {
        _selectedSegmentIndex=0;
    }
    if (!_selectedTextColor) {
        _selectedTextColor=[UIColor whiteColor];
    }
    if (!_selectedViewColor) {
        _selectedViewColor=[UIColor blueColor];
    }
    if (!_titlesTextColor) {
        _titlesTextColor=[UIColor blackColor];
    }
    if (!_titlesArray) {
        _titlesArray=@[@"1",@"2"];
    }
    self.layer.masksToBounds=YES;
    self.userInteractionEnabled=YES;
    
}
- (void)setSelectedSegmentIndex:(NSUInteger)selectedSegmentIndex
{
    _selectedSegmentIndex=selectedSegmentIndex;
    [self sliderAnimated:NO];

}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
    _selectedTextColor=selectedTextColor;
    _maskColorView.backgroundColor=selectedTextColor;
}

- (void)setSelectedViewColor:(UIColor *)selectedViewColor
{
    _selectedViewColor=selectedViewColor;
    _selectedView.backgroundColor=selectedViewColor;
}

- (void)setTitlesTextColor:(UIColor *)titlesTextColor
{
    _titlesTextColor=titlesTextColor;
    if (_titlesView.subviews.count>0) {
        for (UIView *titleView in _titlesView.subviews) {
            if ([titleView isKindOfClass:[UILabel class]]) {
                UILabel *label=(UILabel *)titleView;
                label.textColor=titlesTextColor;
            }
           
        }
    }
}



- (void)setupUI
{
    
    CGFloat const titleWidth=self.bounds.size.width/_titlesArray.count;
    CGFloat const titleHeight=self.bounds.size.height;
    
    _selectedView=[[UIView alloc]init];
    _selectedView.frame=CGRectMake(_selectedSegmentIndex*titleWidth, 0, titleWidth, titleHeight);
    _selectedView.backgroundColor=_selectedViewColor;
    _selectedView.userInteractionEnabled=YES;
    [self addSubview:_selectedView];
    
    _titlesView=[[UIView alloc]init];
    _titlesView.frame=self.bounds;
    [self addSubview:_titlesView];
    
    for (NSUInteger i=0; i<_titlesArray.count; i++) {
        UILabel *label=[[UILabel alloc]init];
        label.frame=CGRectMake(titleWidth*i, 0, titleWidth, titleHeight);
        label.text=_titlesArray[i];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=_titlesTextColor;
        [_titlesView addSubview:label];
    }
    
    _DDmaskView=[[UIView alloc]init];
    _DDmaskView.frame=self.bounds;
    [self addSubview:_DDmaskView];
    
    _maskColorView=[[UIView alloc]init];
    _maskColorView.frame=CGRectMake(_selectedSegmentIndex*titleWidth, 0, titleWidth, titleHeight);
    _maskColorView.backgroundColor=_selectedTextColor;
    [_DDmaskView addSubview:_maskColorView];
    
    
    _maskImage=[self creatImageWithView:_titlesView];
    CALayer *maskeLayer=[CALayer layer];
    maskeLayer.frame=self.bounds;
    maskeLayer.contents=(__bridge id)(_maskImage.CGImage);
    _DDmaskView.layer.mask=maskeLayer;
    
}

- (UIImage *)creatImageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _startPoint=[[touches anyObject]locationInView:self];
    _lastMovePoint=_startPoint;
    _startSelectedViewCenter=_selectedView.center;

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _lastMovePoint=[[touches anyObject]locationInView:self];
    CGFloat offX=_lastMovePoint.x-_startPoint.x;
    CGFloat newCenterX=_startSelectedViewCenter.x+offX;
    newCenterX = MIN(newCenterX, self.bounds.size.width - _selectedView.bounds.size.width/2);
    newCenterX = MAX(newCenterX, _selectedView.bounds.size.width/2);
    
   
    CGPoint newCenter = CGPointMake(newCenterX, self.bounds.size.height/2);
  
    
    [self sliderSelectedViewToPoint:newCenter];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self sliderSelectedViewToIndex:_selectedSegmentIndex];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self sliderSelectedViewToIndex:_selectedSegmentIndex];
}


- (void)sliderSelectedViewToPoint:(CGPoint)centerPoint
{
    _selectedView.center=centerPoint;
    _maskColorView.center=centerPoint;

}

- (void)sliderSelectedViewToIndex:(NSUInteger)index
{

    NSUInteger endIndex=_lastMovePoint.x/(self.bounds.size.width/_titlesArray.count);
    
    if (endIndex!=_selectedSegmentIndex&&endIndex<_titlesArray.count) {
        _selectedSegmentIndex=endIndex;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
    
    [self sliderAnimated:YES];
    
}

- (void)sliderAnimated:(BOOL)animated
{
    CGFloat const titleWidth=self.bounds.size.width/_titlesArray.count;
    CGFloat const titleHeight=self.bounds.size.height;

    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            _selectedView.frame=CGRectMake(_selectedSegmentIndex*titleWidth, 0, titleWidth, titleHeight);
            _maskColorView.frame=CGRectMake(_selectedSegmentIndex*titleWidth, 0, titleWidth, titleHeight);
        }];
    }
    else
    {
        _selectedView.frame=CGRectMake(_selectedSegmentIndex*titleWidth, 0, titleWidth, titleHeight);
        _maskColorView.frame=CGRectMake(_selectedSegmentIndex*titleWidth, 0, titleWidth, titleHeight);
    }
}

@end
