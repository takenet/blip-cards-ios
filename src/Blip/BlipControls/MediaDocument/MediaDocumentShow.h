//
//  MediaPictureShow.h
//  Blip
//
//  Created by Dirceu Belém on 03/10/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediaDocumentShow : UIView <UIScrollViewDelegate>

- (instancetype)init:(UIView*) parent andNSData:(NSData*) data andMimeType: (NSString*) mimeType;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIView *view;

- (IBAction)backClick;

@end

