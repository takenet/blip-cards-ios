//
//  Text.h
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Document.h"

@protocol QuickReplyOptionDelegate;

@protocol QuickReplyOptionDelegate<NSObject>
@required

- (void)itemSelectedQuickReply:(id) sender andItem:(NSObject *)item andIndex: (int) index;

@end

@interface QuickReplyOption : UIView <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) UIView *parent;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (nonatomic, weak) id <QuickReplyOptionDelegate> delegate;

- (instancetype)init:(UIView*) parent andValues:(Document*) value;

@end
