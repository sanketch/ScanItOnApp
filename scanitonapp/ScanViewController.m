//
//  ScanViewController.m
//  scanitonapp
//
//  Created by Sanket Chauhan on 10/19/13.
//
//

#import "ScanViewController.h"
#import <Parse/Parse.h>

@interface ScanViewController()

@end

@implementation ScanViewController

@synthesize resultImageView;
@synthesize resultTextView;

- (void)viewDidUnload {
    //[self setLogoutPressed:nil];
    [self setResultImageView:nil];
    [self setResultTextView:nil];
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
- (IBAction)startScanning:(id)sender {
    NSLog(@"Scanning..");
    resultTextView.text = @"Scanning..";
    
    ZBarReaderViewController *codeReader = [ZBarReaderViewController new];
    codeReader.readerDelegate=self;
    codeReader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = codeReader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    [self presentViewController:codeReader animated:YES completion:nil];
}

- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    //  get the decode results
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // just grab the first barcode
        break;
    
    // showing the result on textview
    resultTextView.text = symbol.data;
    
    resultImageView.image = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // dismiss the controller
    [reader dismissViewControllerAnimated:YES completion:nil];
}
@end
