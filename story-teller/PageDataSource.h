//
//  PageDataSource.h
//  story-teller
//
//  Created by me on 7/14/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"
#import "Story.h"

@interface PageDataSource : NSObject <UIPageViewControllerDataSource>

- (PageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PageViewController *)viewController;

@property (nonatomic) Story *story;

@end
