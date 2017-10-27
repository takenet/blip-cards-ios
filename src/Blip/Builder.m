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

/**
 Set the card to be displayed on the left side of the parent

 @param parent Parent UIView
 @return Builder
 */
+ (Builder*) left: (UIView *) parent{
    Builder *b = [[Builder alloc] init];
    b.parent = parent;
    b.side = Left;
    return b;
}

/**
 Set the card to be displayed on the right side of the parent
 
 @param parent Parent UIView
 @return Builder
 */
+ (Builder*) right: (UIView *) parent{
    Builder *b = [[Builder alloc] init];
    b.parent = parent;
    b.side = Right;
    return b;
}

/**
 Set the card to be displayed on the middle of the parent
 
 @param parent Parent UIView
 @return Builder
 */
+ (Builder*) withoutSide: (UIView *) parent{
    Builder *b = [[Builder alloc] init];
    b.parent = parent;
    b.side = Center;
    return b;
}

/**
 Set the message JSON used to create the card

 @param value Dictionary conteining the message JSON
 @return Builder
 */
- (instancetype) setDocument:(NSDictionary*) value{
    self.value = value;
    return self;
}

/**
 Set the controller that will be card

 @param controller Controller that will contain the card
 @return Builder
 */
- (instancetype) setViewController:(UIViewController*) controller{
    self.controller = controller;
    return self;
}

/**
 Set the message Document used to create the card

 @param value Document conteining the message JSON
 @return Builder
 */
- (instancetype) setDocumentValue:(Document*) value{
    self.doc = value;
    return self;
}

/**
 Set the name that will be displayed on the card

 @param name String with name
 @return Builder
 */
- (instancetype) setChatName:(NSString*) name{
    self.name = name;
    return self;
}

/**
 Set the dateTime that will be displayed with the card

 @param dateTime String with the DateTime
 @return Builder
 */
- (instancetype) setChatDateTime:(NSString *) dateTime{
    self.dateTime = dateTime;
    return self;
}

/**
 Build the card with the setted paramiters

 @return UIView with the card
 */
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

/**
 Create a Location Card from the self.value Dictionary

 @return UIView with the card
 */
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

/**
 Create a MediaLink Card from the self.value Dictionary
 
 @return UIView with the card
 */
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

/**
 Create a ChatState from the self.value Dictionary
 
 @return UIView with the card
 */
- (UIView*) createChatState{
    ChatState *v = [[ChatState alloc] init:parent];
    return v;
}

/**
 Create the QuickReply itens from the self.value Dictionary
 
 @return UIView with the card
 */
- (NSArray*) buildItens{
    
    NSString *type = [_value objectForKey:@"type"];
    
    if([type isEqualToString:QUICK_REPLY]){
        
        return [self createQuickReply];
        
    } else{
        return nil;
    }
    
}

/**
 Create a Quick Reply Card from the self.value Dictionary
 
 @return UIView with the card
 */
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

/**
 Create a WebLink Card from the self.value Dictionary
 
 @return UIView with the card
 */
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

/**
 Create a Text Card from the self.value Dictionary
 
 @return UIView with the card
 */
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

/**
 Create a Carousel Card from the self.value Dictionary
 
 @return UIView with the card
 */
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

/**
 Create a Menu Multimedia Card from the self.value Dictionary
 
 @return UIView with the card
 */
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
