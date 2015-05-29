//
//  ViewController.m
//  ACR_Space
//
//  Created by Bridget Johnson on 25/03/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UISlider *raditationdistance;
@property (strong, nonatomic) IBOutlet UISlider *radiationDistTwo;
@property (strong, nonatomic) IBOutlet UISlider *radiationDistThree;
@property (strong, nonatomic) IBOutlet UISlider *radiationDistfour;


@property BOOL allowMovement;

@end

@implementation ViewController
- (IBAction)radiationSlider:(UISlider *)sender {
   _storedRadiationDistanceOne = [self.raditationdistance value];
        [[_riddumViewArray objectAtIndex:0] updateRadiationSize:_storedRadiationDistanceOne * self.view.bounds.size.height];
}
- (IBAction)raditationSlider2:(UISlider *)sender {
   _storedRadiationDistanceTwo = [self.radiationDistTwo value];
   [[_riddumViewArray objectAtIndex:1] updateRadiationSize:_storedRadiationDistanceTwo * self.view.bounds.size.height];
}

- (IBAction)radiationSliderThree:(UISlider *)sender {
   _storedRadiationDistanceThree = [self.radiationDistThree value];
   [[_riddumViewArray objectAtIndex:2] updateRadiationSize:_storedRadiationDistanceThree * self.view.bounds.size.height];
}
- (IBAction)radiationSliderFour:(UISlider *)sender {
   _storedRadiationDistanceFour = [self.radiationDistfour value];
   [[_riddumViewArray objectAtIndex:3] updateRadiationSize:_storedRadiationDistanceFour * self.view.bounds.size.height];
}


-(BOOL)shouldAutorotate
{
   return false;
}

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.

   //init the rythmns first so they sit underneath
   [self riddumViewInit];
   [self mechaViewInit];
   _storedRadiationDistanceOne = 0.3;
   _storedRadiationDistanceTwo = 0.3;

   _storedRadiationDistanceThree = 0.3;

   _storedRadiationDistanceFour = 0.3;

}

-(void)viewWillAppear:(BOOL)animated
{
    [self upDateOSC];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

-(void)mechaViewInit
{
   _MechaViewArray = [NSMutableArray arrayWithCapacity:0];
   _mechaPositionsX = [NSMutableArray arrayWithCapacity:8];
   _mechaPositionsY = [NSMutableArray arrayWithCapacity:8];

   CGRect bounds = [[self view]bounds];
   
   float boxWidth = 60;
   float gapWidth = (bounds.size.width - (boxWidth * 8)) / (9);
   float x = gapWidth;
   float y = bounds.size.height - (boxWidth*1.25);
   
   float xIncr = boxWidth + gapWidth;

   for (int i=0;i< 8;i++,x+=xIncr) {
      CGRect rect = CGRectMake(x,y,boxWidth,boxWidth);
      MechaView *mechaView = [[MechaView alloc] initWithFrame:rect
                                                                    colour: [UIColor redColor]
                                                                     label:[NSString stringWithFormat:@"%i",i]];
      mechaView.myIndex = i;
      
      [mechaView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:mechaView action:@selector(dragging:)]];
      [mechaView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mechaPressed:)]];
      [mechaView addObserver:self
                      forKeyPath:@"mechaPos"
                         options:(NSKeyValueObservingOptionNew |
                                  NSKeyValueObservingOptionOld)
                         context:NULL];

      [_MechaViewArray addObject:mechaView];
      
      [[self view] addSubview:mechaView];
      [_mechaPositionsX insertObject:[NSNumber numberWithFloat:(mechaView.center.x)] atIndex:mechaView.myIndex];
      [_mechaPositionsY insertObject:[NSNumber numberWithFloat:(mechaView.center.y)] atIndex:mechaView.myIndex];

      [mechaView setNeedsDisplay];
      }

}

-(void)riddumViewInit
{
   _riddumViewArray = [NSMutableArray arrayWithCapacity:0];
   CGRect bounds = [[self view]bounds];
   
   float boxWidth = 100;
   float gapWidth = (bounds.size.width - (boxWidth * 8)) / (9);
   float x = gapWidth;
   float y = bounds.size.height - (boxWidth*1.25);
   
   float xIncr = boxWidth + gapWidth;
   
   for (int i=0;i< 4;i++,x+=xIncr) {
      CGRect rect = CGRectMake(x,y,boxWidth,boxWidth);
      riddumView *newRiddumView = [[riddumView alloc] initWithFrame:rect
                                                       colour: [UIColor redColor]
                                                        label:[NSString stringWithFormat:@"%i",i]];
      newRiddumView.myIndex = i;
      newRiddumView.screenHeight = self.view.bounds.size.height;
      [newRiddumView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(riddumPressed:)]];
      [newRiddumView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:newRiddumView action:@selector(dragging:)]];
      [newRiddumView addObserver:self
                   forKeyPath:@"myCenter"
                      options:(NSKeyValueObservingOptionNew |
                               NSKeyValueObservingOptionOld)
                      context:NULL];
      [newRiddumView setUserInteractionEnabled:YES];

      [_riddumViewArray addObject:newRiddumView];
      [[self view] addSubview:newRiddumView];
      [newRiddumView setNeedsDisplay];
   }

}


-(void)riddumPressed:(UITapGestureRecognizer *)riddumTapped
{
   riddumView *rv = (riddumView *)riddumTapped.view;
   int index = rv.myIndex;

   if (!rv.isPlaying)
   {
      [self sendOSC:@"/play" indexInt:index withMsgInt:1];
      rv.isPlaying = true;
      [rv blink];
   } else {
       [self sendOSC:@"/play" indexInt:index withMsgInt:0];
      rv.isPlaying = false;
   }
}

-(void)mechaPressed:(UITapGestureRecognizer *)tapDown
{
   MechaView *mv = (MechaView *)tapDown.view;
   int index = mv.myIndex;
   
   //this code makes the background colour change for a moment  so you can see that you have pressed it
   mv.backgroundColor = [UIColor grayColor];
   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC);
   dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      mv.backgroundColor = [UIColor redColor];   });
   
   [self sendOSC:[NSString stringWithFormat:@"%i", index] msgInt:1];
}

- (IBAction)objectLocked:(UISwitch *)sender {
   
   if ([sender isOn]) {
      
      for (MechaView *objects in _MechaViewArray){
         objects.positionLocked = true;
         
      }
   } else {
      for (MechaView *objects in _MechaViewArray){
         objects.positionLocked = false;
      }
   }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
   
  
   
   if ([keyPath isEqual:@"myCenter"]) {
      riddumView *theRiddumView = object;
      int index = theRiddumView.myIndex;

      CGPoint loc = theRiddumView.myCenter;
      [self checkPosition:loc withRiddumID:index];
      
   }
   if ([keyPath isEqual:@"mechaPos"]) {
       MechaView *theMechaView = object;
      int index = theMechaView.myIndex;

      [_mechaPositionsX removeObjectAtIndex:index];
      [_mechaPositionsY removeObjectAtIndex:index];
      [_mechaPositionsX insertObject:[NSNumber numberWithFloat:(theMechaView.center.x)] atIndex:index];
      [_mechaPositionsY insertObject:[NSNumber numberWithFloat:(theMechaView.center.y)] atIndex:index];
   }
}

-(void) checkPosition: (CGPoint)riddumPosition withRiddumID:(int)index
{
  
      for (int i = 0; i < 8; i++) {
         //the static object minus the moveable object
      float a = [[_mechaPositionsX objectAtIndex:i]floatValue] - riddumPosition.x;
      float b = [[_mechaPositionsY objectAtIndex:i]floatValue] - riddumPosition.y;
      float c = sqrtf(a * a + b * b);
          c = c/self.view.bounds.size.height;
         
         if (index == 0)
         {
            if (c < _storedRadiationDistanceOne)
            {
               //send details about yourself rhytm ID, mechaID (i) velocityScale(c)
               c = 1 - (c/_storedRadiationDistanceOne);
               [self sendRiddumOSC:index withMechaID:i withVelcotiyScale:c];
            }
         }
         if (index == 1)
         {
            if (c < _storedRadiationDistanceTwo)
            {
               //send details about yourself rhytm ID, mechaID (i) velocityScale(c)
               c = 1 - (c/_storedRadiationDistanceTwo);
               [self sendRiddumOSC:index withMechaID:i withVelcotiyScale:c];
            }
         }
         if (index == 2)
         {
            if (c < _storedRadiationDistanceThree)
            {
               //send details about yourself rhytm ID, mechaID (i) velocityScale(c)
               c = 1 - (c/_storedRadiationDistanceThree);
               [self sendRiddumOSC:index withMechaID:i withVelcotiyScale:c];
            }
         }
         if (index == 3)
         {
            if (c < _storedRadiationDistanceFour)
            {
               //send details about yourself rhytm ID, mechaID (i) velocityScale(c)
               c = 1 - (c/_storedRadiationDistanceFour);
               [self sendRiddumOSC:index withMechaID:i withVelcotiyScale:c];
            }
         }
   }
      
}

-(void)upDateOSC
{
   //links the OSC messages to the port and IP as inputed on start up screen
   manager = [[OSCManager alloc]init];
   outport = [manager createNewOutputToAddress:_manual_IP_String atPort:[_manual_Port_String intValue] withLabel:@"Output"];
}

- (void)sendOSC: (NSString*)msg  msgInt:(int)msgInt
{
   //sends an OSC message with an object ID and a message (mostly used for the mecha objects
   OSCMessage *newMsg = [OSCMessage createWithAddress:msg];
   [newMsg addInt:msgInt];
   [outport sendThisMessage:newMsg];
  // NSLog(msg);
}
- (void)sendOSC: (NSString*)msg  indexInt:(int)indexInt withMsgInt:(int) msgInt
{
   //sends an OSC message with a variable ID and a message int (mostly used for riddum objects to play and stop)
   OSCMessage *newMsg = [OSCMessage createWithAddress:msg];
   [newMsg addString:[NSString stringWithFormat:@"/%i", indexInt]];
   [newMsg addInt:msgInt];
   [outport sendThisMessage:newMsg];
   // NSLog(msg);
}


- (void)sendRiddumOSC: (int)riddumID  withMechaID:(int)mechaID withVelcotiyScale:(float) velocityScale
{
   //sends an OSC message with a variable ID and a message int (mostly used for riddum objects)
   OSCMessage *newMsg = [OSCMessage createWithAddress:[NSString stringWithFormat:@"/rhythm %i", riddumID]];
   [newMsg addInt:mechaID];
   [newMsg addFloat:velocityScale];
   [outport sendThisMessage:newMsg];
   // NSLog(msg);
}


@end
