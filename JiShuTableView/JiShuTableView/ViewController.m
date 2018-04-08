//
//  ViewController.m
//  WH -- Demo7
//
//  Created by 邱荣贵 on 2018/4/2.
//  Copyright © 2018年 邱久. All rights reserved.
//

#import "ViewController.h"
#import "TableView.h"
#import "UIView+Frame.h"

#define  H 200
#define titleH 44
#define  Nav 64
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate>{
    
    UIButton *selectedBut;
    
}


/** <#name#>*/
@property (nonatomic,strong) UIScrollView *scro;

/** <#name#>*/
@property (nonatomic,strong) UIView *header;

/** <#name#>*/
@property (nonatomic,assign) NSInteger  selectorIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    
    UIScrollView *scro = [[UIScrollView alloc] initWithFrame:CGRectMake(0,Nav, WIDTH, HEIGHT -  Nav)];
    scro.contentSize = CGSizeMake(WIDTH * 3, HEIGHT);
    scro.delegate = self;
    scro.pagingEnabled = YES;
    scro.bounces = NO;
    [self.view addSubview:scro];
    self.scro = scro;
    
    
    UIView *aView = [UIView new];
    aView.width = WIDTH;
    aView.height = 244;
    
    
    TableView *table1 = [[TableView alloc] init];
    table1.frame = CGRectMake(0, 0, WIDTH, HEIGHT - Nav);
    table1.delegate = self;
    [scro addSubview:table1];
    table1.tableHeaderView = aView;
    
    TableView *table2 = [[TableView alloc] init];
    table2.frame = CGRectMake(WIDTH, 0, WIDTH, HEIGHT - Nav);
    table2.delegate = self;
    [scro addSubview:table2];
    table2.tableHeaderView = aView;

    TableView *table3 = [[TableView alloc] init];
    table3.frame = CGRectMake(WIDTH * 2, 0, WIDTH, HEIGHT - Nav);
    table3.delegate = self;
    [scro addSubview:table3];
    table3.tableHeaderView = aView;

    UIView *header = [UIView new];
    header.frame = CGRectMake(0, Nav, WIDTH, H + titleH);
    header.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:header];
    self.header = header;
    
    NSArray *array = @[@"title1",@"title2",@"title3"];

    for(int i =0 ;i < array.count; i++){
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(WIDTH / 3 * i, 200, WIDTH / 3, titleH);
        but.backgroundColor = [UIColor greenColor];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [but setTitle:array[i] forState:UIControlStateNormal];
        but.tag = i;
        [but addTarget:self action:@selector(cliek:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:but];
        if(i == 0){
            [self cliek:but];
        }
    }
    
}

- (void)cliek:(UIButton *)sends{
    
    selectedBut.selected = NO;
    selectedBut = sends;
    sends.selected = YES;
    
    self.selectorIndex = sends.tag;
    
    [self.scro setContentOffset:CGPointMake(WIDTH* sends.tag, 0) animated:YES];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(self.scro == scrollView){
    
        CGFloat off = scrollView.contentOffset.x;

        int index = off / WIDTH;
        
        [self cliek:_header.subviews[index]];
        
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGFloat offy = scrollView.contentOffset.y;
    CGFloat origenY = 0;
    CGFloat otherOffsetY = 0;

    if(scrollView == self.scro){
        
        return;
    }

    if(offy<= H){
        
        origenY = - offy;
        if(offy < 0){
            otherOffsetY = 0;
        }else{
            otherOffsetY = offy;
        }
        
    }else{
        origenY = - H;
        otherOffsetY = H;
    }
    
    self.header.frame = CGRectMake(0, origenY + Nav, WIDTH, H + titleH);
    
    for(int i = 0;i < 3;i ++){

        if(i != self.selectorIndex){
            
            UITableView *table = self.scro.subviews[i];
            
            if([table isKindOfClass:[UITableView class]]){
                
                if(0<= offy && offy<H){
                    
                    [table setContentOffset:CGPointMake(0, otherOffsetY) animated:NO];
                    
                }
            }
        }
      
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
