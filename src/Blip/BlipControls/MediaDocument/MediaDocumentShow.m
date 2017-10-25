//
//  MediaPictureShow.m
//  Blip
//
//  Created by Dirceu Belém on 03/10/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "MediaDocumentShow.h"

@interface MediaDocumentShow ()
@property NSData *data;
@property UIView *contentView;
@property NSString *mimeType;
@end

@implementation MediaDocumentShow

- (instancetype)init:(UIView*) parent andNSData:(NSData*) data andMimeType: (NSString*) mimeType{
    
    _data = data;
    _mimeType = mimeType;
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    _view.frame = frame;
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetup];
    }
    return self;
}

- (void)xibSetup {
    _contentView = [self loadViewFromNib];
    
    NSURL *url = nil;
    
    [_webView setScalesPageToFit:YES];
    [_webView loadData:_data MIMEType: _mimeType textEncodingName: @"UTF-8" baseURL:url];
//    [self.webView.scrollView setZoomScale:0.5 animated:YES];
    
//    _webView.scrollView.delegate = self; // set delegate method of UISrollView
//    _webView.scrollView.maximumZoomScale = 20; // set as you want.
//    _webView.scrollView.minimumZoomScale = 1; // set as you want.
//    _webView.scrollView.zoomScale = 2;
//    _webView.scrollView.zoomScale = 1;
    
    [self addSubview:_contentView];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale{
    _webView.scrollView.maximumZoomScale = 20; // set similar to previous.
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"MediaDocumentShow" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (IBAction)backClick {
    
    [self removeFromSuperview];
    
}

@end

