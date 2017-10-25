//
//  MediaPicture.m
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "MediaAudio.h"
#import "Constants.h"
#import "BlipTapGestureRecognizer.h"
#import "MediaPictureShow.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MediaAudio ()
@property Document *value;
@property CGFloat maxHeight;
@property AVAudioPlayer *player;
@property BOOL isLoad;
@property NSTimer *loop;
@end

@implementation MediaAudio

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
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

- (instancetype)initRight:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
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
    UINib *nib = [UINib nibWithNibName:@"MediaAudio" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}


- (void) loadValues{
    
    _indicator.hidden = YES;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = 116;
    
    if(width == 320){
        height = height + 50;
    }
    
    _name.text = _value.title;
    _time.text = _value.dateTime;
    _text.text = _value.text;
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    if(_value.text != nil && ![_value.text isEqualToString:@""]){
        
        CGRect frame = _text.frame;
        
        if(_value.title != nil) {
            height = height + 22 + frame.size.height;
        }else {
            height = height + frame.size.height;
        }
        
        if([_value.text length] > 100){
            height = height * 1.15;
        }
        
        CGRect frameView = self.frame;
        
        frameView.size.height = height;
        
        [self setFrame:frameView];
        
    }
}

- (IBAction)playClick:(id)sender {
    
    if(!_isLoad){
        
        _buttonPlay.hidden = YES;
        _indicator.hidden = NO;
        [_indicator startAnimating];
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            
            NSURL  *url = [NSURL URLWithString:_value.urlLink];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            
            if(urlData){
                
                _isLoad = YES;
                
                NSError *error;
                
                _player = [[AVAudioPlayer alloc] initWithData:urlData error:&error];
                [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
                [[AVAudioSession sharedInstance] setActive: YES error: nil];
                
                _player.numberOfLoops = 0;
                
                _player.delegate = self;
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                _indicator.hidden = YES;
                [_indicator stopAnimating];
                [self play];
                
                _slider.maximumValue = [_player duration];
                _slider.value = 0.0;
                [_slider setContinuous:NO];
                
                _loop = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
                
                [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
            });
        });
        
    }else{
        [self play];
    }
    
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    int value = (int)sender.value;
    
    [_player stop];
    [_player setCurrentTime:value];
    [_player play];
    
    _buttonPlay.hidden = YES;
    _buttonPause.hidden = NO;
}

-(void) updateTime: (NSTimer *) timer{
    
    NSTimeInterval currentTime = [_player currentTime];
    NSTimeInterval duration = [_player duration];
    
    _slider.value = currentTime;
    
    int time = duration - currentTime;
    
    int min = time;
    int seg = min % 60;
    min = min / 60;
    
    _timer.text = [NSString stringWithFormat:@"%d:%02d", min, seg];
    
    if(time == 0){
        _slider.value = 0;
        [_player setCurrentTime:0];
        [self pauseClick:nil];
    }
}

-(void) play{
    [_player prepareToPlay];
    [_player play];
    [_player setVolume:1];
    _buttonPlay.hidden = YES;
    _buttonPause.hidden = NO;
}

- (IBAction)pauseClick:(id)sender {
    [_player pause];
    _buttonPlay.hidden = NO;
    _buttonPause.hidden = YES;
}

@end


