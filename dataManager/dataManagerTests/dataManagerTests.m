//
//  dataManagerTests.m
//  dataManagerTests
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import "dataManagerTests.h"
#import "dataManager.h"
#import "Consts.h"

@interface dataManagerTests()
{
    dataManager *dm;
}
@end

@implementation dataManagerTests

- (void)setUp
{
    [super setUp];
    dm = [[dataManager alloc]init];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

//- (void)testExample
//{
//    STFail(@"Unit tests are not implemented yet in dataManagerTests");
//}
//
- (void)testLoadDataFromFiles {
    NSMutableArray *bbb = @[@"あ",@"い",@"う",@"え"];
    NSMutableArray *aaa = @[@"こ",@"れ",@"は",@"何"];
    [dm saveFile:@"aaa.dat" dataList:aaa];
    [dm saveFile:@"bbb.dat" dataList:bbb];
    
    NSDictionary *loadedData = [dm loadDataFromFiles];
    NSMutableArray *revA = [loadedData objectForKey:@"aaa.dat"];
    NSMutableArray *revB = [loadedData objectForKey:@"bbb.dat"];
    for (NSString *a in revA) {
        NSLog(@"%@", a);
    }
    for (NSString *b in revB) {
        NSLog(@"%@", b);
    }
    [dm removeAllFiles];
    return;
}
@end
