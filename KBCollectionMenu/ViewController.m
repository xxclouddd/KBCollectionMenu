//
//  ViewController.m
//  KBCollectionMenu
//
//  Created by 肖雄 on 17/3/13.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "ViewController.h"
#import "MainController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushHandle:(id)sender {
    
    MainController *con = [[MainController alloc] init];
    [self.navigationController pushViewController:con animated:YES];    
}

@end
