//
//  settingsViewController.m
//  ACR_Space
//
//  Created by Bridget Johnson on 15/04/15.
//  Copyright (c) 2015 bdj. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *portField;
@property (weak, nonatomic) IBOutlet UITextField *ipField;

@end

@implementation settingsViewController

- (IBAction)connectPressed {
   _manual_IP_String = [self.ipField text];
   _manual_Port_String = [self.portField text];

}


-(void)viewDidLoad
{
   [super viewDidLoad];
   
   _manual_IP_String = @"169.254.169.59";
   _manual_Port_String = @"12000";
   [_portField setText:_manual_Port_String];
   [_ipField setText:_manual_IP_String];

}


//view controller is a terrible name, fix it
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if ([[segue identifier]isEqualToString:@"doneSegue"]) {
      if ([segue.destinationViewController isKindOfClass:[ViewController class]]) {
         ViewController *vc = segue.destinationViewController;
         vc.manual_IP_String = [_ipField text];
         vc.manual_Port_String =[_portField text];
      }
   }

}
@end
