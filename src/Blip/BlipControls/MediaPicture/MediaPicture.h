//
//  MediaPicture.h
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Document.h"
#import "DownloadImage.h"

@interface MediaPicture : UIView

@property (weak, nonatomic) UIView *parent;
@property (weak, nonatomic) UIView *viewLine;
@property (nonatomic, strong) UIViewController *controller;

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet DownloadImage *picture;

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value andViewController: (UIViewController*) controller;
- (instancetype)initRight:(UIView*) parent andValues:(Document*) value andViewController: (UIViewController*) controller;

@end

