//
//  StackMobProvider.m
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import "StackMobProvider.h"
#import "StackMob.h"
#import "Story.h"
#import "Page.h"

@interface StackMobProvider()

/*
 We define the 2 main components of the StackMob iOS SDK:
 
 An SMClient instance is used as the outlet to every other SDK component we might use.
 An SMCoreDataStore instance initializes our custom Core Data stack and gets it ready for persistence. It will also be our outlet for interacting with the caching and syncing systems.
 */
@property (strong, nonatomic) SMClient *client;
@property (strong, nonatomic) SMCoreDataStore *coreDataStore;

@end

@implementation StackMobProvider

@synthesize managedObjectModel = _managedObjectModel;

- (void)setAccessToken:(NSString *)key
{
    SM_CACHE_ENABLED = YES;
    self.client = [[SMClient alloc] initWithAPIVersion:@"0" publicKey:key];
    self.coreDataStore = [self.client coreDataStoreWithManagedObjectModel:self.managedObjectModel];
}

- (void)reload
{
    self.client = [SMClient defaultClient];
    self.coreDataStore = [self.client coreDataStoreWithManagedObjectModel:self.managedObjectModel];
}

- (void)getStoriesSuccess:(void (^)(NSArray *))success error:(void (^)(NSError *))errorBlock
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Story"];
    
    // set any predicates or sort descriptors, etc.
    
    // execute the request
    NSManagedObjectContext *context = [self.coreDataStore contextForCurrentThread];
    [context executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        if (success) {
            success(results);
        }
    } onFailure:^(NSError *error) {
//        NSLog(@"Error fetching: %@", error);
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

- (void)createPageToStory:(Story *)story content:(NSString *)content image:(NSString *)image success:(void (^)(Page *))success error:(void (^)(NSError *error))errorBlock
{
    NSManagedObjectContext *context = [self.coreDataStore contextForCurrentThread];
    Page *newPage = [NSEntityDescription insertNewObjectForEntityForName:@"Page" inManagedObjectContext:context];
    
    // Assumes Todo has attributes title and todoId
    [newPage setContent:content];
    [newPage setImage:image];
    [newPage setPageId:[newPage assignObjectId]];
    [story addPagesObject:newPage];
    
    [context saveOnSuccess:^{
        if (success) {
            newPage.createddate = [NSDate date];
            success(newPage);
        }
    } onFailure:^(NSError *error) {
        if (errorBlock) {
            errorBlock(error);
        }
    }];
}

#pragma mark - Core Data stack

/*
 StackMob only needs the developer to initialize the managed object model. The persistent store coordinator and managed object context are initialized by the StackMob iOS SDK.
 
 Here we initialize the managed object model if it is nil.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"StackMobModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

@end
