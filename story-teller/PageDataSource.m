//
//  PageDataSource.m
//  story-teller
//
//  Created by me on 7/14/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import "PageDataSource.h"

@implementation PageDataSource


- (PageViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.story.pages count] == 0) || (index >= [self.story.pages count])) {
        return nil;
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createddate" ascending:YES];
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSArray *pages = [[self.story.pages allObjects] sortedArrayUsingDescriptors:descriptors];

    // Create a new view controller and pass suitable data.
    Page *page = pages[index];
    PageViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.page = page;
    
    dataViewController.contentLabel.text = page.content;
    //    dataViewController.contentImageView
    
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(PageViewController *)viewController
{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createddate" ascending:YES];
    NSArray *descriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSArray *pages = [[self.story.pages allObjects] sortedArrayUsingDescriptors:descriptors];

    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [pages indexOfObject:viewController.page];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PageViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PageViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.story.pages count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
