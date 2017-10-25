//
//  HTMLMetaTag.h
//  Blip
//
//  Created by Dirceu Belém on 18/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTMLMetaTag : NSObject <NSURLSessionDelegate>

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *url;

- (instancetype)initWithUrl:(NSString*) url;

- (NSString*) getMetaTag:(NSString*) meta;

- (void)load: (void(^) (BOOL ret)) callback;

@end
