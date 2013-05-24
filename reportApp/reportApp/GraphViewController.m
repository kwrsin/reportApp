//
//  GraphViewController.m
//  reportApp
//
//  Created by kwrsin on 2013/05/24.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import "GraphViewController.h"
#import "dataManager.h"

@interface GraphViewController ()

@end

@implementation GraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)getLoadData {
    
    dataManager *dm = [[dataManager alloc]init];
    
    _loadedData = [dm loadDataFromFiles];
}

- (NSMutableArray *)getXArrayList {
    NSMutableArray *array = nil;
    NSDate          *date_converted;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [formatter setDateFormat:@"yyyy-MM-dd-HH_mm_ss"];
    if (_loadedData) {
        array = [[NSMutableArray alloc]init];
        NSArray *arrayOfKeys = [_loadedData allKeys];
        for (NSString* filename in arrayOfKeys) {
            NSString* strDate = [filename stringByReplacingOccurrencesOfString:@".dat" withString:@""];
            date_converted = [formatter dateFromString:strDate];
            [array addObject:date_converted];
        }
    }
    return array;
}
- (NSMutableArray *)getYArrayList:(int)indexOfItem {
    NSMutableArray * array = nil;
    if (_loadedData) {
        array = [[NSMutableArray alloc]init];
        NSArray *arrayOfArray = [_loadedData allValues];
        for (NSArray* datas in arrayOfArray) {
            NSString *strValue = [datas objectAtIndex:indexOfItem];
            double dbl = strValue.doubleValue;
            NSNumber *number = [NSNumber numberWithDouble:dbl];
            [array addObject:number];
        }
    }
    
    return array;
}

- (void)createYFormatter {
//	NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
//	[numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
////	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
//	self.graphView.yValuesFormatter = numberFormatter;
	NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
//     [numberFormatter setPositiveFormat:@"#.##"];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.maximumFractionDigits = 2;
	self.graphView.yValuesFormatter = numberFormatter;
}

- (void)createXFormatter {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];

	self.graphView.xValuesFormatter = dateFormatter;
}

- (void)viewDidAppear:(BOOL)animated {
    [self getLoadData];
    CGRect graphRect = CGRectMake(0, 0, 800, 400);
    self.graphView = [[S7GraphView alloc] initWithFrame:graphRect];
    self.graphView.dataSource = self;
    self.graphView.delegate = self;
	self.graphView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:self.graphView];
    [_scrollView setContentSize:CGSizeMake(800, 400)];
    [self createXFormatter];
    [self createYFormatter];
    
//    [super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark protocol S7GraphViewDataSource

- (NSUInteger)graphViewMaximumNumberOfXaxisValues:(S7GraphView *)graphView {
    return [_loadedData count];
}

- (NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView {
    /* Return the number of plots you are going to have in the view. 1+ */
    return 1;
}

- (NSArray *)graphViewXValues:(S7GraphView *)graphView {
	NSMutableArray *array = [self getXArrayList];
    return array;
}

- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex {
    NSMutableArray *array;
	switch (plotIndex) {
			
		default:
		case 0:
            array = [self getYArrayList:self.indexOfSelectedItem];
			break;
	}

    return array;
}

- (BOOL)graphView:(S7GraphView *)graphView shouldFillPlot:(NSUInteger)plotIndex {
    return NO;
}

- (void)graphView:(S7GraphView *)graphView indexOfTappedXaxis:(NSInteger)indexOfTappedXaxis {
//    GraphInfo *tapped = [self.graphInfoList_.list_ objectAtIndex:indexOfTappedXaxis];
//    [label setText:[NSString stringWithFormat:@"%@ was tapped.",tapped.name_]];
}

@end
