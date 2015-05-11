//
//  gameScene.m
//  ACR_Space
//
//  Created by Timothy J on 8/05/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "gameSceneViewController.h"
#import "mainSKScene.h"

@implementation gameSceneViewController

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    mainSKScene *scene = [[mainSKScene alloc] initWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    //[scene setPosition:CGPointZero];
    
    [self.mainSpriteKitView presentScene:scene];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
