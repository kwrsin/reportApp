
#import "Consts.h"
#import "dataManager.h"
#import "FileHelper.h"

@implementation dataManager
- (id)init {
    if (self = [super init]) {
        fh = [[FileHelper alloc]init];
    }
    return self;
}
- (NSMutableDictionary *)loadDataFromFiles {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(
//                                                         NSDocumentDirectory,
//                                                         NSUserDomainMask, YES);
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent: DOC_DIR];
    NSMutableDictionary *loadedDatas = [[NSMutableDictionary alloc]init];
    
    NSArray *fileNames = [fh fileNamesAtDirectoryPath:directory extension:CMT];
    for (NSString *fn in fileNames) {
        NSString *filePath = [directory stringByAppendingPathComponent:fn];
        // nsmutableCopyでハマった
        NSMutableArray *array = [[NSKeyedUnarchiver unarchiveObjectWithFile:filePath] mutableCopy];
        if (!array) {
            array = [NSMutableArray array];
            
        }
        [loadedDatas setValue:array forKey:fn];
    }
    return loadedDatas;
}
- (void)removeAllFiles {
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent: DOC_DIR];
    NSArray *fileNames = [fh fileNamesAtDirectoryPath:directory extension:CMT];
    for (NSString *fn in fileNames) {
        [self removeFile:fn];
    }
    return;
}
- (void)removeFile:(NSString *)fileName {
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent: DOC_DIR];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    BOOL ret = [fh removeFilePath:filePath];
    if (ret) {
        NSLog(@"%@", @"データの削除に成功しました。");
    }else {
        NSLog(@"%@", @"データの削除に失敗しました。");
    }
    
    return;
}
- (void)createFile {
//    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:DOC_DIR];
//    NSDateFormatter *outputDateFormatter = [[NSDateFormatter alloc] init];
//	NSString *outputDateFormatterStr = @"yyyy-MM-dd-HH_mm_ss";
//	[outputDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
//	[outputDateFormatter setDateFormat:outputDateFormatterStr];
//	NSString *newFileName = [NSString stringWithFormat:@"%@.dat",
//                             [outputDateFormatter stringFromDate:[NSDate date]]];
//    NSString *filePath = [directory stringByAppendingPathComponent:newFileName];
//    
//    NSArray *array = @[@"山田太郎", @"東京都中央区"];
//    BOOL successful = [NSKeyedArchiver archiveRootObject:array toFile:filePath];
//    if (successful) {
//        NSLog(@"%@", @"データの保存に成功しました。");
//    }else {
//        NSLog(@"%@", @"データの保存に失敗しました。");
//    }
}
- (void)saveFile:(NSString *)fileName dataList:(NSMutableArray *)dataList {
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:DOC_DIR];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    
    [NSKeyedArchiver archiveRootObject:dataList toFile:filePath];
}
@end
