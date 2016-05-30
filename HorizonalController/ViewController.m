//
//  ViewController.m
//  HorizonalController
//
//  Created by ShareAnimation on 16/5/30.
//  Copyright © 2016年 爱丽丝的梦境. All rights reserved.
//

#import "ViewController.h"
#import "HorizonalController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    HorizonalController *vc = [[HorizonalController alloc]  initWithPictures:@[@"111",@"22"]];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
    //    HorizonalController *vc = [[HorizonalController alloc] initWithPictures:@[@"111",@"22"]];
    //    [self presentViewController:vc  animated:NO completion:nil];
    //    [self.navigationController pushViewController:[[HorizonalController alloc] initWithPictures:@[@"111",@"22"]]  animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
