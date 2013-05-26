//
//  MasterViewController.h
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubMasterViewController;
@class RenameViewController;
@class dataManager;

@interface MasterViewController : UITableViewController
{
    NSMutableArray *_objects;
    dataManager *dm;
}

@property (strong, nonatomic) SubMasterViewController *subMasterViewController;
@property (strong, nonatomic) RenameViewController *renameViewController;
@property (strong, nonatomic) NSMutableDictionary *loadedData;
- (void)refleshData;
- (void)gotoSubmenu4newData:(NSString *)filename;
@end
