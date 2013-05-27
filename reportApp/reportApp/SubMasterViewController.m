//
//  SubMasterViewController.m
//  reportApp
//
//  Created by kwrsin on 2013/05/22.
//  Copyright (c) 2013年 kwrsin. All rights reserved.
//

#import "SubMasterViewController.h"

#import "DetailViewController.h"
#import "ItemCellViewController.h"
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
    }
    return self;
}
- (NSArray *)getSectionLabels {
    NSArray *labels = @[
                        @"全身",
                        @"賢臓",
                        @"脂質",
                        @"膠質",
                        @"色素",
                        @"肝臓・胆管",
                        @"心臓",
                        @"膵臓",
                        @"糖尿病",
                        @"電解質",
                        @"貧血",
                        @"炎症",
                        @"その他",
                        @"血液一般"
                        ];
    return labels;
}
- (int)toIndexFromIndexNumber:(int)section row:(int)row {
    NSArray *rows = @[
                        @(0),
                        @(9),
                        @(9 + 3),
                        @(9 + 3 + 4),
                        @(9 + 3 + 4 + 2),
                        @(9 + 3 + 4 + 2 + 2),
                        @(9 + 3 + 4 + 2 + 2 + 7),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1 + 2),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1 + 2 + 2),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1 + 2 + 2 + 6),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1 + 2 + 2 + 6 + 3),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1 + 2 + 2 + 6 + 3 + 2),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1 + 2 + 2 + 6 + 3 + 2 + 2),
                        @(9 + 3 + 4 + 2 + 2 + 7 + 1 + 2 + 2 + 6 + 3 + 2 + 2 + 15)
                        ];
    int index = [[rows objectAtIndex:section] integerValue] + row;
    return index;
    
}
- (NSArray *)getLabels {
    NSArray *labels = @[
                        @"総蛋白[ｇ／ｄL]",
                        @"アルブミン[ｇ／ｄL]",
                        @"A/G比",
                        @"A/G比",
                        @"蛋白分画-アルブミン[％]",
                        @"蛋白分画-α１‐Globulin[％]",
                        @"蛋白分画-α２‐Globulin[％]",
                        @"蛋白分画-β‐Globulin[％]",
                        @"蛋白分画-γ‐Globulin[％]",
                        @"尿素窒素[ｍｇ／ｄL]",
                        @"クレアチニン[ｍｇ／ｄL]",
                        @"尿酸[ｍｇ／ｄL]",
                        @"総コレステロール[ｍｇ／ｄL]",
                        @"LDLコレステロール[ｍｇ／ｄL]",
                        @"HDLコレステロール[ｍｇ／ｄL]",
                        @"中性脂肪[ｍｇ／ｄL]",
                        @"チモール（TTT）[U]",
                        @"クンケル（ZTT）[U]",
                        @"総ビリルビン[ｍｇ／ｄL]",
                        @"直接ビリルビン[ｍｇ／ｄL]",
                        @"AST（GOT）[U／L]",
                        @"ALT（GPT）[U／L]",
                        @"ALP[U／L]",
                        @"LAP[U／L]",
                        @"LD(LDH)[U／L]",
                        @"コリンエスレラーゼ[U／L]",
                        @"γ‐GT（γ‐GTP）[U／L]",
                        @"CK[U／L]",
                        @"アミラーゼ[U／L]",
                        @"リパーゼ[U／L]",
                        @"血唐[ｍｇ／ｄL]",
                        @"HbA１ｃ（NGSP）[％]",
                        @"ナトリウム[ｍEq／L]",
                        @"クロール[ｍEq／L]",
                        @"カリウム[ｍEq／L]",
                        @"カルシウム[ｍｇ／ｄL]",
                        @"マグネシウム[ｍｇ／ｄL]",
                        @"無機リン[ｍｇ／ｄL]",
                        @"血清鉄[μｇ／ｄL]",
                        @"TIBC[μｇ／ｄL]",
                        @"UIBC[μｇ／ｄL]",
                        @"CRP定性",
                        @"CRP定量[μｇ／ｄL]",
                        @"ASO[IU／ｍL]",
                        @"RF定量[U／ｍL]",
                        @"白血球数[／μL]",
                        @"赤血球数[X１０４／μL]",
                        @"血色素数[ｇ／ｄL]",
                        @"ヘマトクリット[％]",
                        @"MCV[fL]",
                        @"MCH[ｐｇ]",
                        @"MCHC[％]",
                        @"血小板[X１０４／μL]",
                        @"白血球像-好塩基球[％]",
                        @"白血球像-好酸球[％]",
                        @"白血球像-好中球[％]",
                        @"白血球像-桿状核球[％]",
                        @"白血球像-分葉核球[％]",
                        @"白血球像-リンパ球[％]",
                        @"白血球像-単球[％]"
                        ];
    return labels;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName = [[self getSectionLabels] objectAtIndex:section];
    return sectionName;
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
    for (int i = 0; i < count; i++) {
        NSMutableDictionary * item = [NSMutableDictionary dictionaryWithCapacity:2];
        [item setValue:[labels objectAtIndex:i] forKey:@"label"];
        if (i < data.count) {
            [item setValue:[data objectAtIndex:i] forKey:@"data"];
        } else {
            [item setValue:@"" forKey:@"data"];
        }
        [_objects addObject:item];
    }
    [self.tableView reloadData];//画面表示を更新しますで
    
    NSString *filename = _filename;
    NSString *work = [filename stringByReplacingOccurrencesOfString:@".dat" withString:@""];
    NSString *label = [NSString stringWithFormat:@"データ(%@)", work];
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
    NSArray *labels = [self getSectionLabels];
    int count = labels.count;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int beforerow = [self toIndexFromIndexNumber:section row:0];
    int row = [self toIndexFromIndexNumber:section + 1 row:0];
    int count = row - beforerow;
    
    return count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    ItemCellViewController *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UIViewController * vc;
        vc = [[UIViewController alloc]initWithNibName:@"ItemCell" bundle:nil];
        cell = (ItemCellViewController *)vc.view;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSDictionary *object = _objects[[self toIndexFromIndexNumber:indexPath.section row:indexPath.row]];
//    cell.textLabel.text = [object description];
    cell.itemLabel.text = [object objectForKey:@"label"];
    cell.valueLabel.text = [object objectForKey:@"data"];
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
    NSMutableDictionary *object = _objects[[self toIndexFromIndexNumber:indexPath.section row:indexPath.row]];
    NSString *dItem = [object objectForKey:@"label"];
    self.detailViewController.detailItem = dItem;
    self.detailViewController.indexPath = indexPath;
    self.detailViewController.subMasterViewController = self;
    NSMutableArray *arr = [_loadedData objectForKey:_filename];
    int index = [self toIndexFromIndexNumber:indexPath.section row:indexPath.row];
    NSString *value = [arr objectAtIndex:
                       index];
    self.detailViewController.value = value;
    self.detailViewController.indexOfSelectedItem = index;
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}
- (void)reflect:(NSIndexPath*)indexPath value:(NSString*)value {
    ItemCellViewController *cell = (ItemCellViewController *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    cell.valueLabel.text = value;
    
    NSMutableArray * arr = [self.loadedData objectForKey:_filename];
    [arr replaceObjectAtIndex:
     [self toIndexFromIndexNumber:indexPath.section row:indexPath.row] withObject:value];
    dataManager *dm = [[dataManager alloc]init];
    [dm removeFile:_filename];
    [dm saveFile:_filename dataList:arr];
    
    // 詳細画面が再表示されるとき最新の更新値を設定していないと、
    // グラフ画面から詳細画面に戻るときに過去の残骸が表示される
    self.detailViewController.value = value;
}

@end
