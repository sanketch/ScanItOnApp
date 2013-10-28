//
//  ScanViewController.h
//  TutorialBase
//
//  Created by Sanket Chauhan on 10/19/13.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "ZBarSDK.h"
@interface ScanViewController : UIViewController

- (IBAction)logoutPressed:(id)sender;


@property (weak, nonatomic) IBOutlet UIImageView *resultImageView;
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
- (IBAction)startScanning:(id)sender;

@end
