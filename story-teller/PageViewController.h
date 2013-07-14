//
//  PageViewController.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageItem.h"

@interface PageViewController : UIViewController

@property (retain, nonatomic) PageItem *page;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
