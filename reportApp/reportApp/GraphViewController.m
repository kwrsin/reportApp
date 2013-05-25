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
	NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
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
    
    self.itemInfo = [self getItemInfo:self.indexOfSelectedItem];
    NSString *unitName = [_itemInfo objectForKey:@"unit"];
    if (unitName) {
        self.graphView.yUnit = unitName;
    }
    self.title = self.selectedItem;
    
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
    NSDictionary * itemDic = [self itemInfo];
    NSArray * manArray = [itemDic objectForKey:@"man"];
    NSArray * womanArray = [itemDic objectForKey:@"woman"];
    int numOfMan = 0;
    int numOfWoman = 0;
    if (manArray) {
        numOfMan = manArray.count;
    }
    if (womanArray) {
        numOfWoman = womanArray.count;
    }
    return 1 + numOfMan + numOfWoman;
}

- (NSArray *)graphViewXValues:(S7GraphView *)graphView {
	NSMutableArray *array = [self getXArrayList];
    return array;
}

- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex {
    NSMutableArray *array;
    NSArray *manUpper;
    NSArray *manLower;
    NSArray *womanUpper;
    NSArray *womanLower;
    
	switch (plotIndex) {
			
		case 0:
            array = [self getYArrayList:self.indexOfSelectedItem];
			break;
		case 1:
            manUpper = [_itemInfo objectForKey:@"man"];
            if (manUpper) {
                array = [[NSMutableArray alloc]init];
                float point = [[manUpper objectAtIndex:plotIndex - 1] floatValue];
                int count = _loadedData.count;
                for (int i = 0; i < count; i++) {
                    [array addObject:[NSNumber numberWithFloat:point]];
                }
            }
			break;
		case 2:
            manLower = [_itemInfo objectForKey:@"man"];
            if (manLower) {
                array = [[NSMutableArray alloc]init];
                float point = [[manLower objectAtIndex:plotIndex - 1] floatValue];
                int count = _loadedData.count;
                for (int i = 0; i < count; i++) {
                    [array addObject:[NSNumber numberWithFloat:point]];
                }
            }
			break;
		case 3:
            womanUpper = [_itemInfo objectForKey:@"woman"];
            if (womanUpper) {
                array = [[NSMutableArray alloc]init];
                float point = [[womanUpper objectAtIndex:plotIndex - 3] floatValue];
                int count = _loadedData.count;
                for (int i = 0; i < count; i++) {
                    [array addObject:[NSNumber numberWithFloat:point]];
                }
            }
			break;
		case 4:
            womanLower = [_itemInfo objectForKey:@"woman"];
            if (womanLower) {
                array = [[NSMutableArray alloc]init];
                float point = [[womanLower objectAtIndex:plotIndex - 3] floatValue];
                int count = _loadedData.count;
                for (int i = 0; i < count; i++) {
                    [array addObject:[NSNumber numberWithFloat:point]];
                }
            }
			break;
		default:
            
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
    NSArray *files = _loadedData.allKeys;
    NSString *filename = [files objectAtIndex:indexOfTappedXaxis];
    NSArray *datas = [_loadedData objectForKey:filename];
    NSNumber *value = [datas objectAtIndex:_indexOfSelectedItem];
    NSString *message = [NSString stringWithFormat:@"値は %@ です", value];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:filename message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
}
- (NSDictionary *)getItemInfo:(int)index {
    NSDictionary * retDic0 = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"ｇ／ｄL", @"unit",
                             @[@6.7f, @8.3f], @"man"
                             , nil];
    NSDictionary * retDic1 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｇ／ｄL", @"unit",
                              @[@3.8f, @5.3f], @"man"
                              , nil];
    NSDictionary * retDic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"",@"unit",
                              @[@1.2f, @2.0f], @"man"
                              , nil];
    NSDictionary * retDic3 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"", @"unit",
                              @[@1.36f, @2.26f], @"man"
                              , nil];
    NSDictionary * retDic4 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@57.5f, @69.2f], @"man"
                              , nil];
    NSDictionary * retDic5 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@2.0f, @3.3f], @"man"
                              , nil];
    NSDictionary * retDic6 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@5.9f, @9.7f], @"man"
                              , nil];
    NSDictionary * retDic7 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@8.0f, @12.2f], @"man"
                              , nil];
    NSDictionary * retDic8 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@11.1f, @22.0f], @"man"
                              , nil];
    NSDictionary * retDic9 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@8.0f, @22.0f], @"man"
                              , nil];
    NSDictionary * retDic10 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@0.61f, @1.04f],@"man",
                              @[@0.47f, @0.79f],@"woman"
                               , nil];
    NSDictionary * retDic11 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@3.7f, @7.0f], @"man",
                              @[@2.5f, @7.0f], @"woman"
                               , nil];
    NSDictionary * retDic12 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@130.0f, @219.0f], @"man"
                              , nil];
    NSDictionary * retDic13 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@70.0f, @139.0f], @"man"
                              , nil];
    NSDictionary * retDic14 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@40.0f, @86.0f], @"man",
                              @[@40.0f, @96.0f], @"woman"
                               , nil];
    NSDictionary * retDic15 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@35.0f, @149.0f], @"man"
                              , nil];
    NSDictionary * retDic16 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U", @"unit",
                              @[@4.0f], @"man"
                              , nil];
    NSDictionary * retDic17 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U", @"unit",
                              @[@2.0f, @12.0f], @"man"
                              , nil];
    NSDictionary * retDic18 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@0.2f, @1.1f], @"man"
                              , nil];
    NSDictionary * retDic19 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@4.0f], @"man"
                              , nil];
    NSDictionary * retDic20 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@10.0f, @40.0f], @"man"
                              , nil];
    NSDictionary * retDic21 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@5.0f, @45.0f], @"man"
                              , nil];
    NSDictionary * retDic22 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@110.0f, @360.0f], @"man"
                              , nil];
    NSDictionary * retDic23 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@30.0f, @70.0f], @"man"
                              , nil];
    NSDictionary * retDic24 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@115.0f, @245.0f],@"man"
                              , nil];
    NSDictionary * retDic25 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@235.0f, @494.0f], @"man",
                              @[@196.0f, @452.0f],@"woman"
                               , nil];
    NSDictionary * retDic26 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@75.0f], @"man",
                              @[@45.0f], @"woman"
                               , nil];
    NSDictionary * retDic27 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@50.0f, @250.0f], @"man",
                              @[@45.0f, @210.0f], @"woman"
                               , nil];
    NSDictionary * retDic28 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@37.0f, @125.0f], @"man"
                              , nil];
    NSDictionary * retDic29 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／L", @"unit",
                              @[@13.0f, @49.0f], @"man"
                              , nil];
    NSDictionary * retDic30 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@70.0f, @109.0f], @"man"
                              , nil];
    NSDictionary * retDic31 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@4.6f, @6.2f], @"man"
                              , nil];
    NSDictionary * retDic32 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍEq／L", @"unit",
                              @[@135.0f, @147.0f], @"man"
                              , nil];
    NSDictionary * retDic33 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍEq／L", @"unit",
                              @[@98.0f, @108.0f], @"man"
                              , nil];
    NSDictionary * retDic34 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍEq／L", @"unit",
                              @[@3.6f, @5.0f], @"man"
                              , nil];
    NSDictionary * retDic35 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@8.6f, @10.1f], @"man"
                              , nil];
    NSDictionary * retDic36 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@1.8f, @2.6f], @"man"
                              , nil];
    NSDictionary * retDic37 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@2.5f, @4.6f], @"man"
                              , nil];
    NSDictionary * retDic38 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"μｇ／ｄL", @"unit",
                              @[@45.0f, @200.0f],@"man",
                              @[@40.0f, @170.0f],@"woman"
                               , nil];
    NSDictionary * retDic39 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"μｇ／ｄL",@"unit",
                              @[@245.0f, @385.0f], @"man",
                              @[@265.0f, @430.0f], @"woman"
                               , nil];
    NSDictionary * retDic40 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"μｇ／ｄL", @"unit",
                              @[@110.0f, @300.0f], @"man",
                              @[@135.0f, @350.0f], @"woman"
                               , nil];
    NSDictionary * retDic41 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"",@"unit"
                              , nil];
    NSDictionary * retDic42 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｍｇ／ｄL", @"unit",
                              @[@30.0f], @"man"
                              , nil];
    NSDictionary * retDic43 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"IU／ｍL",@"unit",
                              @[@160.0f], @"man"
                              , nil];
    NSDictionary * retDic44 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"U／ｍL", @"unit",
                              @[@15.0f], @"man"
                              , nil];
    NSDictionary * retDic45 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"／μL", @"unit",
                              @[@3900.0f, @9800.0f], @"man", 
                              @[@3500.0f, @9100.0f], @"woman"
                               , nil];
    NSDictionary * retDic46 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"×１０４／μL", @"unit",
                              @[@427.0f, @570.0f], @"man",
                              @[@376.0f, @500.0f], @"woman"
                               , nil];
    NSDictionary * retDic47 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｇ／ｄL",@"unit",
                              @[@13.5f, @17.6],@"man", 
                              @[@11.3f, @15.2f], @"woman"
                               , nil];
    NSDictionary * retDic48 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@39.8f, @51.8f], @"man",
                              @[@33.4f, @44.9f], @"woman"
                               , nil];
    NSDictionary * retDic49 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｆL", @"unit",
                              @[@83.0f, @102.0f], @"man",
                              @[@79.0f, @100.0f], @"woman"
                               , nil];
    NSDictionary * retDic50 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"ｐｇ", @"unit",
                              @[@28.0f, @34.6f], @"man",
                              @[@26.3f, @34.3f],@"woman"
                               , nil];
    NSDictionary * retDic51 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@31.6f, @36.6f], @"man",
                              @[@30.7f, @36.6f],@"woman"
                               , nil];
    NSDictionary * retDic52 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"×１０４／μL", @"unit",
                              @[@13.0f, @36.9f], @"man"
                              , nil];
    NSDictionary * retDic53 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@0.0f, @3.0f], @"man"
                              , nil];
    NSDictionary * retDic54 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@0.0f, @10.0f], @"man"
                              , nil];
    NSDictionary * retDic55 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@35.0f, @73.0f], @"man"
                              , nil];
    NSDictionary * retDic56 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@0.0f, @18.0f], @"man"
                              , nil];
    NSDictionary * retDic57 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@27.0f, @72.0f], @"man"
                              , nil];
    NSDictionary * retDic58 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@20.0f, @51.0f], @"man"
                              , nil];
    NSDictionary * retDic59 = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"％", @"unit",
                              @[@2.0f, @12.0f], @"man"
                              , nil];
    NSArray * datas = [NSArray arrayWithObjects:
                       retDic0,
                       retDic1,
                       retDic2,
                       retDic3,
                       retDic4,
                       retDic5,
                       retDic6,
                       retDic7,
                       retDic8,
                       retDic9,
                       retDic10,
                       retDic11,
                       retDic12,
                       retDic13,
                       retDic14,
                       retDic15,
                       retDic16,
                       retDic17,
                       retDic18,
                       retDic19,
                       retDic20,
                       retDic21,
                       retDic22,
                       retDic23,
                       retDic24,
                       retDic25,
                       retDic26,
                       retDic27,
                       retDic28,
                       retDic29,
                       retDic30,
                       retDic31,
                       retDic32,
                       retDic33,
                       retDic34,
                       retDic35,
                       retDic36,
                       retDic37,
                       retDic38,
                       retDic39,
                       retDic40,
                       retDic41,
                       retDic42,
                       retDic43,
                       retDic44,
                       retDic45,
                       retDic46,
                       retDic47,
                       retDic48,
                       retDic49,
                       retDic50,
                       retDic51,
                       retDic52,
                       retDic53,
                       retDic54,
                       retDic55,
                       retDic56,
                       retDic57,
                       retDic58,
                       retDic59
                       , nil];
    NSDictionary * ret = [datas objectAtIndex:index];
    return ret;
}
@end
