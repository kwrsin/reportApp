//
//  MasterViewController.h
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubMasterViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) SubMasterViewController *subMasterViewController;
@property (strong, nonatomic) NSMutableDictionary *loadedData;
@end
