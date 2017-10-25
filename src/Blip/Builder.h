//
//  Builder.h
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MenuMultimedia.h"
#import "Document.h"
#import "Carousel.h"
#import "QuickReplyOption.h"
#import "Location.h"

@interface Builder : NSObject

typedef NS_ENUM(NSInteger, Side) {
    Left,
    Right,
    Center
};

@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIView *parent;
@property (nonatomic, assign) Side side;

@property (nonatomic, assign) NSDictionary *value;
@property (nonatomic, assign) Document *doc;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *dateTime;

@property (nonatomic, weak) id <MenuMultimediaDelegate> menuDelegate;
@property (nonatomic, weak) id <CarouselDelegate> carouselDelegate;
@property (nonatomic, weak) id <QuickReplyOptionDelegate> quickReplyDelegate;

+ (Builder*) left: (UIView *) parent;
+ (Builder*) right: (UIView *) parent;
+ (Builder*) withoutSide: (UIView *) parent;

- (UIView*) build;
- (NSArray*) buildItens;

- (instancetype) setDocument:(NSDictionary*) value;
- (instancetype) setDocumentValue:(Document*) value;
- (instancetype) setChatName:(NSString*) name;
- (instancetype) setChatDateTime:(NSString*) dateTime;
- (instancetype) setViewController:(UIViewController*) controller;

@end
