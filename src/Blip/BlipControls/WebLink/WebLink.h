//
//  MenuMultimedia.h
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadImage.h"
#import "Document.h"


@interface WebLink : UIView 

@property (weak, nonatomic) UIView *parent;

@property (weak, nonatomic) UIView *viewLine;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet DownloadImage *image;

@property (weak, nonatomic) IBOutlet UILabel *titleWeb;
@property (weak, nonatomic) IBOutlet UILabel *textWeb;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webContentHeight;
@property (weak, nonatomic) IBOutlet UIView *webContent;

@property (weak, nonatomic) Document *value;

- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value;
- (instancetype)initRight:(UIView*) parent andValues:(Document*) value;

@end
