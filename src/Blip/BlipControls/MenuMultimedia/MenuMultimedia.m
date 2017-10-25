//
//  MenuMultimedia.m
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "MenuMultimedia.h"
#import "BlipTapGestureRecognizer.h"
#import "Constants.h"

@interface MenuMultimedia ()

@end

@implementation MenuMultimedia

- (instancetype)init:(UIView*) parent andValues:(Document*) value{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = HEIGHT_DEFAULT;
    
    _parent = parent;
    
    _value = value;
    
    if(_value.urlImage == nil){
        height = height - HEIGHT_IMAGE;
        if(_value.title != nil || _value.dateTime != nil){
            height = height - 25;
        }
    }else{
        if(_value.title == nil && _value.dateTime == nil){
            height = height + 15;
            if(width == 320){
                height = height + 17;
            }
        }
    }
    
    if(_value.array != nil && [_value.array count] > 0){
        height = height + (HEIGHT_OPTION * [_value.array count]);
    }
    
    if(_value.title == nil && _value.dateTime == nil){
        height = height - 50;
    }
    
    if([_value.text length] > 40){
        height = height + 15;
        if(width == 320){
            height = height + 17;
        }
    }
    
    CGRect frame = CGRectMake(0, 0, parent.frame.size.width - (MARGIN_DEFAULT * 5), height);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetup];
    }
    return self;
    
}

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value{
    
    CGFloat height = HEIGHT_DEFAULT;
    
    _parent = parent;
    
    _value = value;
    
    if(_value.urlImage == nil){
        height = height - HEIGHT_IMAGE;
        if(_value.title != nil || _value.dateTime != nil){
            height = height - 25;
        }
    }else{
        if(_value.title == nil && _value.dateTime == nil){
            height = height + 15;
        }
    }
    
    if(_value.array != nil && [_value.array count] > 0){
        height = height + (HEIGHT_OPTION * [_value.array count]);
    }
    
    if(_value.title == nil && _value.dateTime == nil){
        height = height - 50;
    }
    
    if([_value.text length] > 40){
        height = height + 15;
    }
    
    CGRect frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, parent.frame.size.width - MARGIN_DEFAULT_SIDE, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetupLeft];
    }
    return self;
}

- (instancetype)initRight:(UIView*) parent andValues:(Document*) value{
    
    CGFloat height = HEIGHT_DEFAULT;
    
    _value = value;
    
    if(_value.urlImage == nil){
        height = height - HEIGHT_IMAGE;
        if(_value.title != nil || _value.dateTime != nil){
            height = height - 25;
        }
    }else{
        if(_value.title == nil && _value.dateTime == nil){
            height = height + 15;
        }
    }
    
    if(_value.array != nil && [_value.array count] > 0){
        height = height + (HEIGHT_OPTION * [_value.array count]);
    }
    
    if(_value.title == nil && _value.dateTime == nil){
        height = height - 50;
    }
    
    if([_value.text length] > 40){
        height = height + 15;
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
    UIView *view = [self loadViewFromNib];
    view.frame = self.bounds;
    view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: view.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = view.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth = 2.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [view.layer addSublayer:borderLayer];
    
    
    // Drawing code
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    
    self.layer.mask = maskLayer;
    
    [self addSubview:view];
    
    [self loadValues];
    
}

- (void)xibSetupRight {
    UIView *view = [self loadViewFromNib];
    view.frame = self.bounds;
    view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: view.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
    
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = view.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth = 2.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [view.layer addSublayer:borderLayer];
    
    
    // Drawing code
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners: UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){10.0, 10.0}].CGPath;
    
    self.layer.mask = maskLayer;
    
    [self addSubview:view];
    
    [self loadValues];
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"MenuMultimedia" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (void) loadValues{
    _image.url = _value.urlImage;
    _title.text = _value.title;
    _subtitle.text = _value.subtitle;
    _text.text = _value.text;
    _time.text = _value.dateTime;
    
    if(_value.urlImage == nil){
        _heightImage.constant = 0;
        _image.hidden = YES;
        _dist1.constant = 40;
        _dist2.constant = 0;
    }
    
    if(_value.title == nil && _value.dateTime == nil){
        _dist1.constant = 15;
    }
    
    if(_value.array != nil && [_value.array count] > 0){
        [self addItens];
    }
}

- (void) addItens{
    
    CGFloat yLabel = 0;
    CGFloat yLine = HEIGHT_OPTION;
    
    for(int i = 0; i < [_value.array count]; i++) {
        
        UILabel *textOption = [[UILabel alloc] initWithFrame:CGRectMake(20, yLabel, self.viewItens.frame.size.width - 40, HEIGHT_OPTION - 1)];
        textOption.text = (NSString*) [_value.array objectAtIndex:i];
        textOption.numberOfLines = 0;
        textOption.textColor = [UIColor colorWithRed:42.0f/255.0f green:180.0f/255.0f blue:179.0f/255.0f alpha:1.0f];
        [textOption setFont:[UIFont fontWithName:@"Helvetica Neue" size:13]];
        
        
        [textOption setTextAlignment:NSTextAlignmentLeft];
        [self.viewItens addSubview:textOption];
        
        if (i < [_value.array count] - 1){
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, yLine, self.viewItens.frame.size.width, 1)];
            line.backgroundColor = [UIColor colorWithRed:215.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0f];
            
            [self.viewItens addSubview:line];
            
            yLabel = yLabel + HEIGHT_OPTION;
            yLine = yLine + HEIGHT_OPTION;
            
        }
        
        BlipTapGestureRecognizer *tap = [[BlipTapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(selectedItem:)];
        
        tap.index = i;
        tap.value = [_value.array objectAtIndex:i];
        
        [textOption addGestureRecognizer:tap];
        
        [textOption setUserInteractionEnabled:YES];
        
    }
}

-(void)selectedItem:(BlipTapGestureRecognizer*)sender {
    
    if(_delegate != nil){
        [_delegate itemSelected:self andItem:sender.value andIndex:sender.index];
    }
    
}


@end
