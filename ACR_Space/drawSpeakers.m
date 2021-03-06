//
//  drawSpeakers.m
//  ACR_Space
//
//  Created by Bridget Johnson on 9/04/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "drawSpeakers.h"

@implementation drawSpeakers

-(CGFloat)euroOffset { return ([self speakerDivision]/0.96);}
-(CGFloat)speakerDivision { return M_PI/(kNumofSpeakers/2);}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
   // Drawing code
   
   [self positionSpeakers: true];
   [self positionSpeakers: false];
   
   
}


-(void)positionSpeakers: (BOOL)outfacing
{
   CGContextRef context = UIGraphicsGetCurrentContext();
   // save the cordinate scheme
   for (int i = 0; i < kNumofSpeakers; i++) {
      CGContextSaveGState(context);
      // translate it to the centre of the listening space
      CGContextTranslateCTM(context, self.bounds.size.width/2, self.bounds.size.height/2);
      // rotate to the angle where the speaker should be depending on the NUM_OF_SPEAKERS
      CGContextRotateCTM(context, ([self euroOffset] + (i*[self speakerDivision])));
      // translate to the edge of the speaker array
      if (outfacing)
      {
       CGContextTranslateCTM(context, (self.bounds.size.width/4.93)+(SPEAKER_SIZE*1.74),((self.bounds.size.width/4.75)));
         [self drawSpeakers:true];
      } else {
      CGContextTranslateCTM(context, (self.bounds.size.width/4.93)-(SPEAKER_SIZE*0.5),((self.bounds.size.width/4.93))-(SPEAKER_SIZE*0.5));
         [self drawSpeakers:false];
      }
      // call the draw speaker functions
 
      //return the coordinate scheme
      CGContextRestoreGState(context);
   }
}
-(void)drawSpeakers: (BOOL)outfacing
{
   //save coordinate scheme
   CGContextRef context = UIGraphicsGetCurrentContext();
   CGContextSaveGState(context);
   //rotate so the speakers face the centre
   if (outfacing) {
      CGContextRotateCTM(context, M_PI);

      CGContextRotateCTM(context, 2.3);
      //call method to draw the rect(which in turn calls the triange)
      [self drawSpeakerRect:CGPointMake(0.0, 0.0) withBool:true];

   } else {
   CGContextRotateCTM(context, 2.3);
      
   //call method to draw the rect(which in turn calls the triange)
   [self drawSpeakerRect:CGPointMake(0.0, 0.0) withBool:false ];
     
   }
   //return scheme
   CGContextRestoreGState(context);
}
// Timothy's speaker drawing
-(void)drawSpeakerRect:(CGPoint)rectPos withBool:(BOOL)isOutFacing
{
   UIBezierPath *speakerRect;
   if (isOutFacing) {
     speakerRect = [UIBezierPath bezierPathWithRect:CGRectMake(rectPos.x-SPEAKER_SIZE, rectPos.y-SPEAKER_SIZE, SPEAKER_SIZE, SPEAKER_SIZE/2.0)];

   } else {
  speakerRect = [UIBezierPath bezierPathWithRect:CGRectMake(rectPos.x-SPEAKER_SIZE, rectPos.y-SPEAKER_SIZE, SPEAKER_SIZE, SPEAKER_SIZE/2.0)];
   }
   [[UIColor colorWithRed:36/255.0 green:103/255.0 blue:124/255.0 alpha:1.0]setFill];
   [speakerRect fill];
   [self drawSpeakerTri:rectPos];
}

-(void)drawSpeakerTri:(CGPoint)rectPos
{
   CGPoint pointA = CGPointMake(rectPos.x-(SPEAKER_SIZE/2), rectPos.y - (SPEAKER_SIZE));
   CGPoint pointB = CGPointMake(rectPos.x - (1.5 * SPEAKER_SIZE), rectPos.y + (SPEAKER_SIZE/10));
   CGPoint pointC = CGPointMake(rectPos.x + (0.5 * SPEAKER_SIZE), rectPos.y + (SPEAKER_SIZE/10));
   
   UIBezierPath   *trianglePath = [[UIBezierPath alloc]init];
   [trianglePath moveToPoint:pointA];
   [trianglePath addLineToPoint:pointB];
   [trianglePath addLineToPoint:pointC];
   [trianglePath closePath];
   [[UIColor colorWithRed:36/255.0 green:103/255.0 blue:124/255.0 alpha:1.0]setFill];
   [trianglePath fill];
   
}



@end
