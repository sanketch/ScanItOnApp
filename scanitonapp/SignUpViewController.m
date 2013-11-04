#import <Parse/Parse.h>
#import "SignUpViewController.h"


@interface SignUpViewController ()
@property (nonatomic, strong) IBOutlet UITextField *userRegisterTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordRegisterTextField;
@property (strong, nonatomic) IBOutlet UITextField *fullNameRegisterTextField;
@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {

    }
    
    return self;
}

#pragma mark - Private methods

-(IBAction)signUpUserPressed:(id)sender
{
    PFUser *user = [PFUser user];
    user.username = self.userRegisterTextField.text;
    user.password = self.passwordRegisterTextField.text;
    user.email=self.userRegisterTextField.text;
    //user.full_name=self.fullNameRegisterTextField.text;
    
    [user setObject:self.fullNameRegisterTextField.text forKey:@"full_name"];
    //to obtain the data back I can use [[PFUser currentUser] setObject:@"text" forKey:@"full_name"]; NSString* myName = [[PFUser currentUser] objectForKey:@"full_name"]; NSLog(@"%@", myName);
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"SignupSuccesful" sender:self];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Error" message:[error userInfo][@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }
    }];
    
    

}

- (void)viewDidUnload {
    [self setFullNameRegisterTextField:nil];
    [super viewDidUnload];
}
@end
