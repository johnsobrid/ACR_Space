//
//  ViewController.h
//  ACR_Space
//
//  Created by Bridget Johnson on 25/03/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <VVOSC/VVOSC.h>
#import "MechaView.h"
#import "riddumView.h"


@interface ViewController : UIViewController
{
   OSCManager *manager;
   OSCOutPort *outport;
}
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context;

@property (strong, nonatomic) NSString* manual_IP_String;
@property (strong, nonatomic) NSString* manual_Port_String;

@property(strong) NSMutableArray *MechaViewArray;
@property(strong) NSMutableArray *riddumViewArray;
@property(strong) NSMutableArray *mechaPositionsX;
@property(strong) NSMutableArray *mechaPositionsY;


@property float storedRadiationDistance;


@end

