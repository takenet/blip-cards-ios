//
//  MediaVideo.m
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "MediaVideo.h"
#import "Constants.h"
#import "BlipTapGestureRecognizer.h"
//#import "MediaPictureShow.h"

@interface MediaVideo ()
@property Document *value;
@property CGFloat maxHeight;
@end

@implementation MediaVideo

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value andViewController: (UIViewController*) controller{
    
    _maxHeight = 0;
    
    _controller = controller;
    
    CGFloat height = 298;
    
    _parent = parent;
    
    _value = value;
    
    if(_value.title != nil){
        [_name setHidden:NO];
    }else{
        [_name setHidden:YES];
    }
    
    CGRect frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, parent.frame.size.width - MARGIN_DEFAULT_SIDE, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetupLeft];
    }
    return self;
}

- (instancetype)initRight:(UIView*) parent andValues:(Document*) value andViewController: (UIViewController*) controller{
    
    _maxHeight = 0;
    
    _controller = controller;
    
    CGFloat height = 298;
    
    _parent = parent;
    
    _value = value;
    
    if(_value.title != nil){
        [_name setHidden:NO];
    }else{
        [_name setHidden:YES];
    }
    
    CGRect frame = CGRectMake(MARGIN_DEFAULT_SIDE - MARGIN_DEFAULT, MARGIN_DEFAULT,
                              parent.frame.size.width - MARGIN_DEFAULT_SIDE, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetupRight];
    }
    return self;
}

- (void)xibSetupLeft {
    _viewLine = [self loadViewFromNib];    
    
    [self addSubview:_viewLine];
    
    [self loadValues];
    
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
}

- (void)xibSetupRight {
    
    _viewLine = [self loadViewFromNib];
    
    [self addSubview:_viewLine];
    
    [self loadValues];
    
    _viewLine.frame = self.bounds;
    _viewLine.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: _viewLine.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = _viewLine.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth = 2.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [_viewLine.layer addSublayer:borderLayer];
    
    // Drawing code
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    
    self.layer.mask = maskLayer;
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"MediaVideo" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (void) loadValues{
    _name.text = _value.title;
    _time.text = _value.dateTime;
    _picture.url = _value.urlLinkPreview;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = 365;
    
    if(width == 320){
        height = height + 50;
    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if(_value.text != nil && ![_value.text isEqualToString:@""]){
        
        _text.text = _value.text;
        
        CGRect frame = _text.frame;
        
        if(_value.title != nil) {
            height = height + 52 + frame.size.height;
        }else {
            height = height + 36 + frame.size.height;
        }
        
        if([_value.text length] > 100){
            height = height * 1.15;
        }
        
        CGRect frameView = self.frame;
        
        frameView.size.height = height;
        
        [self setFrame:frameView];
    }
    
}

- (IBAction)playClick:(id)sender {
    
    NSURL *videoURL = [NSURL URLWithString:_value.urlLink];
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    controller.player = player;

    [_controller presentViewController:controller animated:NO completion:nil];

    [player play];
    
}

@end


