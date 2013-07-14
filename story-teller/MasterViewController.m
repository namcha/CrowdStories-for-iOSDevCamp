//
//  MasterViewController.m
//  story-teller
//
//  Created by me on 7/13/13.
//  Copyright (c) 2013 namcha. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "STTwitterAPIWrapper.h"
#import "STTwitterHTML.h"
#import "StoryItem.h"
#import "PageItem.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

@synthesize stories;

- (NSDate *) parseTwitterDate:(NSString *)twitterDate {
    twitterDate = [twitterDate uppercaseString];
    NSDateFormatter *twitterDateFormatter = NSDateFormatter.new;
    [twitterDateFormatter setDateFormat: @"ddd MMM dd HH:mm:ss zzz yyyy"];
    return [twitterDateFormatter dateFromString:twitterDate];
};

- (void)createPageFromTweet:(NSDictionary *) tweet forStory:(StoryItem *) story
{
    NSDictionary *entities = [tweet objectForKey:@"entities"];
    NSDictionary *media = ((NSArray *)[entities objectForKey:@"media"])[0];
    NSString *imageUrl = [media objectForKey:@"media_url"];
    NSString *content = [tweet objectForKey:@"text"];
    
    // FIXME need to remove all hashtags and urls
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: @"#.+? |http.+$" options: NSRegularExpressionCaseInsensitive error: nil];
    NSString* plainText = [regex stringByReplacingMatchesInString: content options: 0 range: NSMakeRange(0, [content length]) withTemplate: @""];
    NSString *hashTitle = [[NSString alloc] initWithFormat:@"#%@", story.title];
    plainText = [plainText stringByReplacingOccurrencesOfString:hashTitle withString:@""];
    plainText = [plainText stringByReplacingOccurrencesOfString:@"_" withString:@" "];

    //NSDate *createAt = [self parseTwitterDate:[tweet objectForKey:@"created_at"]];
    
    PageItem *page = [[PageItem alloc] init];
    page.text = plainText;
    page.imageUrl = imageUrl;
    //page.createAt = createAt;
    
    // HACK we assume the order is always start from the newest
    //[story.pages addObject:page];
    [story.pages insertObject:page atIndex:0];
}

- (void)parseTweets:(NSArray *)tweets
{
    for (NSDictionary *tweet in tweets) {
        NSDictionary *entities = [tweet objectForKey:@"entities"];
        NSArray *hashtags = [entities objectForKey:@"hashtags"];
        
        for (NSDictionary *hashtag in hashtags) {
            //NSLog(@"%@", hashtag);
            NSString *storyTitle = [hashtag objectForKey:@"text"];
            if (![storyTitle isEqualToString:@"theneverendingtweets"]) {
//            if (![storyTitle isEqualToString:@"iosdevcamp2013"]) {
                StoryItem *story = nil;
                for (StoryItem *item in stories) {
                    if ([item.title isEqualToString:storyTitle]) {
                        story = item;
                        break;
                    }
                }
                
                if (story) {
                    // existing story
                } else {
                    // new story
                    story = [[StoryItem alloc] init];
                    story.pages = [[NSMutableArray alloc] init];
                    story.title = storyTitle;
                    
//                    [stories addObject:story];
                    [stories insertObject:story atIndex:0];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                
                [self createPageFromTweet:tweet forStory:story];
            }
        }
    }
}

- (void)populateTable
{
//    for (int i = 0; i < stories.count; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
}

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.stories = [[NSMutableArray alloc] init];
    
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // here, we use the credentials from OS X Preferences
    STTwitterAPIWrapper *twitter = [STTwitterAPIWrapper twitterAPIApplicationOnlyWithConsumerKey:@"FEL4uGHIxnxgpKSxIDxLg" consumerSecret:@"xtlSi60jE4MTnucuDBAWl39mbaAOzLFUfp0XAOyE"];
    [twitter verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        //NSLog(@"-- bearer: %@", bearerToken);
        
        [twitter getSearchTweetsWithQuery:@"#theneverendingtweets" successBlock:^(NSDictionary *searchMetadata, NSArray *statuses) {
            //NSLog(@"%@", statuses);
            
            [self parseTweets:statuses];
            [self populateTable];
        } errorBlock:^(NSError *error) {
            NSLog(@"%@", error);
        }];
    } errorBlock:^(NSError *error) {
        NSLog(@"-- error: %@", error);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    //NSDate *object = _objects[indexPath.row];
    StoryItem *object = stories[indexPath.row];
    cell.textLabel.text = object.title;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [stories removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSDate *object = _objects[indexPath.row];
    StoryItem *object = stories[indexPath.row];
    self.detailViewController.detailItem = object;
    self.detailViewController.navigationItem.title = object.title;
}

@end
