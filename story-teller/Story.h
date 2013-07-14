//
//  Story.h
//  story-teller
//
//  Created by me on 7/14/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PageViewController.h"

@class PageViewController;

@interface Story : NSManagedObject

@property (nonatomic, retain) NSString * storyId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;
@property (nonatomic, retain) NSSet *pages;

@end

@interface Story (CoreDataGeneratedAccessors)

- (void)addPagesObject:(Page *)value;
- (void)removePagesObject:(Page *)value;
- (void)addPages:(NSSet *)values;
- (void)removePages:(NSSet *)values;

@end
