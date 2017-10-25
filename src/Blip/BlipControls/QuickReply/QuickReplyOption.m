//
//  Text.m
//  Blip
//
//  Created by Dirceu Belém on 16/09/17.
//  Copyright © 2017 blip.ai. All rights reserved.
//

#import "QuickReplyOption.h"
#import "Constants.h"
#import "QuickReplyOptionCollectionViewCell.h"
#import "BlipTapGestureRecognizer.h"

@interface QuickReplyOption ()
@property Document *value;
@property CGFloat maxHeight;
@end

@implementation QuickReplyOption

@synthesize collection;


- (instancetype)init:(UIView*) parent andValues:(Document*) value{
    
    _maxHeight = 0;
    
    CGFloat height = 70;
    
    _parent = parent;
    
    _value = value;
    
    CGRect frame = CGRectMake(MARGIN_DEFAULT, MARGIN_DEFAULT, parent.frame.size.width - MARGIN_DEFAULT, height);
    
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetup];
    }
    return self;
}

- (void)xibSetup {
    UIView *view = [self loadViewFromNib];
    view.frame = self.bounds;
    view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self addSubview:view];
    [self loadValues];
}

- (UIView *)loadViewFromNib {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"QuickReplyOption" bundle:bundle];
    UIView *view = [[nib instantiateWithOwner:self options:nil] firstObject];
    return view;
}

- (void) loadValues{
    
    [collection registerClass:[QuickReplyOptionCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
    [collection reloadData];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _value.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QuickReplyOptionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    NSString *option = (NSString*)[_value.array objectAtIndex:indexPath.row];
    
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UIView *view = [[UIView alloc] init];
    
    CGRect frame = cell.bounds;
    frame.size.height = 50;
    frame.size.width = 160;
    
    frame.origin.y = 10;
    
    view.frame = frame;
    [view setClipsToBounds:YES];
    [view setBackgroundColor:[UIColor whiteColor]];
    view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: view.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight) cornerRadii:CGSizeMake(20.0, 20.0)];
    
    
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.frame = view.bounds;
    borderLayer.path  = maskPath.CGPath;
    borderLayer.lineWidth = 2.0f;
    borderLayer.strokeColor = [UIColor colorWithRed:103.0f/255.0f green:195.0f/255.0f blue:215.0f/255.0f alpha:1.0f].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    [view.layer addSublayer:borderLayer];
    
    
    // Drawing code
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect: view.bounds byRoundingCorners: UIRectCornerTopLeft |
                      UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: (CGSize){20.0, 20.0}].CGPath;
    
    view.layer.mask = maskLayer;
    
    
    
    UILabel *textOption = [[UILabel alloc] init];
    textOption.frame = view.bounds;
    textOption.text = option;
    textOption.numberOfLines = 0;
    textOption.textColor = [UIColor colorWithRed:103.0f/255.0f green:195.0f/255.0f blue:215.0f/255.0f alpha:1.0f];
    [textOption setFont:[UIFont fontWithName:@"Helvetica Neue" size:14]];
    [textOption setTextAlignment:NSTextAlignmentCenter];
    
    [view addSubview:textOption];
    
    [view setUserInteractionEnabled:YES];
    
    BlipTapGestureRecognizer *tap = [[BlipTapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(selectedItem:)];
    
    tap.index = (int)indexPath.row;
    tap.value = option;
    
    [view addGestureRecognizer:tap];
    
    [textOption setUserInteractionEnabled:YES];

    BlipTapGestureRecognizer *tap2 = [[BlipTapGestureRecognizer alloc]
                                     initWithTarget:self
                                     action:@selector(selectedItem:)];
    
    tap2.index = (int)indexPath.row;
    tap2.value = option;
    
    
    [textOption addGestureRecognizer:tap2];

    
    
    [cell addSubview:view];
    
    return cell;
}

-(void)selectedItem:(BlipTapGestureRecognizer*)sender {
    
    if(_delegate != nil){
        [_delegate itemSelectedQuickReply:self andItem:sender.value andIndex:sender.index];
    }
    
}

@end
