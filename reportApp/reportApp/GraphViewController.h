//
//  GraphViewController.h
//  reportApp
//
//  Created by kwrsin on 2013/05/24.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "S7GraphView.h"

@interface GraphViewController : UIViewController <S7GraphViewDataSource,S7GraphViewDelegate,UIScrollViewDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) S7GraphView *graphView;
@property (strong, nonatomic) NSString *selectedItem;
@property (assign, nonatomic) int indexOfSelectedItem;
@property (strong, nonatomic) NSMutableDictionary *loadedData;

@end
