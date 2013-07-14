//
//  MasterViewController.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, retain) AddItemViewController *addViewController;

@property (nonatomic, retain) NSArray *stories;

@end
