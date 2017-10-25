//
//  BlipTapGestureRecognizer.h
//  Blip
//
//  Created by Dirceu Belém on 09/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlipTapGestureRecognizer : UITapGestureRecognizer

@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSObject *value;

@end
