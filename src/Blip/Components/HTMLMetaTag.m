//
//  HTMLMetaTag.m
//  Blip
//
//  Created by Dirceu Belém on 18/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "HTMLMetaTag.h"

@implementation HTMLMetaTag

- (void)load: (void(^) (BOOL ret)) callback {
    
    //    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    //
    //    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    //
    //    NSURLSessionDownloadTask *getImageTask = [session downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]];
        _content = [[NSString alloc] initWithData:data
                                         encoding:NSUTF8StringEncoding];
        
        _content = [self getHead:_content];
        
        callback(YES);
        
    });
    //    }];
    
}

- (instancetype)initWithUrl:(NSString*) url {
    self = [super init];
    
    self.url = url;
    
    //    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    //    NSString* html = [[NSString alloc] initWithData:data
    //                                           encoding:NSUTF8StringEncoding];
    //
    //    _content = html;
    //
    //    _content = [self getHead:_content];
    //
    return self;
}

- (NSString*) getHead: (NSString*) htmlCode {
    
    NSString *startPoint = @"<head";
    NSString *endPoint = @"</head>";
    
    NSRange startRange = [htmlCode rangeOfString:startPoint];
    NSRange endRange = [htmlCode rangeOfString:endPoint];
    
    NSString *head = [htmlCode substringWithRange:NSMakeRange(startRange.location + startRange.length, endRange.location)];
    
    head = [head stringByReplacingOccurrencesOfString:@"  "
                                           withString:@" "];
    
    return head;
}


- (NSString*) getMetaTag:(NSString*) meta{
    
    @try {
        NSString *startPoint = [NSString stringWithFormat:@"<meta property=\"%@\"", meta];
        NSString *endPoint = @"/>";
        
        NSRange startRange = [_content rangeOfString:startPoint];
        
        if(startRange.location < NSIntegerMax){
            
            NSRange endRange = [_content rangeOfString:endPoint];
            
            NSString *value = [_content substringWithRange:NSMakeRange(startRange.location + startRange.length, endRange.location)];
            
            value = [self getContent:value];
            
            return value;
            
        }else{
            return @"";
        }
    } @catch (NSException *exception) {
        return @"";
    }
    
}


- (NSString*) getContent: (NSString*) htmlCode {
    
    @try {
        
        NSString *startPoint = @"content=\"";
        NSString *endPoint = @"/>";
        
        NSRange startRange = [htmlCode rangeOfString:startPoint];
        
        if(startRange.location < NSIntegerMax){
            
            NSRange endRange = [htmlCode rangeOfString:endPoint];
            
            NSString *value = [htmlCode substringWithRange:NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.length - endPoint.length)];
            
            return value;
            
        }else{
            return @"";
        }
        
    } @catch (NSException *exception) {
        return @"";
    }
}


@end
