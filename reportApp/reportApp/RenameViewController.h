//
//  RenameViewController.h
//  reportApp
//
//  Created by kwrsin on 2013/05/25.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MasterViewController;
@class dataManager;

@interface RenameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *dpk;
@property (strong, nonatomic) MasterViewController *masterViewController;
@property (strong, nonatomic) NSMutableArray *objects;
@property (strong, nonatomic) dataManager *dm;
- (IBAction)done:(id)sender;
- (NSString *)getNewFileName;

@end
