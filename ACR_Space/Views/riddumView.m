//
//  riddumView.m
//  ACR_Space
//
//  Created by Bridget Johnson on 16/04/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "riddumView.h"

@implementation riddumView {
   radiationView *myRadiationView;
}

- (id)initWithFrame:(CGRect)frame
             colour:(UIColor*)col
              label:(NSString*)str
{
   self = [super initWithFrame:frame];
   if (self)
   {
      [self setBackgroundColor:[UIColor clearColor]];
      self.alpha = 0.2;
      UILabel *textField = [[UILabel alloc] initWithFrame:[self bounds]];
      
      textField.text = str;
      textField.font = [UIFont fontWithName:@"Helvetica" size:22];
      textField.textColor = [UIColor whiteColor];
      textField.backgroundColor = [UIColor clearColor];
      textField.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      textField.textAlignment = NSTextAlignmentCenter;
      //   textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
      
      _isPlaying = false;
      [self addSubview:textField];
       [self setClipsToBounds:false];
      
      myRadiationView = [[radiationView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width * 2, self.bounds.size.height * 2)
                                           colour:[UIColor whiteColor]];
      [myRadiationView.layer setZPosition: self.layer.zPosition - 1];
      myRadiationView.screenHeight = _screenHeight;
      [myRadiationView setCenter:CGPointMake(self.bounds.size.width *0.5, self.bounds.size.height * 0.5)];
      [myRadiationView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:myRadiationView action:@selector(handlePinch:)]];
      [myRadiationView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:myRadiationView action:@selector(dragging:)]];
      //[self set]
      [self addSubview:myRadiationView];
   }
   return self;
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
   CGContextSetFillColorWithColor(myContext, [[UIColor greenColor]CGColor]);
   //Draw an ellipse
   CGContextFillEllipseInRect(myContext, CGRectMake(0, 0, width, height));
   //OR draw a rectangle
   
}



- (void)blink{
   if (_isPlaying)
   {
      [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction                        animations:^{
                          self.alpha = 0.7;    // change alpha
                       }
                       completion:^(BOOL finished){
                          // code to run when animation completes
                          // (in this case, another animation:)
                          
                          [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction
                                           animations:^{
                                              self.alpha = 1.0;   // return to normal
                                           }
                                           completion:^(BOOL finished){  
                                              [self blink] ;
                                           }];
                       }];
   }
   
   
}

-(void)updateRadiationSize:(float)theSize{
   [myRadiationView setSize:theSize];
}

@end
