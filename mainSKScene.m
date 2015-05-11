//
//  mainSKScene.m
//  ACR_Space
//
//  Created by Timothy J on 8/05/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "mainSKScene.h"
#import "skRiddumView.h"

@implementation mainSKScene{
    skRiddumView * riddum;
    
}

-(id)initWithSize:(CGSize)size{
    
    self = [super initWithSize:size];
    
    self.backgroundColor = [UIColor blueColor];
    
    CGSize riddumSize = CGSizeMake(80, 80);
    riddum = [[skRiddumView alloc]initWithSize:riddumSize andColor:[UIColor orangeColor]];
    [riddum setPosition:CGPointMake(size.width/2.0, size.height/2.0)];
    [self addChild:riddum];

    return self;
}

@end
