//
//  PageItem.h
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageItem : NSObject

@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *imageUrl;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSDate *createAt;

@end
