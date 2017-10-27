//
//  Location.m
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "Location.h"
#import "Constants.h"
#import "BlipTapGestureRecognizer.h"
#import <MapKit/MapKit.h>

@interface Location ()
@property Document *value;
@property CGFloat maxHeight;
@end

@implementation Location

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
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

- (instancetype)initRight:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
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

- (IBAction)goToAddress:(id)sender {
    [self selectedItem:nil];
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
    UINib *nib = [UINib nibWithNibName:@"Location" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (void) loadValues{
    _name.text = _value.title;
    _time.text = _value.dateTime;
    
    NSString *url = @"https://maps.googleapis.com/maps/api/staticmap?"
        "center=%@&zoom=17&size=%@&markers=color:red|%@&scale=2&sensor=false";
    
    NSString *location = [NSString stringWithFormat:@"%@,%@", _value.latitude, _value.longitude, nil];
    NSString *size = [NSString stringWithFormat:@"%dx%d", (int)_picture.frame.size.width, (int)_picture.frame.size.height, nil];
    
    url = [NSString stringWithFormat:url, location, size, location];

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    _picture.url = url;
    
    // CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = 367;
    
//    if(width == 320){
//        height = height + 50;
//    }
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if(_value.text != nil && ![_value.text isEqualToString:@""]){
        
        _text.text = _value.text;
        
        CGRect frame = _text.frame;
        
        if(_value.title != nil) {
            height = height + 20 + frame.size.height;
        }else {
            height = height + 10 + frame.size.height;
        }
        
        if([_value.text length] > 100){
            height = height * 1.15;
        }
        
        CGRect frameView = self.frame;
        
        frameView.size.height = height;
        
        [self setFrame:frameView];
    }
    
    [_picture setUserInteractionEnabled:YES];
    
    BlipTapGestureRecognizer *tap = [[BlipTapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(selectedItem:)];
    
    [_picture addGestureRecognizer:tap];
}

-(void)selectedItem:(BlipTapGestureRecognizer*)sender {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_value.latitude doubleValue], [_value.longitude doubleValue]);
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    //[mapItem setName:[NSString stringWithFormat:@"Branch Name: %@", _shop.branch.name]];
    // Set the directions mode to "Driving"
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
    // Get the "Current User Location" MKMapItem
    MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
    // Pass the current location and destination map items to the Maps app
    [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem] launchOptions:launchOptions];
}

@end



