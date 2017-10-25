//
//  MediaPictureShow.m
//  Blip
//
//  Created by Dirceu Belém on 03/10/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "MediaPictureShow.h"

@interface MediaPictureShow ()
@property NSString *urlImage;
@property CGFloat lastScale;
@end

@implementation MediaPictureShow

- (instancetype)init:(UIView*) parent andUrlImage:(NSString*) urlImage{
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    _urlImage = urlImage;
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetup];
    }
    return self;
}

- (void)xibSetup {
    _contentView = [self loadViewFromNib];
    
    _image.url = _urlImage;
    
    _scroll.maximumZoomScale = 4;
    _scroll.minimumZoomScale = 1;
    _scroll.zoomScale = 1;
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    _view.frame = frame;
    
    UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handlePinchGesture:)];
    pgr.delegate = self;
    [_image addGestureRecognizer:pgr];
    
    [self addSubview:_contentView];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)gestureRecognizer {
    
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        // Reset the last scale, necessary if there are multiple objects with different scales.
        _lastScale = [gestureRecognizer scale];
    }
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan ||
        [gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[[gestureRecognizer view].layer valueForKeyPath:@"transform.scale"] floatValue];
        
        // Constants to adjust the max/min values of zoom.
        const CGFloat kMaxScale = 2.0;
        const CGFloat kMinScale = 1.0;
        
        CGFloat newScale = 1 -  (_lastScale - [gestureRecognizer scale]); // new scale is in the range (0-1)
        newScale = MIN(newScale, kMaxScale / currentScale);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale([[gestureRecognizer view] transform], newScale, newScale);
        [gestureRecognizer view].transform = transform;
        
        _lastScale = [gestureRecognizer scale];  // Store the previous. scale factor for the next pinch gesture call
    }
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _image;
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"MediaPictureShow" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (IBAction)backClick {
    
    [self removeFromSuperview];
    
}

@end
