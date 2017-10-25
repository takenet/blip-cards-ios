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


@protocol MenuMultimediaDelegate;

@protocol MenuMultimediaDelegate<NSObject>
@required

- (void)itemSelected:(id) sender andItem:(NSObject *)item andIndex: (int) index;

@end

@interface MenuMultimedia : UIView

@property (weak, nonatomic) UIView *parent;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet DownloadImage *image;

@property (weak, nonatomic) Document *value;

@property (weak, nonatomic) IBOutlet UIView *viewItens;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dist1;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dist2;

@property (nonatomic, weak) id <MenuMultimediaDelegate> delegate;


- (instancetype)init:(UIView*) parent andValues:(Document*) value;
- (instancetype)initLeft:(UIView*) parent andValues:(Document*) value;
- (instancetype)initRight:(UIView*) parent andValues:(Document*) value;

@end
