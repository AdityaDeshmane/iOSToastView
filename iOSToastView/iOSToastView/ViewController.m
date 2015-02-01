//
//  ViewController.m
//  iOSToastView
//
//  Created by Aditya Deshmane on 02/02/15.
//  Copyright (c) 2015 Aditya Deshmane. All rights reserved.
//

#import "ViewController.h"
#import "ADToastView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}


- (IBAction)btnShowToastPressed:(id)sender
{
    ADToastView *toastView = [[ADToastView alloc] initToastWithMessage:@"Test Toast Message"];
    [toastView show];
}

@end
