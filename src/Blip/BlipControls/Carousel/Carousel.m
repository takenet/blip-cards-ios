//
//  Carousel.m
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "Carousel.h"
#import "Constants.h"
#import "Builder.h"
#import "BlipCard.h"

@interface Carousel ()
@property Document *value;
@property CGFloat maxHeight;
@property NSMutableArray *array;
@end

@implementation Carousel

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
    CGFloat height = 490;
    
    _parent = parent;
    
    _value = value;
    
    CGRect frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, parent.frame.size.width - MARGIN_DEFAULT_SIDE, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetupLeft];
    }
    return self;
}

- (instancetype)initRight:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
    CGFloat height = 490;
    
    _parent = parent;
    
    _value = value;
    
    CGRect frame = CGRectMake(MARGIN_DEFAULT_SIDE - MARGIN_DEFAULT, MARGIN_DEFAULT,
                              parent.frame.size.width - MARGIN_DEFAULT_SIDE, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetupRight];
    }
    return self;
}

- (void)xibSetupLeft {
    UIView *view = [self loadViewFromNib];
    
    [self loadValues];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect frame = self.frame;
    frame.size.height = _maxHeight + 72;
    [self setFrame:frame];
    
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
    
}

- (void)xibSetupRight {
    UIView *view = [self loadViewFromNib];
    
    [self loadValues];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect frame = self.frame;
    frame.size.height = _maxHeight + 72;
    [self setFrame:frame];
    
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
    UINib *nib = [UINib nibWithNibName:@"Carousel" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}


- (void) loadValues{
    
    _name.text = _value.title;
    _time.text = _value.dateTime;
    
    [self createItens];
    
    self.carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.vertical = NO;
    self.carousel.pagingEnabled = YES;
    self.carousel.bounces = NO;

    self.carousel.dataSource = self;
    self.carousel.delegate = self;
    
}

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel{
    return [_array count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    return [self createView:index];
}


- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view{
    return [self createView:index];
}


- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 1;
}

-(UIView*) createView: (NSInteger) index{
    MenuMultimedia *v = (MenuMultimedia*) [_array objectAtIndex:index];
    
    v.delegate = self;
    
    return v;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0, 0.0, 1.0, 0.0);
    return CATransform3DTranslate(transform, 0.0, 0.0, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    //customize carousel display
    switch (option){
        case iCarouselOptionWrap:{
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:{
            //add a bit of spacing between the item views
            return value * 1.05;
        }
        case iCarouselOptionFadeMax:{
            if (self.carousel.type == iCarouselTypeCustom){
                //set opacity based on distance from camera
                return 0.0;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:{
            return value;
        }
    }
}

- (void) createItens{
    
    _array = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [_value.array count]; i++){
        
        Document *doc = (Document*)[_value.array objectAtIndex:i];
        
        Builder *b = [[[[BlipCard alloc] init] withoutSide:self]
                      setDocumentValue:doc];
        
        UIView *v = [b build];
        
        [_array addObject:v];
        
        if(v.frame.size.height > _maxHeight){
            _maxHeight = v.frame.size.height + (MARGIN_DEFAULT * 3);
        }
        
    }
    
}

- (void)itemSelected:(id) sender andItem:(NSObject *)item andIndex: (int) index{
    MenuMultimedia *m = (MenuMultimedia*)sender;
    
    if(_delegate != nil){
        [_delegate itemSelected:self andOption:m.value andItem:item andIndex:index];
    }
    
}

@end
