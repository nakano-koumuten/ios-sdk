//
//  IRSamplesTableViewController.m
//  IRKit
//
//  Created by Masakazu Ohtsuka on 2013/07/25.
//  Copyright (c) 2013年 KAYAC Inc. All rights reserved.
//

#import "IRSamplesTableViewController.h"
#import "IRNewPeripheralScene1ViewController.h"
#import "IRNewPeripheralScene2ViewController.h"
#import "IRNewPeripheralScene3ViewController.h"
#import "IRNewSignalScene1ViewController.h"
#import "IRSignal.h"
#import "IRSignalCell.h"

@interface IRSamplesTableViewController ()

@end

@implementation IRSamplesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    NSBundle *main = [NSBundle mainBundle];
    NSBundle *resources = [NSBundle bundleWithPath:[main pathForResource:@"IRKitResources"
                                                                  ofType:@"bundle"]];
    [self.tableView registerNib:[UINib nibWithNibName:@"IRSignalCell" bundle:resources]
         forCellReuseIdentifier:@"IRSignalCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IRNewPeripheralScene1ViewControllerDelegate
#pragma mark - IRNewSignalScene1ViewControllerDelegate

//  TODO merge all callbacks into a single IRViewController:didFinishWithInfo: message?
- (void)scene1ViewController:(id)viewController didFinishWithInfo:(NSDictionary*)info {
    LOG_CURRENT_METHOD;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IRNewPeripheralScene2ViewControllerDelegate

- (void)scene2ViewController:(IRNewPeripheralScene2ViewController *)viewController didFinishWithInfo:(NSDictionary*)info {
    LOG_CURRENT_METHOD;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IRNewPeripheralScene3ViewControllerDelegate

- (void)scene3ViewController:(IRNewPeripheralScene3ViewController *)viewController didFinishWithInfo:(NSDictionary*)info {
    LOG_CURRENT_METHOD;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return [tableView dequeueReusableCellWithIdentifier:@"IRNewPeripheralScene1"];
        case 1:
            return [tableView dequeueReusableCellWithIdentifier:@"IRNewPeripheralScene2"];
        case 2:
            return [tableView dequeueReusableCellWithIdentifier:@"IRNewPeripheralScene3"];
        case 3:
            return [tableView dequeueReusableCellWithIdentifier:@"IRNewSignalScene1"];
        case 4:
        {
            IRSignalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IRSignalCell"];

            unsigned short data[10] = { 100,100,100,100,100,100,100,100,100,100 };
            NSData *irdata = [NSData dataWithBytes:data length:10];
            IRSignal *signal = [[IRSignal alloc] initWithData: irdata];

            [cell inflateFromSignal:signal];
            return cell;
        }
        case 5:
        default:
            return [tableView dequeueReusableCellWithIdentifier:@"IRNewSignalScene1"];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 4:
            return [IRSignalCell height];

        default:
            return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LOG_CURRENT_METHOD;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    NSBundle *main = [NSBundle mainBundle];
    NSBundle *resources = [NSBundle bundleWithPath:[main pathForResource:@"IRKitResources" ofType:@"bundle"]];
    switch (indexPath.row) {
        case 0:
        {
            IRNewPeripheralScene1ViewController *c = [[IRNewPeripheralScene1ViewController alloc] initWithNibName:@"IRNewPeripheralScene1ViewController"
                                                                                                           bundle:resources];
            c.delegate = self;

            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 1:
        {
            IRNewPeripheralScene2ViewController *c = [[IRNewPeripheralScene2ViewController alloc] initWithNibName:@"IRNewPeripheralScene2ViewController"
                                                                                                           bundle:resources];
            c.delegate = self;

            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 2:
        {
            IRNewPeripheralScene3ViewController *c = [[IRNewPeripheralScene3ViewController alloc] initWithNibName:@"IRNewPeripheralScene3ViewController"
                                                                                                           bundle:resources];
            c.delegate = self;

            [self.navigationController pushViewController:c animated:YES];
        }
            break;
        case 3:
        default:
        {
            IRNewSignalScene1ViewController *c = [[IRNewSignalScene1ViewController alloc] initWithNibName:@"IRNewSignalScene1ViewController"
                                                                                                   bundle:resources];
            c.delegate = self;

            [self.navigationController pushViewController:c animated:YES];
        }
            break;
    }
}

@end