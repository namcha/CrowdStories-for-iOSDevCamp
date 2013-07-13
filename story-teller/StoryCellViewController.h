//
//  StoryCellViewController.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryItem.h"

@interface StoryCellViewController : UITableViewCell

- (void)setStory:(StoryItem *)story;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
