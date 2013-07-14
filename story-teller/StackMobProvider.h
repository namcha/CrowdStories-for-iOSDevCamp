//
//  StackMobProvider.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"
#import "Page.h"

@interface StackMobProvider : NSObject

- (void)setAccessToken:(NSString *)key;
- (void)reload;

- (void)getStoriesSuccess:(void (^)(NSArray *stories))success error:(void (^)(NSError *error))error;
- (void)createPageToStory:(Story *)story content:(NSString *)content image:(NSString *)image success:(void (^)(Page *newStory))success error:(void (^)(NSError *error))error;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

@end
