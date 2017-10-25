//
//  MediaVideo.h
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Document.h"
#import "DownloadImage.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface Location : UIView

@property (weak, nonatomic) UIView *parent;
@property (weak, nonatomic) UIView *viewLine;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet DownloadImage *picture;

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value;
- (instancetype)initRight:(UIView*) parent andValues:(Document*) value;
- (IBAction)goToAddress:(id)sender;

@end



