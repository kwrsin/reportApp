//
//  DetailViewController.h
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SubMasterViewController;
@class GraphViewController;

@interface DetailViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *valueField;

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSString *value;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) SubMasterViewController *subMasterViewController;
@property (strong, nonatomic) GraphViewController *graphViewController;
@property (assign, nonatomic) int indexOfSelectedItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (IBAction)HideKeyBoard:(id)sender;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
