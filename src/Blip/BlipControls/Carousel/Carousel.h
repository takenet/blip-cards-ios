//
//  Carousel.h
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadImage.h"
#import "Document.h"
#import "MenuMultimedia.h"
#import "iCarousel.h"


@protocol CarouselDelegate;

@protocol CarouselDelegate<NSObject>
@required

- (void)itemSelected:(id) sender andOption:(Document*)document andItem:(NSObject *)item andIndex: (int) index;

@end

@interface Carousel : UIView <iCarouselDataSource, iCarouselDelegate, MenuMultimediaDelegate>

@property (weak, nonatomic) UIView *parent;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet iCarousel *carousel;


@property (nonatomic, weak) id <CarouselDelegate> delegate;


- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value;
- (instancetype)initRight:(UIView*) parent andValues:(Document*) value;

@end
