//
//  BlipCard.m
//  Blip
//
//  Created by Dirceu Belém on 05/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "BlipCard.h"

@implementation BlipCard

- (Builder*) left: (UIView *) parent{
    return [Builder left:parent];
}

- (Builder*) right: (UIView *) parent{
    return [Builder right:parent];
}

- (Builder*) withoutSide: (UIView *) parent{
    return [Builder withoutSide:parent];
}

@end
