//
//  ScanViewController.m
//  
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //to get the username
    //NSString* myName = [[PFUser currentUser] objectForKey:@"full_name"]; NSLog(@"%@", myName);
}

- (IBAction)logoutPressed:(id)sender {
    
        [PFUser logOut];
        NSLog(@"Logged out");
        [self.navigationController popViewControllerAnimated:YES];
    
}
@end
