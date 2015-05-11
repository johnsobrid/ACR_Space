//
//  skRiddumView.h
//  ACR_Space
//
//  Created by Timothy J on 8/05/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface skRiddumView : SKSpriteNode

-(id)initWithSize:(CGSize)size andColor:(UIColor *) color;

-(void)setPlaying:(bool)playing;
    

@property int myIndex;
@property BOOL isPlaying;

@end
