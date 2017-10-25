//
//  Text.h
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Document.h"

@interface ChatState : UIView

@property (weak, nonatomic) UIView *parent;

@property (weak, nonatomic) UIView *viewLine;

- (instancetype)init:(UIView*) parent;

@end
