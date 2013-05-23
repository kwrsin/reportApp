//
//  SubMasterViewController.m
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import "SubMasterViewController.h"

#import "DetailViewController.h"
#import "dataManager.h"
#import "Consts.h"

@interface SubMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation SubMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"項目", @"SubMaster");
    }
    return self;
}
- (NSArray *)getLabels {
    NSArray *labels = @[
                        @"総蛋白",
                        @"アルブミン",
                        @"尿素窒素",
                        @"クレアチニン",
                        @"尿酸",
                        @"総コレステロール",
                        @"中性脂肪",
                        @"総ビリルビン",
                        @"AST（GOT）",
                        @"ALT（GPT）",
                        @"ALP",
                        @"LD(LDH)",
                        @"コリンエスレラーゼ",
                        @"γ‐GT（γ‐GTP）",
                        @"アミラーゼ",
                        @"血唐",
                        @"ナトリウム",
                        @"クロール",
                        @"カリウム",
                        @"カルシウム",
                        @"白血球数",
                        @"赤血球数",
                        @"血色素数",
                        @"ヘマトクリット",
                        @"MCV",
                        @"MCH",
                        @"MCHC",
                        @"血小板",
                        @"好塩基球",
                        @"好酸球",
                        @"好中球",
                        @"リンパ球",
                        @"単球"
                        ];
    return labels;
}
//この画面の表示が始まるとき呼ばれますで
- (void)viewWillAppear:(BOOL)animated {
    
    NSArray *labels = [self getLabels];
    int count = labels.count;
    NSMutableArray * data = [_loadedData objectForKey:_filename];
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects removeAllObjects];
    NSString * item;
    for (int i = 0; i < count; i++) {
        if (i < data.count) {
            item = [NSString stringWithFormat:
                    @"%@  %@",
                    [labels objectAtIndex:i],
                    [data objectAtIndex:i]];
        } else {
            item = [NSString stringWithFormat:
                    @"%@",
                    [labels objectAtIndex:i]];
            
            // ダミーのデータを強制的に作る
            [data addObject:@""];
        }
        [_objects addObject:item];
    }
    [self.tableView reloadData];//画面表示を更新しますで
    
    NSString *filename = _filename;
    NSString *label = [filename stringByReplacingOccurrencesOfString:@".dat" withString:@""];
    self.title = NSLocalizedString(label, @"SubMaster");
    [super viewWillAppear:animated];
}
// 作成時一回しか呼ばれまへんで
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
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    NSDate *object = _objects[indexPath.row];
    self.detailViewController.detailItem = object;
    self.detailViewController.indexPath = indexPath;
    self.detailViewController.subMasterViewController = self;
    NSMutableArray *arr = [_loadedData objectForKey:_filename];
    NSString *value = [arr objectAtIndex:indexPath.row];
    self.detailViewController.value = value;
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (void)reflect:(NSIndexPath*)indexPath value:(NSString*)value {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    NSDate *object = _objects[indexPath.row];
    NSString * item = [NSString stringWithFormat:
                       @"%@  %@",
                       object,
                       value];
    
    cell.textLabel.text = item;
    
    NSMutableArray * arr = [self.loadedData objectForKey:_filename];
    [arr replaceObjectAtIndex:indexPath.row withObject:value];
    dataManager *dm = [[dataManager alloc]init];
    [dm removeFile:_filename];
    [dm saveFile:_filename dataList:arr];
}

@end
