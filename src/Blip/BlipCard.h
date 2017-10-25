//
//  BlipCard.h
//  Blip
//
//  Created by Dirceu Belém on 05/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Builder.h"


@interface BlipCard : NSObject

- (Builder*) left: (UIView *) parent;
- (Builder*) right: (UIView *) parent;
- (Builder*) withoutSide: (UIView *) parent;

@end
