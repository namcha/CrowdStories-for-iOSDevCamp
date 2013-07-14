//
//  StoryItem.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"

@interface StoryItem : NSObject <UIPageViewControllerDataSource>

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSMutableArray *pages;

- (PageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PageViewController *)viewController;

@end
