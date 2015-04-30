//
//  MechaView.h
//  ACR_Space
//
//  Created by Bridget Johnson on 25/03/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MechaView : UIView

- (id)initWithFrame:(CGRect)frame
             colour:(UIColor*)col
              label:(NSString*)str;

-(void) dragging:(UIPanGestureRecognizer *)drag;

@property int myIndex;
@property BOOL positionLocked;
@property CGPoint mechaPos;


@end
