//
//  PageViewController.m
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import "PageViewController.h"
#import "NSData+Base64.h"

@interface PageViewController ()

@end

@implementation PageViewController

@synthesize contentImageView, contentLabel;

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
    if (self.page) {
        contentLabel.text = self.page.content;
        
        NSData *data = [NSData dataFromBase64String:self.page.image];
        UIImage *chart = [UIImage imageWithData:data];
        contentImageView.image = chart;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
