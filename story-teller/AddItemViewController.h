//
//  AddItemViewController.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackMobProvider.h"

@interface AddItemViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (weak, nonatomic) IBOutlet UIButton *photoHolderButton;

@property (nonatomic, retain) StackMobProvider *provider;
@property (weak, nonatomic) Story *story;

@end
