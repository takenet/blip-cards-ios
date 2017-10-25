//
//  ViewController.m
//  blip-test
//
//  Created by Dirceu Belém on 05/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property CGFloat posY;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _posY = 10;
    
    NSString *data = @"{\"id\": \"1\",\"to\": \"1042221589186385@messenger.gw.msging.net\",\"type\": \"application/vnd.lime.document-select+json\",\"content\": {\"header\": {\"type\": \"application/vnd.lime.media-link+json\",\"value\": {\"title\": \"Blip Test\",\"text\": \"Escolha uma das opções abaixo:\",\"type\": \"text/plain\"}},\"options\": [{\"label\": {\"type\": \"text/plain\",\"value\": \"Menu Multimedia\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Carousel\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Text\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"WebLink\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"QuickReply\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"ChatState\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Media Foto\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Media Áudio\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Media Document\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Media Vídeo\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Location\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}}]}}";
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[BlipCard alloc] init] left:_content]
                  setDocument:json];
    
    b.menuDelegate = self;
    
    UIView *v = [b build];
    
    [self addItem:v];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
}

- (void) addItem:(UIView *) v{
    
    UIView *item = [[UIView alloc] initWithFrame:CGRectMake(0, _posY, self.view.frame.size.width, v.frame.size.height + 20)];
    item.backgroundColor = [UIColor clearColor];
    
    [item addSubview:v];
    
    [_content addSubview:item];
    
    _posY = _posY + item.frame.size.height;
    
    _contentHeight.constant = _posY;
    
    [_content autoresizesSubviews];
    [_content layoutIfNeeded];
    
}

- (void)itemSelectedQuickReply:(id) sender andItem:(NSObject *)item andIndex: (int) index{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"BlipTest" message:(NSString*)item preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)itemSelected:(id) sender andItem:(NSObject *)item andIndex: (int) index{
    
    if ([((NSString*)item) isEqualToString:@"Menu Multimedia"]){
        
        [self createMenuMultimedia];
        
    }else if ([((NSString*)item) isEqualToString:@"Carousel"]){
        
        [self createCarousel];
        
    }else if ([((NSString*)item) isEqualToString:@"Text"]){
        
        [self createText];
        
    }else if ([((NSString*)item) isEqualToString:@"WebLink"]){
        
        [self createWebLink];
        
    }else if ([((NSString*)item) isEqualToString:@"QuickReply"]){
        
        [self createQuickReply];
        
    }else if ([((NSString*)item) isEqualToString:@"ChatState"]){
        
        [self createChatState];
        
    }else if ([((NSString*)item) isEqualToString:@"Media Foto"]){
        
        [self createMediaFoto];
        
    }else if ([((NSString*)item) isEqualToString:@"Media Áudio"]){
        
        [self createMediaAudio];
        
    }else if ([((NSString*)item) isEqualToString:@"Media Document"]){
        
        [self createMediaDocument];
        
    }else if ([((NSString*)item) isEqualToString:@"Media Vídeo"]){
        
        [self createMediaVideo];
        
    }else if ([((NSString*)item) isEqualToString:@"Location"]){
        
        [self createLocation];
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"BlipTest" message:(NSString*)item preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    [self sendToBottom];
    
}

- (void) createLocation{
    
    NSString *data = @"{\"id\": \"1\",\"to\": \"1042221589186385@messenger.gw.msging.net\",\"type\": \"application/vnd.lime.location+json\",\"content\": {\"latitude\": -19.918899,\"longitude\": -43.959275,\"altitude\": 853,\"text\": \"Take's place\"}}";
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[[[BlipCard alloc] init]
                      left:_content] setChatName:@"Blip Teste"] setChatDateTime:@"15:30"]
                   setViewController:self]
                  setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
}

- (void) createMediaVideo{
    
    NSString *data = @"{\"id\": \"2\",\"to\": \"553199991111@0mn.io\",\"type\": \"application/vnd.lime.media-link+json\",\"content\": {\"type\": \"video/mp4\",\"uri\": \"http://www.onirikal.com/videos/mp4/nestlegold.mp4\",\"size\": 3124123,\"previewUri\": \"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS8qkelB28RstsNxLi7gbrwCLsBVmobPjb5IrwKJSuqSnGX4IzX\",\"previewType\": \"image/jpeg\"}}";
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[[[BlipCard alloc] init]
                      left:_content] setChatName:@"Blip Teste"] setChatDateTime:@"15:30"]
                   setViewController:self]
                  setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
}

- (void) createMediaDocument{
    NSString *data = @"{\"id\": \"2\",\"to\": \"553199991111@0mn.io\",\"type\": \"application/vnd.lime.media-link+json\",\"content\": {\"type\": \"application/pdf\",\"uri\": \"https://s3-sa-east-1.amazonaws.com/i.imgtake.takenet.com.br/d6ztq/d6ztq.pdf\",\"size\": 3124123,\"text\": \"Document PDF\"}}";
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[[[BlipCard alloc] init]
                      left:_content] setChatName:@"Blip Teste"] setChatDateTime:@"15:30"]
                   setViewController:self]
                  setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
}

- (void) createMediaAudio{
    NSString *data = @"{\"id\": \"2\",\"to\": \"553199991111@0mn.io\",\"type\": \"application/vnd.lime.media-link+json\",\"content\": {\"type\": \"audio/mp3\",\"uri\": \"http://blaamandagjazzband.dk/jazz/mp3/basin_street_blues.mp3\",\"size\": 3124123}}";
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[[BlipCard alloc] init]
                      left:_content] setChatName:@"Blip Teste"] setChatDateTime:@"15:30"]
                  setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
}

- (void) createMediaFoto{
    NSString *data = @"{\"id\": \"1\",\"to\": \"553199991111@0mn.io\",\"type\": \"application/vnd.lime.media-link+json\",\"content\": {\"title\": \"Cat\",\"text\": \"Here is a cat image for you!\",\"type\": \"image/jpeg\",\"uri\": \"http://2.bp.blogspot.com/-pATX0YgNSFs/VP-82AQKcuI/AAAAAAAALSU/Vet9e7Qsjjw/s1600/Cat-hd-wallpapers.jpg\",\"aspectRatio\": \"1:1\",\"size\": 227791,\"previewUri\": \"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS8qkelB28RstsNxLi7gbrwCLsBVmobPjb5IrwKJSuqSnGX4IzX\",\"previewType\": \"image/jpeg\"}}";
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[[[BlipCard alloc] init]
                      left:_content] setChatName:@"Blip Teste"] setChatDateTime:@"15:30"]
                   setViewController:self]
                  setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
}

- (void) createChatState{
    
    NSString *data = @"{\"to\":\"104222@telegram.gw.msging.net\",\"type\":\"application/vnd.lime.chatstate+json\",\"content\": {\"state\": \"composing\"}}";
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[BlipCard alloc] init]
                   left:_content] setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
    
}

- (void) createQuickReply{
    
    NSString *data = @"{\"id\":\"311F87C0-F938-4FF3-991A-7C5AEF7771A5\",\"to\":\"1042221589186385@messenger.gw.msging.net\",\"type\":\"application/vnd.lime.select+json\",\"content\":{\"text\":\"Escolha uma opção\",\"options\":[{\"text\":\"Primeira opção\"},{\"order\":2,\"text\":\"Segunda opção\"},{\"order\":3,\"text\":\"Terceira opção\",\"type\":\"application/json\",\"value\":{\"key1\":\"value1\",\"key2\":2}}]}}";
    
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[BlipCard alloc] init]
                    left:_content]
                   setChatName:@"Blip Teste"]
                  setDocument:json];
    
    NSArray *vs = [b buildItens];
    
    [self addItem:[vs objectAtIndex:0]];
    
    QuickReplyOption *o = [vs objectAtIndex:1];
    
    o.delegate = self;
    
    [self addItem:o];
    
}

- (void) createWebLink{
    
    NSString *data = @"{\"id\": \"1\",\"to\": \"553199991111@0mn.io\",\"type\": \"application/vnd.lime.web-link+json\",\"content\": {\"uri\": \"http://www.uol.com.br\",\"target\": \"self\",\"text\": \"Segue documentação do web-link\"}}";
    
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[BlipCard alloc] init]
                    left:_content]
                   setChatName:@"Blip Teste"]
                  setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
    
}

- (void) createText{
    
    NSString *data = @"{\"id\": \"1\",\"to\": \"128271320123982@messenger.gw.msging.net\",\"type\": \"text/plain\",\"content\": \"Permite o envio de mensagens onde o conteúdo é um recurso armazenado no servidor. O recurso deve ser armazenado através da extensão recursos ou através do portal, no menu Recursos do chatbot. O servidor realiza automaticamente a substituição do conteúdo, caso a chave fornecida exista para o chatbot que originou a mensagem.\"}";
    
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[BlipCard alloc] init] left:_content] setChatName:@"Blip Teste"]
                  setDocument:json];
    
    UIView *v = [b build];
    
    [self addItem:v];
    
}

- (void) createMenuMultimedia {
    NSString *data = @"{\"id\": \"1\",\"to\": \"1042221589186385@messenger.gw.msging.net\",\"type\": \"application/vnd.lime.document-select+json\",\"content\": {\"header\": {\"type\": \"application/vnd.lime.media-link+json\",\"value\": {\"title\": \"Preench. de Proposta\",\"text\": \"Tire dúvidas sobre, proposta, código SMS, modelo do veículo, entre outros. \",\"type\": \"image/jpeg\",\"uri\": \"http://files.lojas.club/blip.png\",\"aspectRatio\": \"1:1\"}},\"options\": [{\"label\": {\"type\": \"text/plain\",\"value\": \"Item 1\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Item 2\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}},{\"label\": {\"type\": \"text/plain\",\"value\": \"Item 3\"},\"value\": {\"type\": \"application/json\",\"value\": {\"action\": \"show-items\"}}}]}}";
    
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[[BlipCard alloc] init] left:_content] setDocument:json] setChatName:@"Blip Teste"] setChatDateTime:@"15:30"];
    
    b.menuDelegate = self;
    
    UIView *v = [b build];
    
    [self addItem:v];
}

- (void) createCarousel {
    NSString *data = @"{\"id\":\"5\",\"to\":\"1042221589186385@messenger.gw.msging.net\",\"type\":\"application/vnd.lime.collection+json\",\"content\":{\"itemType\":\"application/vnd.lime.document-select+json\",\"items\": [{\"header\":{\"type\":\"application/vnd.lime.media-link+json\",\"value\":{\"title\":\"Preench. de Proposta 1\",\"text\":\"Tire dúvidas sobre, proposta, código SMS, modelo de veículo, entre outros\",\"type\":\"image/jpeg\",\"uri\":\"http://files.lojas.club/blip.png\"}},\"options\": [{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 1\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key1\":\"value1\",\"key2\": 2}}},{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 2\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key1\":\"value1\",\"key2\": 2}}}]},{\"header\":{\"type\":\"application/vnd.lime.media-link+json\",\"value\":{\"title\":\"Preench. de Proposta 2\",\"text\":\"Tire dúvidas sobre, proposta, código SMS, modelo de veículo, entre outros\",\"type\":\"image/jpeg\",\"uri\":\"http://files.lojas.club/blip2.png\"}},\"options\": [{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 1\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key3\":\"value3\",\"key4\": 4}}},{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 2\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key5\":\"value5\",\"key6\": 6}}}]},{\"header\":{\"type\":\"application/vnd.lime.media-link+json\",\"value\":{\"title\":\"Preench. de Proposta 1\",\"text\":\"Tire dúvidas sobre, proposta, código SMS, modelo de veículo, entre outros\",\"type\":\"image/jpeg\",\"uri\":\"http://files.lojas.club/blip.png\"}},\"options\": [{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 1\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key1\":\"value1\",\"key2\": 2}}},{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 2\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key1\":\"value1\",\"key2\": 2}}}]},{\"header\":{\"type\":\"application/vnd.lime.media-link+json\",\"value\":{\"title\":\"Preench. de Proposta 2\",\"text\":\"Tire dúvidas sobre, proposta, código SMS, modelo de veículo, entre outros\",\"type\":\"image/jpeg\",\"uri\":\"http://files.lojas.club/blip2.png\"}},\"options\": [{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 1\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key3\":\"value3\",\"key4\": 4}}},{\"label\":{\"type\":\"text/plain\",\"value\":\"Opção 2\"},\"value\":{\"type\":\"application/json\",\"value\":{\"key5\":\"value5\",\"key6\": 6}}}]}]}}";
    
    
    NSError *jsonError;
    NSData *objectData = [data dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    
    
    Builder *b = [[[[[[BlipCard alloc] init] left:_content]
                    setDocument:json] setChatName:@"Selecione um dos itens abaixo"] setChatDateTime:@"21:34"];
    
    b.carouselDelegate = self;
    
    UIView *v = [b build];
    
    [self addItem:v];
}

- (void)itemSelected:(id) sender andOption:(Document*)document andItem:(NSObject *)item andIndex: (int) index{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"BlipTest" message:(NSString*)item preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void) sendToBottom {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_scrollView scrollRectToVisible:CGRectMake(_scrollView.contentSize.width - 1, _scrollView.contentSize.height - 1, 1, 1) animated:YES];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

