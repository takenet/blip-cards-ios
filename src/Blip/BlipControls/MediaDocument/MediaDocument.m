//
//  MediaPicture.m
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "MediaDocument.h"
#import "Constants.h"
#import "BlipTapGestureRecognizer.h"
#import "MediaDocumentShow.h"

@interface MediaDocument ()
@property Document *value;
@property CGFloat maxHeight;
@property NSData *document;
@end

@implementation MediaDocument


- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value andViewController: (UIViewController*) controller{
    
    _maxHeight = 0;
    
    _controller = controller;
    
    CGFloat height = 106;
    
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
    
    CGFloat height = 106;
    
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
    UINib *nib = [UINib nibWithNibName:@"MediaDocument" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}


- (void) loadValues{
    _indicator.hidden = YES;
    
    _name.text = _value.title;
    _time.text = _value.dateTime;
    _documentType.text = _value.text;
    
    double size =  (((double)_value.size) / 1024.0 / 1024.0);
    
    _documentSize.text = [NSString stringWithFormat:@"%.2f MB", size];
}

- (IBAction)downloadClick:(id)sender {
    if(!_document){

        _downloadButton.hidden = YES;
        _indicator.hidden = NO;
        [_indicator startAnimating];

        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){

            NSURL *url = [NSURL URLWithString:_value.urlLink];
            _document = [NSData dataWithContentsOfURL:url];

            dispatch_async(dispatch_get_main_queue(), ^(void){
                _indicator.hidden = YES;
                _downloadButton.hidden = NO;
                [_indicator stopAnimating];
                if(_document){
                    [self showDocument];
                }
            });
        });

    }else{
        [self showDocument];
    }
}

- (void) showDocument{
    MediaDocumentShow *v = [[MediaDocumentShow alloc] init:_controller.view andNSData:_document andMimeType:@"application/pdf"];
    [_controller.view addSubview:v];
}

@end


