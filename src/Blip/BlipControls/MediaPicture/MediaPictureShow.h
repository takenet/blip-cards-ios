//
//  MediaPictureShow.h
//  Blip
//
//  Created by Dirceu Belém on 03/10/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadImage.h"

@interface MediaPictureShow : UIView <UIGestureRecognizerDelegate>

- (instancetype)init:(UIView*) parent andUrlImage:(NSString*) urlImage;

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet DownloadImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

- (IBAction)backClick;

@end
