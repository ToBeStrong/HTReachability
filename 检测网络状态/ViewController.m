//
//  ViewController.m
//  检测网络状态
//
//  Created by sunchunlei on 15/12/1.
//  Copyright (c) 2015年 womai. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *netLabel;

@property (nonatomic, strong) Reachability *reachabilityManager;

@end

@implementation ViewController

- (Reachability *)reachabilityManager{
    
    if (_reachabilityManager == nil) {
        
        _reachabilityManager = [Reachability reachabilityWithHostName:@"m.womai.com"];
                                
    }
    return _reachabilityManager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkStatus) name:kReachabilityChangedNotification object:nil];
    
    [self.reachabilityManager startNotifier];
}

- (void)dealloc{
    
    [self.reachabilityManager stopNotifier];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)checkStatus{
    
    NSString *netStr = nil;
    switch ([self.reachabilityManager currentReachabilityStatus]) {
        case NotReachable:

            netStr = @"网络不可用";
            break;
        case ReachableViaWiFi:

            netStr = @"网络WIFI";
            break;
        case ReachableViaWWAN:

            netStr = @"网络2G/3G/4G";
            break;
        case kReachableVia2G:

            netStr = @"网络2G";
            break;
        case kReachableVia3G:

            netStr = @"网络3G";
            break;
        case kReachableVia4G:

            netStr = @"网络4G";
            break;
        default:
            break;
    }

    NSLog(@"%@",netStr);
    self.netLabel.text = netStr;
    
}


@end
