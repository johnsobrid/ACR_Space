//
//  MechaView.m
//  ACR_Space
//
//  Created by Bridget Johnson on 25/03/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "MechaView.h"

@implementation MechaView

- (id)initWithFrame:(CGRect)frame
             colour:(UIColor*)col
              label:(NSString*)str
{
   self = [super initWithFrame:frame];
   if (self)
   {
      [self setBackgroundColor:[UIColor redColor]];
      
      
      UILabel *textField = [[UILabel alloc] initWithFrame:[self bounds]];
      
      textField.text = str;
      textField.font = [UIFont fontWithName:@"Helvetica" size:22];
      textField.textColor = [UIColor whiteColor];
      textField.backgroundColor = [UIColor clearColor];
      textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      textField.textAlignment = NSTextAlignmentCenter;
      //   textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
      
      //[self setTextField:textField];
      [self addSubview:textField];

   }
   return self;
}


-(void) dragging:(UIPanGestureRecognizer *)pan
{
   if (!_positionLocked) {
      if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
         CGPoint delta = [pan translationInView:self];
         CGPoint centre = self.center;
         centre.x += delta.x;
         centre.y += delta.y;
         self.center = centre;
         [self setMechaPos:self.center];
         [pan setTranslation:CGPointZero inView:self];
      }

   }
}




@end

