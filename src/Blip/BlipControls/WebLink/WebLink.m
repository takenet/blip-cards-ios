//
//  MenuMultimedia.m
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "WebLink.h"
#import "BlipTapGestureRecognizer.h"
#import "Constants.h"
#import "HTMLMetaTag.h"

@interface WebLink ()
@property CGFloat maxHeight;
@end

@implementation WebLink

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
    CGFloat height = 200;
    
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

- (instancetype)initRight:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
    CGFloat height = 200;
    
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

- (void)xibSetup {
    UIView *view = [self loadViewFromNib];
    view.frame = self.bounds;
    view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: view.bounds byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = view.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth = 2.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [view.layer addSublayer:borderLayer];
    
    
    // Drawing code
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    
    self.layer.mask = maskLayer;
    
    [self addSubview:view];
    
    [self loadValues];
    
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
    UINib *nib = [UINib nibWithNibName:@"WebLink" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (void) loadValues{
    
    CGFloat height = 210;
    
    _name.text = _value.title;
    _text.text = _value.text;
    _time.text = _value.dateTime;
    
    HTMLMetaTag *meta = [[HTMLMetaTag alloc] initWithUrl:_value.urlLink];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect frame = _text.frame;
    
    if(_value.title != nil) {
        height = height + frame.size.height;
    }else {
        height = height + frame.size.height;
    }
    
    if([_value.text length] > 100){
        height = height * 1.15;
    }
    
    CGRect frameView = self.frame;
    
    frameView.size.height = height;
    
    [self setFrame:frameView];
    
    BlipTapGestureRecognizer *tap = [[BlipTapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(selectedItem:)];
    
    tap.value = _value;
    
    [self addGestureRecognizer:tap];
    
    [meta load:^(BOOL ret) {
        
        if(ret){
            
            NSString *imageUrl = [meta getMetaTag:@"og:image"];
            NSString *title = [meta getMetaTag:@"og:title"];
            NSString *descrition = [meta getMetaTag:@"og:description"];
            
            if(![imageUrl isEqualToString:@""]){
                _image.url = imageUrl;
            }
            
            if(![title isEqualToString:@""]){
                _titleWeb.text = title;
            }
            
            if(![descrition isEqualToString:@""]){
                _textWeb.text = descrition;
            }
            
        }
        
    }];
    
    
}

-(void)selectedItem:(BlipTapGestureRecognizer*)sender {
    
    Document *value = (Document*)sender.value;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:value.urlLink]];
    
}




@end
