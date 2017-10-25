//
//  Builder.m
//  Blip
//
//  Created by Dirceu Belém on 08/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "Builder.h"
#import "MenuMultimedia.h"
#import "Document.h"
#import "Constants.h"
#import "Carousel.h"
#import "Text.h"
#import "WebLink.h"
#import "QuickReply.h"
#import "QuickReplyOption.h"
#import "ChatState.h"
#import "MediaPicture.h"
#import "MediaAudio.h"
#import "MediaDocument.h"
#import "MediaVideo.h"

@interface Builder ()

@end

@implementation Builder

@synthesize parent;

+ (Builder*) left: (UIView *) parent{
    Builder *b = [[Builder alloc] init];
    b.parent = parent;
    b.side = Left;
    return b;
}

+ (Builder*) right: (UIView *) parent{
    Builder *b = [[Builder alloc] init];
    b.parent = parent;
    b.side = Right;
    return b;
}

+ (Builder*) withoutSide: (UIView *) parent{
    Builder *b = [[Builder alloc] init];
    b.parent = parent;
    b.side = Center;
    return b;
}

- (instancetype) setDocument:(NSDictionary*) value{
    self.value = value;
    return self;
}

- (instancetype) setViewController:(UIViewController*) controller{
    self.controller = controller;
    return self;
}

- (instancetype) setDocumentValue:(Document*) value{
    self.doc = value;
    return self;
}

- (instancetype) setChatName:(NSString*) name{
    self.name = name;
    return self;
}

- (instancetype) setChatDateTime:(NSString *)dateTime{
    self.dateTime = dateTime;
    return self;
}

- (UIView*) build{
    
    NSString *type = [_value objectForKey:@"type"];
    
    if([type isEqualToString:DOCUMENT_SELECT] || _doc != nil){
        
        return [self createMenuMultimedia];
        
    } else if([type isEqualToString:CAROUSEL]){
        
        return [self createCarousel];
        
    } else if([type isEqualToString:TEXT]){
        
        return [self createText];
        
    } else if([type isEqualToString:WEB_LINK]){
        
        return [self createWebLink];
        
    } else if([type isEqualToString:CHAT_STATE]){
        
        return [self createChatState];
        
    }  else if([type isEqualToString:MEDIA_LINK]){
        
        return [self createMediaLink];
        
    }   else if([type isEqualToString:LOCATION]){
        
        return [self createLocation];
        
    } else{
        return nil;
    }
    
}

- (UIView*) createLocation {
    
    Document *document = [[Document alloc] init];
    
    document.title = self.name;
    document.dateTime = self.dateTime;
    
    NSDictionary *content = (NSDictionary*)[_value objectForKey:@"content"];
    
    document.text = [content objectForKey:@"text"];
    document.latitude = [content objectForKey:@"latitude"];
    document.longitude = [content objectForKey:@"longitude"];
    
    Location *v;
    
    if(_side == Left){
        v = [[Location alloc] initLeft:parent andValues:document];
    }else if(_side == Right){
        v = [[Location alloc] initRight:parent andValues:document];
    }
    
    return v;
}

- (UIView*) createMediaLink{
    
    Document *document = [[Document alloc] init];
    
    document.title = self.name;
    document.dateTime = self.dateTime;
    
    NSDictionary *content = (NSDictionary*)[_value objectForKey:@"content"];
    
    document.mimeType = [content objectForKey:@"type"];

    if([document.mimeType isEqualToString:@"image/jpeg"]){
        document.text = [content objectForKey:@"text"];
        document.urlLinkPreview = [content objectForKey:@"previewUri"];
        document.urlLink = [content objectForKey:@"uri"];
        
        MediaPicture *v = [[MediaPicture alloc] initLeft:parent andValues:document andViewController:_controller];
        return v;
    } else if([document.mimeType isEqualToString:@"audio/mp3"]){
        document.text = [content objectForKey:@"text"];
        document.urlLink = [content objectForKey:@"uri"];
        
        MediaAudio *v = [[MediaAudio alloc] initLeft:parent andValues:document];
        return v;
    } else if([document.mimeType isEqualToString:@"application/pdf"]){
        document.text = [content objectForKey:@"text"];
        document.size = [[content objectForKey:@"size"] integerValue];
        document.urlLink = [content objectForKey:@"uri"];
        
        MediaDocument *v = [[MediaDocument alloc] initLeft:parent andValues:document andViewController:_controller];
        return v;
    } else if([document.mimeType isEqualToString:@"video/mp4"]){
        document.text = [content objectForKey:@"text"];
        document.urlLink = [content objectForKey:@"uri"];
        document.urlLinkPreview = [content objectForKey:@"previewUri"];
        
        MediaVideo *v = [[MediaVideo alloc] initLeft:parent andValues:document andViewController:_controller];
        return v;
    } else{
        return nil;
    }
}

- (UIView*) createChatState{
    ChatState *v = [[ChatState alloc] init:parent];
    return v;
}

- (NSArray*) buildItens{
    
    NSString *type = [_value objectForKey:@"type"];
    
    if([type isEqualToString:QUICK_REPLY]){
        
        return [self createQuickReply];
        
    } else{
        return nil;
    }
    
}

- (NSArray*) createQuickReply{
    
    Document *document = [[Document alloc] init];
    
    document.title = self.name;
    document.dateTime = self.dateTime;
    
    NSDictionary *content = (NSDictionary*)[_value objectForKey:@"content"];
    
    document.text = [content objectForKey:@"text"];
    
    NSMutableArray *options = (NSMutableArray*)[content objectForKey:@"options"];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dic in options){
        [array addObject:[dic objectForKey:@"text"]];
    }
    
    document.array = array;
    
    QuickReply *v;
    
    if(_side == Left){
        v = [[QuickReply alloc] initLeft:parent andValues:document];
    }else if(_side == Right){
        v = [[QuickReply alloc] initRight:parent andValues:document];
    }
    
    QuickReplyOption *o = [[QuickReplyOption alloc] init:parent andValues:document];
    
    o.delegate = _quickReplyDelegate;
    
    NSArray *itens = [[NSMutableArray alloc] initWithObjects:v, o, nil];
    
    return itens;
}

- (UIView*) createWebLink{
    
    Document *document = [[Document alloc] init];
    
    document.title = self.name;
    document.dateTime = self.dateTime;
    
    NSDictionary *content = [_value objectForKey:@"content"];
    
    document.urlLink = [content objectForKey:@"uri"];
    document.text = [content objectForKey:@"text"];
    
    WebLink *v;
    
    if(_side == Left){
        v = [[WebLink alloc] initLeft:parent andValues:document];
    }else if(_side == Right){
        v = [[WebLink alloc] initRight:parent andValues:document];
    }
    
    return v;
}

- (UIView*) createText{
    
    Document *document = [[Document alloc] init];
    
    document.title = self.name;
    document.dateTime = self.dateTime;
    
    NSString *content = [_value objectForKey:@"content"];
    
    document.text = content;
    
    Text *v;
    
    if(_side == Left){
        v = [[Text alloc] initLeft:parent andValues:document];
    }else if(_side == Right){
        v = [[Text alloc] initRight:parent andValues:document];
    }
    
    return v;
}

- (UIView*) createCarousel {
    
    Carousel *v;
    
    Document *document = [[Document alloc] init];
    
    document.title = self.name;
    document.dateTime = self.dateTime;
    
    NSDictionary *content = [_value objectForKey:@"content"];
    
    NSMutableArray *items = [content objectForKey:@"items"];
    
    document.array = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [items count]; i++){
        
        Document *item = [[Document alloc] init];
        
        NSDictionary *header = [[items objectAtIndex:i] objectForKey:@"header"];
        
        if(header != nil) {
            NSDictionary *value = [header objectForKey:@"value"];
            
            NSString *type = (NSString*) [value objectForKey:@"type"];
            
            if([type isEqualToString:IMAGE_JPEG]){
                item.urlImage = [value objectForKey:@"uri"];
            }
            
            item.text = [value objectForKey:@"text"];
            item.subtitle = [value objectForKey:@"title"];
        }
        
        NSMutableArray *options = (NSMutableArray*) [[items objectAtIndex:i] objectForKey:@"options"];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        if (options != nil){
            
            for(int i = 0; i < [options count]; i++){
                
                NSDictionary *label = (NSDictionary*)[options objectAtIndex:i];
                label = [label objectForKey:@"label"];
                
                NSString *type = [label objectForKey:@"type"];
                
                if([type isEqualToString:TEXT_PLAIN]){
                    
                    NSString *value = [label objectForKey:@"value"];
                    [array addObject:value];
                    
                }
                
            }
            
        }
        
        item.array = array;
        
        [document.array addObject:item];
        
    }
    
    if(_side == Left){
        v = [[Carousel alloc] initLeft:parent andValues:document];
    }else if(_side == Right){
        v = [[Carousel alloc] initRight:parent andValues:document];
    }
    
    v.delegate = self.carouselDelegate;
    
    return v;
    
}

- (UIView*) createMenuMultimedia{
    
    MenuMultimedia *v;
    
    Document *doc = [[Document alloc] init];
    
    if(self.doc != nil){
        doc = self.doc;
    }else{
        
        doc.title = self.name;
        doc.dateTime = self.dateTime;
        
        NSDictionary *content = [_value objectForKey:@"content"];
        
        NSDictionary *header = [content objectForKey:@"header"];
        
        if(header != nil) {
            NSDictionary *value = [header objectForKey:@"value"];
            
            NSString *type = (NSString*) [value objectForKey:@"type"];
            
            if([type isEqualToString:IMAGE_JPEG]){
                doc.urlImage = [value objectForKey:@"uri"];
            }
            
            doc.text = [value objectForKey:@"text"];
            doc.subtitle = [value objectForKey:@"title"];
        }
        
        NSMutableArray *options = (NSMutableArray*) [content objectForKey:@"options"];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        if (options != nil){
            
            for(int i = 0; i < [options count]; i++){
                
                NSDictionary *label = (NSDictionary*)[options objectAtIndex:i];
                label = [label objectForKey:@"label"];
                
                NSString *type = [label objectForKey:@"type"];
                
                if([type isEqualToString:TEXT_PLAIN]){
                    
                    NSString *value = [label objectForKey:@"value"];
                    [array addObject:value];
                    
                }
                
            }
            
        }
        
        doc.array = array;
        
    }
    
    if(_side == Left){
        v = [[MenuMultimedia alloc] initLeft:parent andValues:doc];
    }else if(_side == Right){
        v = [[MenuMultimedia alloc] initRight:parent andValues:doc];
    }else {
        v = [[MenuMultimedia alloc] init:parent andValues:doc];
    }
    
    v.delegate = self.menuDelegate;
    
    return v;
    
}



@end
