//
//  TableView.m
//  WH -- Demo7
//
//  Created by 邱荣贵 on 2018/4/2.
//  Copyright © 2018年 邱久. All rights reserved.
//

#import "TableView.h"

@interface TableView ()<UITableViewDataSource>

@end

@implementation TableView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
     
        self.dataSource = self;
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cell = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell];
    }
    
    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld= = ",indexPath.row];
    
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
