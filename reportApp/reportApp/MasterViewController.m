//
//  MasterViewController.m
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import "MasterViewController.h"

#import "SubMasterViewController.h"
#import "dataManager.h"
#import "Consts.h"
#import "RenameViewController.h"


@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"検査結果報告", @"Master");
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self readData];

}
-(void)readData {
    if (!dm) {
        dm = [[dataManager alloc]init];
    }
    _loadedData = [dm loadDataFromFiles];
    _objects = [NSMutableArray arrayWithArray:
                [[_loadedData allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)insertNewObject:(id)sender
{
    if (!self.renameViewController) {
        self.renameViewController = [[RenameViewController alloc] initWithNibName:@"RenameViewController" bundle:nil];
    }
    
//    self.DetailViewController.indexOfSelectedItem = self.indexOfSelectedItem;
//    self.DetailViewController.selectedItem = [self cutTail:self.detailItem];
    self.renameViewController.objects = _objects;
    self.renameViewController.dm = dm;
    
    self.renameViewController.masterViewController = self;
    [self.navigationController pushViewController:self.renameViewController animated:YES];

}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }


    NSDate *object = _objects[indexPath.row];
    NSString *filename = [object description];
    NSString *label = [filename stringByReplacingOccurrencesOfString:@".dat" withString:@""];
    cell.textLabel.text = label;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *fileName = [_objects objectAtIndex:indexPath.row];
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_loadedData removeObjectForKey:fileName];
        [dm removeFile:fileName];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.subMasterViewController) {
        self.subMasterViewController = [[SubMasterViewController alloc] initWithNibName:@"SubMasterViewController" bundle:nil];
    }
    NSDate *object = _objects[indexPath.row];
    self.subMasterViewController.filename = object;
    self.subMasterViewController.loadedData = _loadedData;
    
    [self.navigationController pushViewController:self.subMasterViewController animated:YES];
}
- (void)refleshData {
    [self readData];
    [self.tableView reloadData];
}
- (void)gotoSubmenu4newData:(NSString *)filename {
    [self refleshData];
    NSArray *keys = [[_loadedData allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    int cnt = 0;
    for (NSString* key in keys) {
        if ([key isEqualToString:filename]) {
            break;
        }
        cnt++;
    }
    if (!self.subMasterViewController) {
        self.subMasterViewController = [[SubMasterViewController alloc] initWithNibName:@"SubMasterViewController" bundle:nil];
    }
    NSDate *object = _objects[cnt];
    self.subMasterViewController.filename = object;
    self.subMasterViewController.loadedData = _loadedData;
    
    [self.navigationController pushViewController:self.subMasterViewController animated:YES];
}
@end
