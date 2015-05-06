//
//  riddumView.h
//  ACR_Space
//
//  Created by Bridget Johnson on 16/04/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "radiationView.h"

@interface riddumView : UIView

- (id)initWithFrame:(CGRect)frame
             colour:(UIColor*)col
              label:(NSString*)str;

- (void)blink;



@property int myIndex;
@property BOOL isPlaying;
@property CGPoint myCenter;
@property float screenHeight;

-(void)updateRadiationSize:(float)theSize;


@end
