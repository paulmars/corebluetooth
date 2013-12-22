//
//  BMViewController.h
//  corebeacon
//
//  Created by Paul McKellar on 12/22/13.
//  Copyright (c) 2013 Paul McKellar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BMViewController : UIViewController <CBPeripheralManagerDelegate, CBCentralManagerDelegate>

@end
