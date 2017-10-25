//
//  Text.m
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "ChatState.h"
#import "Constants.h"
#import "UIImage+animatedGIF.h"

@interface ChatState ()
@property CAShapeLayer *circleLayer1;
@property CAShapeLayer *circleLayer2;
@property CAShapeLayer *circleLayer3;
@end

@implementation ChatState


- (instancetype)init:(UIView*) parent{
    
    CGRect frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, 60, 30);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetup];
    }
    return self;
}

- (void)xibSetup {
    _viewLine = [self loadViewFromNib];
    
    [self addSubview:_viewLine];
    
    _viewLine.frame = self.bounds;
    _viewLine.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: _viewLine.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = _viewLine.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth = 2.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [_viewLine.layer addSublayer:borderLayer];
    
    
    // Drawing code
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    
    self.layer.mask = maskLayer;
    
    
    _circleLayer1 = [CAShapeLayer layer];
    [_circleLayer1 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(16, 12.5, 5, 5)] CGPath]];
    [_circleLayer1 setFillColor:[[UIColor blackColor] CGColor]];
    [[_viewLine layer] addSublayer:_circleLayer1];
    
    _circleLayer2 = [CAShapeLayer layer];
    [_circleLayer2 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(26, 12.5, 5, 5)] CGPath]];
    [_circleLayer2 setFillColor:[[UIColor blackColor] CGColor]];
    [[_viewLine layer] addSublayer:_circleLayer2];
    
    _circleLayer3 = [CAShapeLayer layer];
    [_circleLayer3 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(36, 12.5, 5, 5)] CGPath]];
    [_circleLayer3 setFillColor:[[UIColor blackColor] CGColor]];
    [[_viewLine layer] addSublayer:_circleLayer3];
    
    [self drawCircles];
    
}

- (void) drawCircles {
    
    CABasicAnimation *flash = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash.beginTime = CACurrentMediaTime() + 0;
    flash.fromValue = [NSNumber numberWithFloat:0.0];
    flash.toValue = [NSNumber numberWithFloat:1.0];
    flash.duration = 0.5;
    flash.autoreverses = YES;
    flash.repeatCount = 30000000;
    
    [_circleLayer1 addAnimation:flash forKey:@"flashAnimation"];
    
    CABasicAnimation *flash2 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash2.beginTime = CACurrentMediaTime() + 0.33;
    flash2.fromValue = [NSNumber numberWithFloat:0.0];
    flash2.toValue = [NSNumber numberWithFloat:1.0];
    flash2.duration = 0.5;
    flash2.autoreverses = YES;
    flash2.repeatCount = 30000000;
    
    [_circleLayer2 addAnimation:flash2 forKey:@"flashAnimation"];
    
    CABasicAnimation *flash3 = [CABasicAnimation animationWithKeyPath:@"opacity"];
    flash3.beginTime = CACurrentMediaTime() + 0.66;
    flash3.fromValue = [NSNumber numberWithFloat:0.0];
    flash3.toValue = [NSNumber numberWithFloat:1.0];
    flash3.duration = 0.5;
    flash3.autoreverses = YES;
    flash3.repeatCount = 30000000;
    
    [_circleLayer3 addAnimation:flash3 forKey:@"flashAnimation"];
    
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"ChatState" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

@end
