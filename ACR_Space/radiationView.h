//
//  radiationView.h
//  ACR_Space
//
//  Created by Bridget Johnson on 30/04/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface radiationView : UIView

- (id)initWithFrame:(CGRect)frame
             colour:(UIColor*)col;

@property (nonatomic) UIColor * col;
- (void)setSize:(float)size;


@property BOOL isPlaying;
@property int myIndex;
@property float radiationAmount;
@property float screenHeight;

@property CGPoint myCenter;



@end
