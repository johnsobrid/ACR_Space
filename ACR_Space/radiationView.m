//
//  radiationView.m
//  ACR_Space
//
//  Created by Bridget Johnson on 30/04/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "radiationView.h"

@implementation radiationView

- (id)initWithFrame:(CGRect)frame
             colour:(UIColor*)col{
   
   self = [super initWithFrame:frame];
   _col = col;
   
   [self setBackgroundColor:[UIColor clearColor]];
   //[self setSize:0.0];
   
   return self;
}
-(void)viewDidLoad
{
  // [self setSize:0.5 * self.superview.bounds.size.height];
}
-(void)handlePinch:(UIPinchGestureRecognizer *)pinch
{
 
   
   CGRect frame = [self bounds];
   frame.size.width = frame.size.width * pinch.scale;
   frame.size.height = frame.size.height *pinch.scale;
   [self setBounds:frame];
   pinch.scale = 1.0;
}
-(void) dragging:(UIPanGestureRecognizer *)pan
{
   if (pan.state == UIGestureRecognizerStateBegan || pan.state == UIGestureRecognizerStateChanged) {
      CGPoint delta = [pan translationInView:self];
      CGPoint centre = self.center;
      centre.x += delta.x;
      centre.y += delta.y;
      self.center = centre;
      [self setMyCenter:self.center];
      [pan setTranslation:CGPointZero inView:self];
   }
}

-(void)setSize:(float)size{
   [self setBounds:CGRectMake(self.center.x, self.center.y, size, size)];
}

- (void)drawRect:(CGRect)rect
{
   int width  = self.frame.size.width;
   int height = self.frame.size.height;
   //Get the CGContext to draw into
   CGContextRef myContext = UIGraphicsGetCurrentContext();
   //Save the current state
   CGContextSaveGState(myContext);
   //Move position to center in order to...
   CGContextSetFillColorWithColor(myContext, [[_col colorWithAlphaComponent:0.3]CGColor]);
   //Draw an ellipse
   CGContextFillEllipseInRect(myContext, CGRectMake(0, 0, width, height));
   //OR draw a rectangle
   
}


@end
