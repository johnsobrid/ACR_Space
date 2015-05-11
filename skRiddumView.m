//
//  skRiddumView.m
//  ACR_Space
//
//  Created by Timothy J on 8/05/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "skRiddumView.h"

@implementation skRiddumView{
    CGPoint touchOffset;
}

-(id)initWithSize:(CGSize)size andColor:(UIColor *) color{
    self = [super initWithColor:[UIColor clearColor] size:size];
    
    CGRect circle = CGRectMake(-size.width/2.0, -size.height/2.0, size.width, size.height);
    SKShapeNode *shapeNode = [[SKShapeNode alloc] init];
    shapeNode.path = [UIBezierPath bezierPathWithOvalInRect:circle].CGPath;
    shapeNode.fillColor = color;
    shapeNode.lineWidth = 1.0;
    [self addChild:shapeNode];
    
    [self setUserInteractionEnabled:true];
    
    [self setAnchorPoint:CGPointMake(0.5, 0.5)];
    
    return self;
}

-(void)setPlaying:(bool)playing{
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    touchOffset = [[touches anyObject] locationInNode:self];
   // NSLog(@"Offset is (%f,%f)",offset.x,offset.y);
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGPoint positionInParent = [[touches anyObject] locationInNode:self.parent];
    CGPoint positionToMoveTo;
    positionToMoveTo.x = positionInParent.x - touchOffset.x;
    positionToMoveTo.y = positionInParent.y - touchOffset.y;
    [self setPosition:positionToMoveTo];
}

@end
