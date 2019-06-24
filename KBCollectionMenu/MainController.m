//
//  MainController.m
//  KBCollectionMenu
//
//  Created by 肖雄 on 17/6/29.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "MainController.h"
#import "KBButtonCollectionItem.h"
#import "KBValue1CollectionItem.h"

@interface MainController ()

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.collectionView.editing = YES;
    
    self.view.backgroundColor = [UIColor purpleColor];
    self.enableItemReorderingGestures = YES;
    
    KBButtonCollectionItem *item1 = [[KBButtonCollectionItem alloc] initWithTitle:@"item1" action:NULL];
    KBButtonCollectionItem *item2 = [[KBButtonCollectionItem alloc] initWithTitle:@"item2" action:NULL];
    KBButtonCollectionItem *item3 = [[KBButtonCollectionItem alloc] initWithTitle:@"item3" action:NULL];
    KBButtonCollectionItem *item4 = [[KBButtonCollectionItem alloc] initWithTitle:@"item4" action:NULL];
    KBButtonCollectionItem *item5 = [[KBButtonCollectionItem alloc] initWithTitle:@"item5" action:NULL];
    
    KBValue1CollectionItem *item6 = [[KBValue1CollectionItem alloc] initWithTitle:@"item6" detail:@"detail"];
    KBValue1CollectionItem *item7 = [[KBValue1CollectionItem alloc] initWithTitle:@"item7" detail:@"detail"];
    KBValue1CollectionItem *item8 = [[KBValue1CollectionItem alloc] initWithTitle:@"item8" detail:@"detail"];

    item6.detailText = @"ashdjfasdfaksjdflasdjkfasdfwieorwreerqwerwer";
    item6.breakLine = YES;
    item6.detailFont = [UIFont systemFontOfSize:20];
    item6.detailColor = [UIColor redColor];
    
    KBCollectionMenuSection *section = [[KBCollectionMenuSection alloc] initWithItems:@[item1, item2, item3, item4, item5, item6, item7, item8]];
    [self.menuSections addSection:section];
}


@end
