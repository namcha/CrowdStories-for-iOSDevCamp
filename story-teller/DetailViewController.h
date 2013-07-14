//
//  DetailViewController.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryItem.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIPageViewControllerDelegate>

@property (strong, nonatomic) StoryItem *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
