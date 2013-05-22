//
//  dataManager.h
//  dataManager
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FileHelper;

@interface dataManager : NSObject
{
    FileHelper* fh;
}
- (NSMutableDictionary *)loadDataFromFiles;
- (void)removeAllFiles;
- (void)removeFile:(NSString *)fileName;
- (void)createFile;
- (void)saveFile:(NSString *)fileName dataList:(NSMutableArray *)dataList;
@end
