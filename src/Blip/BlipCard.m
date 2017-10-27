//
//  BlipCard.m
//  Blip
//
//  Created by Dirceu Belém on 05/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "BlipCard.h"

@implementation BlipCard


/**
 Set the card to be displayed on the left side of the parent
 
 @param parent Parent UIView
 @return Builder
 */
- (Builder*) left: (UIView *) parent{
    return [Builder left:parent];
}

/**
 Set the card to be displayed on the right side of the parent
 
 @param parent Parent UIView
 @return Builder
 */
- (Builder*) right: (UIView *) parent{
    return [Builder right:parent];
}

/**
 Set the card to be displayed on the middle of the parent
 
 @param parent Parent UIView
 @return Builder
 */
- (Builder*) withoutSide: (UIView *) parent{
    return [Builder withoutSide:parent];
}

@end
