//
//  CCSecondViewController.m
//  MatchedUp
//
//  Created by Eliot Arntz on 11/30/13.
//  Copyright (c) 2013 Code Coalition. All rights reserved.
//

#import "CCSecondViewController.h"

@interface CCSecondViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *profilePictureImageView;


@end

@implementation CCSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /* Create a query for the Photo class. Constraint it to only return the Photo for the current user */
    PFQuery *query = [PFQuery queryWithClassName:kCCPhotoClassKey];
    [query whereKey:kCCPhotoUserKey equalTo:[PFUser currentUser]];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        /* Confirm there is a Photo returned from our block. If there is get the PFObject out of the array and then access the PFFile for the key image. Finally, get the data for the PFFile and then create a UIImage to display as our profile picture. */ 
        if ([objects count] > 0){
            PFObject *photo = objects[0];
            PFFile *pictureFile = photo[kCCPhotoPictureKey];
            [pictureFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                self.profilePictureImageView.image = [UIImage imageWithData:data];
            }];
        }
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
