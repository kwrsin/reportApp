//
//  RenameViewController.m
//  reportApp
//
//  Created by kwrsin on 2013/05/25.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import "RenameViewController.h"
#import "MasterViewController.h"
#import "SubMasterViewController.h"
#import "dataManager.h"
#import "Consts.h"

@interface RenameViewController ()

@end

@implementation RenameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"データの作成", @"create");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)done:(id)sender {
    NSString *newFileName = [self getNewFileName];
    int saveflag = 0;
    
    NSArray *labels = [SubMasterViewController getLabels];
    int count = labels.count;
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects removeAllObjects];
    NSMutableArray * newdata = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSMutableDictionary * item = [NSMutableDictionary dictionaryWithCapacity:2];
        [item setValue:[labels objectAtIndex:i] forKey:@"label"];
        [item setValue:@"" forKey:@"data"];
        [_objects addObject:item];
        [newdata addObject:@""];
    }
    
    saveflag = [self.dm saveFile:newFileName dataList:newdata];
    if (saveflag == DM_SUCCESS) {
        [self.masterViewController gotoSubmenu4newData:newFileName];
    
    }else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"データの作成ができませんでした。既にデータが存在します。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}
- (NSString *)getNewFileName {
    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
	NSString *outputDateFormatterStr = @"yyyy-MM-dd";
	[outputDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
	[outputDateFormatter setDateFormat:outputDateFormatterStr];
	NSString *newFileName = [NSString stringWithFormat:@"%@.dat",
                             [outputDateFormatter stringFromDate:_dpk.date]];
    return newFileName;
}


@end
