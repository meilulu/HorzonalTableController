//
//  HorizonalController.m
//  
//
//  Created by ShareAnimation on 16/5/27.
//
//

#import "HorizonalController.h"

@interface HorizonalController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *pictures;
@end

@implementation HorizonalController

- (instancetype)initWithPictures:(NSArray *)pictures{
    self = [super init];
    if (self) {
        self.pictures = [NSMutableArray new];
        self.pictures = [NSMutableArray arrayWithArray:pictures];
        [self.pictures insertObject:pictures[pictures.count-1] atIndex:0];
        [self.pictures addObject:pictures[0]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView = [UITableView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.pagingEnabled = YES;
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.frame = self.view.bounds;
     [self.view addSubview:self.tableView];
    if (self.pictures.count<=3) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
         self.tableView.bounces = YES;
    }else{
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*0.85);
    //表示有几页，即几个指示点
    self.pageControl.numberOfPages = self.pictures.count-2;
    //当前页面的indicator的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //默认的indicator的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:self.pageControl];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTapAction)]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pictures.count<=3?1:self.pictures.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.bounds.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:self.pictures[indexPath.row]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        [imageView addSubview:label];
        [cell.contentView addSubview:imageView];

    return cell;
}

//停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.pictures.count<=3) return;
    
    NSInteger page = scrollView.contentOffset.y/self.view.bounds.size.width;
    if (page<self.pictures.count-1) {
        self.pageControl.currentPage = page-1;
    }
    else{
        //如果不在滚动停止时调用，你再这个方法后跑到了第一个cell，但是滚动还继续，所以会自动滚动到第二cell，要注意。
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        self.pageControl.currentPage = 0;
    }
    
    if (page==0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.pictures.count-2 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        self.pageControl.currentPage = self.pictures.count;
    }
    

}

- (void)doTapAction{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
