//
//  BMViewController.m
//  corebeacon
//
//  Created by Paul McKellar on 12/22/13.
//  Copyright (c) 2013 Paul McKellar. All rights reserved.
//

#import "BMViewController.h"

@interface BMViewController () {
    CBPeripheralManager *peripheralManager;
    CBCentralManager *centralManager;
    NSString *identifier;
}

@end

@implementation BMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    identifier = @"56C05E76-EBD9-4FAE-A557-4272DE5DA3DC";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)advirtaise:(id)sender
{
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
}

- (IBAction)search:(id)sender
{
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    NSLog(@"did update state %@", peripheral);
    if(peripheral.state==CBPeripheralManagerStatePoweredOn) {
        NSLog(@"start broadcasting");
        NSDictionary *advertisingData = @{CBAdvertisementDataLocalNameKey:@"my-peripheral",
                                          CBAdvertisementDataServiceUUIDsKey:@[[CBUUID UUIDWithString:identifier]]};

        [peripheralManager startAdvertising:advertisingData];
    }
    else
    {
        NSLog(@"perf: something else");
    }
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSLog(@"did update central manager %@", central);
    if(central.state==CBCentralManagerStatePoweredOn)
    {
        NSLog(@"start searching");
        NSDictionary *scanOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)};
        NSArray *services = @[[CBUUID UUIDWithString:identifier]];

        [centralManager scanForPeripheralsWithServices:services options:scanOptions];
    }
    else
    {
        NSLog(@"something else");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"RSSI: %d", [RSSI intValue]);
    UILabel *label = (UILabel *)[self.view viewWithTag:10];
    label.text = [NSString stringWithFormat:@"RSSI %i", [RSSI intValue]];
}

@end
