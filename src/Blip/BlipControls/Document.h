//
//  Document.h
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Document : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) NSInteger size;
@property (strong, nonatomic) NSString *dateTime;
@property (strong, nonatomic) NSString *urlImage;
@property (strong, nonatomic) NSString *urlLink;
@property (strong, nonatomic) NSString *mimeType;
@property (strong, nonatomic) NSString *urlLinkPreview;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;

@end
