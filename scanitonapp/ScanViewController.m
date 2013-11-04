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
    NSString* qrURL = resultTextView.text;
    if ([qrURL rangeOfString:@"www.scaniton.com/?id="].location != NSNotFound)
    {
        NSArray *splitArray = [qrURL componentsSeparatedByString:@"?id="];
        NSString *qrId = splitArray[1];
        PFObject *qrLogger = [PFObject objectWithClassName:@"qr_logger"];
        qrLogger[@"qrid"] = qrId;
        qrLogger[@"createdBy"] = [PFUser currentUser];
        [qrLogger saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                UIAlertView *notification = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Sender has been notified!" delegate:nil cancelButtonTitle:@"Awesome!" otherButtonTitles:nil];
                [notification show];
            }}];
    }
    else{
        UIAlertView *notification = [[UIAlertView alloc] initWithTitle:@"Invalid QR Code" message:@"Not a valid ScanItOn QR Code :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [notification show];
    }


    
    // dismiss the controller
    [reader dismissViewControllerAnimated:YES completion:nil];
}
@end
