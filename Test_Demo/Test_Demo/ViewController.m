//
//  ViewController.m
//  Test_Demo
//
//  Created by 李李江 on 2019/1/15.
//  Copyright © 2019 李李江. All rights reserved.
//

#import "ViewController.h"
#import "DateModel.h"
#import "ScrollBarView.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tabView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UICollectionViewFlowLayout *layout = _collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(100, 300);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    ScrollBarView *barView = [[UINib nibWithNibName:@"ScrollBarView" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    barView.direction = ScrollBarViewDirectionVertical;
    barView.parasiticScrollView = _tabView;
    barView.contentSize = CGSizeMake(0, 1000);
    barView.frame = CGRectMake(self.view.frame.size.width - 20, 20, 20, _tabView.frame.size.height);
    [barView drawView];
    [self.view addSubview:barView];
    
    ScrollBarView *barView1 = [[UINib nibWithNibName:@"ScrollBarView" bundle:nil] instantiateWithOwner:nil options:nil].firstObject;
    barView1.direction = ScrollBarViewDirectionHorizontal;
    barView1.parasiticScrollView = _collectionView;
    barView1.contentSize = CGSizeMake(2000, 0);
    barView1.frame = CGRectMake(0, CGRectGetMaxY(_tabView.frame), self.view.frame.size.width, 20);
    [barView1 drawView];
    [self.view addSubview:barView1];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = indexPath.row%2==0?[UIColor redColor]:[UIColor greenColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"cellid"];
    }
    cell.backgroundColor = indexPath.row%2==0?[UIColor redColor]:[UIColor greenColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
