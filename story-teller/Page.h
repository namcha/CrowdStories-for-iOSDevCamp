//
//  Page.h
//  story-teller
//
//  Created by me on 7/14/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Story;

@interface Page : NSManagedObject

@property (nonatomic, retain) NSString * pageId;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) Story *parent;

@end
