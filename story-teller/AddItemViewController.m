//
//  AddItemViewController.m
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import "AddItemViewController.h"
#import "NSData+Base64.h"

@interface AddItemViewController ()

@property (nonatomic, retain) UIPopoverController *popover;

@end

@implementation AddItemViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraTouchUpInside:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)photoHolderTouchUpInside:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    [self.popover presentPopoverFromRect:CGRectMake(0.0, 0.0, 400.0, 400.0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)photoTouchUpInside:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:picker];
    [self.popover presentPopoverFromRect:CGRectMake(0.0, 0.0, 400.0, 400.0) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)saveTouchUpInside:(id)sender {
    //you can again use it in NSURL eg if you have async loading images and your mechanism
    //uses only url like mine (but sometimes i need local files to load)
    NSData *data = UIImageJPEGRepresentation(self.imageView.image, 0.8f);
    NSString *base64 = [data base64EncodedString];
    
    NSString *content = self.contentText.text;
    
    //self.provider = [[StackMobProvider alloc] init];
    //[self.provider reload];
    [self.provider createPageToStory:self.story content:content image:base64 success:^(Page *newStory) {
        [self.navigationController popViewControllerAnimated:YES];
    } error:^(NSError *error) {
        //
    }];
    
    
//    [wrapper postStatusUpdate:@"my first attempt to add a page" inReplyToStatusID:nil mediaData:data placeID:nil lat:nil lon:nil successBlock:^(NSDictionary *status) {
//        //
//    } errorBlock:^(NSError *error) {
//        //
//    }];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage;//, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // Save the new image (original or edited) to the Camera Roll
        //UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
        self.imageView.image = originalImage;
    }
    
    self.photoHolderButton.hidden = YES;
    self.photoButton.hidden = NO;
    
    if (self.popover) {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.popover) {
        [self.popover dismissPopoverAnimated:YES];
        self.popover = nil;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
