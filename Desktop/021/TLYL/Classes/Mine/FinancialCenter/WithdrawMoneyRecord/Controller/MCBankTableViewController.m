//
//  MCBankTableViewController.m
//  TLYL
//
//  Created by miaocai on 2017/7/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCBankTableViewController.h"

@interface MCBankTableViewController ()

@property (nonatomic,strong) NSMutableArray *bankArray;

@end

@implementation MCBankTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MCBankTableViewController"];
    [self loadDataAndShow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadDataAndShow{
    for (NSInteger i = 0; i< 10; i++) {
        [self.bankArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.bankArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MCBankTableViewController"];
    
    cell.textLabel.text = self.bankArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str =  self.bankArray[indexPath.row];
    
    if (self.bankTableViewDidselectedBlock) {
        self.bankTableViewDidselectedBlock(str);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSMutableArray *)bankArray{
    if (_bankArray == nil) {
        _bankArray = [NSMutableArray array];
    }
    return _bankArray;
}


@end
