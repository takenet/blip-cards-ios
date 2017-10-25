//
//  MediaAudio.h
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Document.h"
#import <AVFoundation/AVFoundation.h>

@interface MediaAudio : UIView <AVAudioPlayerDelegate>

@property (weak, nonatomic) UIView *parent;
@property (weak, nonatomic) UIView *viewLine;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *text;

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value;
- (instancetype)initRight:(UIView*) parent andValues:(Document*) value;

@property (weak, nonatomic) IBOutlet UIButton *buttonPlay;
@property (weak, nonatomic) IBOutlet UIButton *buttonPause;

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *timer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)playClick:(id)sender;
- (IBAction)pauseClick:(id)sender;



@end


