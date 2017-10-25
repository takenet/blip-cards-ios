//
//  DownloadImage.h
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadImage : UIImageView {
    NSString *url;
    UIActivityIndicatorView *progress;
    NSOperationQueue *queue;
}
@property (nonatomic, copy) NSString *url;
@end
