//
//  ViewController.h
//  blip-test
//
//  Created by Dirceu Belém on 05/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Blip/BlipCard.h>
#import <Blip/Builder.h>


@interface ViewController : UIViewController <MenuMultimediaDelegate, CarouselDelegate, QuickReplyOptionDelegate>

@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end

