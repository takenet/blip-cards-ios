//
//  DownloadImage.m
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "DownloadImage.h"

#import "DownloadImage.h"

@implementation DownloadImage
@synthesize url;

#define LOG_ON FALSE

- (id)initWithFrame:(CGRect)rect {
    if (self = [super initWithFrame:rect]) {
        progress = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:progress];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        progress = [[UIActivityIndicatorView alloc]
                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:progress];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    progress.center = [self convertPoint:self.center fromView:self.superview];
}

- (void)setUrl:(NSString *)urlParam {
    if (!urlParam || [urlParam length] == 0) {
        url = nil;
        self.image = nil;
    }
    else if (urlParam != self.url) {
        url = [urlParam copy];
        self.image = nil;
        if (!queue) {
            queue = [[NSOperationQueue alloc] init];
        }
        [queue cancelAllOperations];
        [progress startAnimating];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self selector:@selector(downloadImg) object:nil];
        [queue addOperation:operation];
    }
}

- (void)downloadImg {
    // Cria caminho do arquivo para salvar a img em cache
    
    //CriptografiaHelper *cript = [[CriptografiaHelper alloc] init];
    
    NSString* file = [url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    file = [file stringByReplacingOccurrencesOfString:@"\\" withString:@"_"];
    file = [file stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    
    //file = [[cript sha1:file] stringByAppendingString:@".png"];
    
    file = [@"/Documents/" stringByAppendingString:file];
    file = [NSHomeDirectory() stringByAppendingString:[NSString stringWithString:file]];
    
    
    if (LOG_ON) {
        NSLog(@"Download URL %@", url);
    }
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *img = [[UIImage alloc] initWithData:data];
//    img = [self imageCrop:img andCGRect:[self frame]];
    
    data = UIImagePNGRepresentation(img);
    
    [self performSelectorOnMainThread:@selector(showImg:) withObject:img waitUntilDone:YES];
    
}

- (void)showImg:(UIImage *)imagem {
    self.image = imagem;
    [progress stopAnimating];
}

- (UIImage*) imageCrop: (UIImage*) image andCGRect: (CGRect) rect{
    CGSize centerSquareSize;
    double oriImgWid = CGImageGetWidth(image.CGImage);
    double oriImgHgt = CGImageGetHeight(image.CGImage);
    NSLog(@"oriImgWid==[%.1f], oriImgHgt==[%.1f]", oriImgWid, oriImgHgt);
    if(oriImgHgt <= oriImgWid) {
        centerSquareSize.width = oriImgHgt;
        centerSquareSize.height = oriImgHgt;
    }else {
        centerSquareSize.width = oriImgWid;
        centerSquareSize.height = oriImgWid;
    }
    
    NSLog(@"squareWid==[%.1f], squareHgt==[%.1f]", centerSquareSize.width, centerSquareSize.height);
    
    double x = (oriImgWid - centerSquareSize.width) / 2.0;
    double y = (oriImgHgt - centerSquareSize.height) / 2.0;
    NSLog(@"x==[%.1f], x==[%.1f]", x, y);
    
    CGRect cropRect = CGRectMake(x, y, centerSquareSize.height, centerSquareSize.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    
    return cropped;
}

- (UIImage*) imageCrop4: (UIImage*) image andCGRect: (CGRect) rect{
    //- (UIImage *)imageByCroppingImage:(UIImage *)image toSize:(CGSize)size
    
    // not equivalent to image.size (which depends on the imageOrientation)!
    double refWidth = CGImageGetWidth(image.CGImage);
    double refHeight = CGImageGetHeight(image.CGImage);
    
    double x = (refWidth - rect.size.width) / 2.0;
    double y = (refHeight - rect.size.height) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, rect.size.height, rect.size.width);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UIImage*) imageCrop3: (UIImage*) image andCGRect: (CGRect) rect{
    UIGraphicsBeginImageContextWithOptions(rect.size, false, [image scale]);
    [image drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    UIImage *cropped_image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return cropped_image;
}

@end
