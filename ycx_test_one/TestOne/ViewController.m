//
//  ViewController.m
//  ycx_test_one
//
//  Created by YCX on 2020/4/14.
//  Copyright © 2020 YCX. All rights reserved.
//

#import "ReactiveObjC.h"

#import "ycx_model.h"
#import "ycx_ViewModel.h"
#import "ycx_TableViewCell.h"
#import "ycx_headView.h"

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView * tableV;
@property (strong,nonatomic) UIScrollView * headScrollv;
@property (strong,nonatomic) ycx_ViewModel * vm;
@property (strong,nonatomic) NSArray * dataArr;
@property (strong,nonatomic) NSArray * headArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadTableView];
}

-(void)loadTableView{
     [self.vm setRequestPreparation];
     RACSignal * signal =  [self.vm.requestCommand execute:@"可以传入请求数据的参数"];
     [signal subscribeNext:^(NSArray *  _Nullable x) {
        //刷新ui
         self.dataArr = x[1];
         self.headArr = x[0];
         [self.tableV reloadData];
     }];
}

-(ycx_ViewModel *)vm{
    if (!_vm ){
        _vm = [[ycx_ViewModel alloc]init];
    }
    return _vm;
}


-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:SCREEN_FRAME style:UITableViewStylePlain];
        _tableV.backgroundColor = [UIColor whiteColor];
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.sectionHeaderHeight = 632.0/1125.0*SCREEN_WIDTH;
        _tableV.sectionFooterHeight = 0.1;
        //可以提前计算size 优化tableview
      //  _tableV.contentSize = CGSizeMake(SCREEN_WIDTH, <#CGFloat height#>)
        [_tableV registerClass:[ycx_TableViewCell class] forCellReuseIdentifier:@"cell"];
     //   [_tableV registerNib:[UINib nibWithNibName:@"ycxcell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:_tableV];
    }
    return _tableV;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ((ycx_ViewModel *)self.dataArr[indexPath.row]).cellHeight;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"什么时候开始走");
     ycx_headView * headview = [[ycx_headView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 632.0/1125.0*SCREEN_WIDTH)];
     [self.view addSubview:headview];
     [headview setViewAttribute:self.headArr];
    return headview;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ycx_TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.vm = self.dataArr[indexPath.row];
    return cell;
}
@end
