//
//  ItemCellViewController.h
//  reportApp
//
//  Created by kwrsin on 2013/05/28.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCellViewController : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end
