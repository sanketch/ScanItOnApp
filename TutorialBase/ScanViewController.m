//
//  ScanViewController.m
//  TutorialBase
//
//  Created by Sanket Chauhan on 10/19/13.
//
//

#import "ScanViewController.h"
#import <Parse/Parse.h>

@interface ScanViewController()

@end

@implementation ScanViewController

- (void)viewDidUnload {
    //[self setLogoutPressed:nil];
    [super viewDidUnload];
}

- (IBAction)logoutPressed:(id)sender {
    
        [PFUser logOut];
        NSLog(@"Logged out");
        [self.navigationController popViewControllerAnimated:YES];
    
}
@end
