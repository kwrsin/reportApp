//
//  SubMasterViewController.h
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface SubMasterViewController : UITableViewController

@property (strong, nonatomic) id filename;
@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) NSDictionary *loadedData;
+ (NSArray *)getLabels;
- (void)reflect:(NSIndexPath*)indexPath value:(NSString*)value;
@end
