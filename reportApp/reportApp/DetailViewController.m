//
//  DetailViewController.m
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import "DetailViewController.h"
#import "SubMasterViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewWillAppear:(BOOL)animated {
    [self configureView];
    _valueField.delegate = self;
    
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    if (self.value) {
        self.valueField.text = _value;
    }
    if (self.subMasterViewController.filename) {
        NSString *filename = self.subMasterViewController.filename;
        NSString *label = [filename stringByReplacingOccurrencesOfString:@".dat" withString:@""];
        self.titleLabel.text = label;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.subMasterViewController reflect:_indexPath value:_valueField.text];
}
- (IBAction)HideKeyBoard:(id)sender {
    for (UIView *view in [self.view subviews]){
        if ([view isFirstResponder] ) {
            [view resignFirstResponder];
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // 入力後の文字列
    NSString *newString =
    [textField.text
     stringByReplacingCharactersInRange:range
     withString:string];
    
    NSString *expression = @"^[-+]?([0-9]*)?(\\.)?([0-9]*)?$";
    NSError *error = nil;
    
    NSRegularExpression *regex =
    [NSRegularExpression
     regularExpressionWithPattern:expression
     options:NSRegularExpressionCaseInsensitive
     error:&error];
    
    NSUInteger numberOfMatches =
    [regex numberOfMatchesInString:newString
                           options:0
                             range:NSMakeRange(0, [newString length])];
    
    if (numberOfMatches == 0) return NO;
    
    return YES;
}

@end
