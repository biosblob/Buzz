//
//  ViewController.m
//  Buzz
//
//  Created by Conner Bender on 12/11/13.
//  Copyright (c) 2013 Conner Bender. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "BluetoothOff.h"
#import "CSAnimationView.h"

@interface ViewController () {

BOOL hasCompletedBluetooth;

}

@end

@implementation ViewController
    
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    // Create a NSUUID object
    NSUUID *uuidSend = [[NSUUID alloc] initWithUUIDString:@"50F12572-1F61-4846-AB23-2E5325C8DCF3"];
    
    // Initialize the Beacon Region
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidSend
                                                                  major:1
                                                                  minor:1
                                                             identifier:@"com.connerbender.area"];
    
    // Initialize location manager and set ourselves as the delegate
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Create a NSUUID with the same UUID as the broadcasting beacon
    NSUUID *uuidReceive = [[NSUUID alloc] initWithUUIDString:@"50F12572-1F61-4846-AB23-2E5325C8DCF3"];
    
    // Setup a new region with that UUID and same identifier as the broadcasting beacon
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuidReceive
                                                             identifier:@"com.connerbender.area"];
    
    // Tell location manager to start monitoring for the beacon region
    [self.locationManager startMonitoringForRegion:self.myBeaconRegion];
    
    // Check if beacon monitoring is available for this device
    //if (![CLLocationManager isMonitoringAvailableForClass:[CLBeaconRegion class]]) {
        
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Receiving the buzz is not available for your device" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil]; [alert show]; return;

}

- (void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral
{
    hasCompletedBluetooth = NO;
    
    if (peripheral.state == CBPeripheralManagerStatePoweredOn)
    {
        // Bluetooth is on
        
        // Update our status label
        self.statusLabel.text = @"Searching...";
        
        // Start broadcasting
        [self.peripheralManager startAdvertising:self.myBeaconData];
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff)
    {
        // Bluetooth isn't on. Stop broadcasting
        [self.peripheralManager stopAdvertising];
        
        BluetoothOff *bluetoothOff = [[BluetoothOff alloc]initWithNibName:@"BluetoothOff" bundle:nil];
        
        [self presentViewController:bluetoothOff animated:YES completion:nil];
        
        hasCompletedBluetooth = YES;
    }
    
    else if (peripheral.state == CBPeripheralManagerStateUnsupported)
    {
        UIAlertView *alertView = [[UIAlertView  alloc] initWithTitle:@"Your device is unsupported"
                                                            message:@"Please use Buzz with a device that is supported (iOS 7)."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show]; return;
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    //Calling this methods builds the intro and adds it to the screen. See below.
    [self buildIntro];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Build IntroductionView

-(void)buildIntro{

    //1st panel
    UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"Header" owner:nil options:nil][0];
    IntroductionPanel *panel1 = [[IntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:nil description:@"Welcome to Buzz" image:[UIImage imageNamed:@"HeaderImage.png"] header:headerView];
    
    //2nd panel
    IntroductionPanel *panel2 = [[IntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Welcome to Buzz" description:@"Make sure you have someone else with the app open as well." image:[UIImage imageNamed:@"HeaderImage.png"]];

    //Add panels to an array
    NSArray *panels = @[panel1, panel2];
    
    //Create the introduction view and set its delegate
    IntroductionView *introductionView = [[IntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    introductionView.delegate = self;
    introductionView.BackgroundImageView.image = [UIImage imageNamed:@"Toronto, ON.jpg"];
    [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    
    //Build the introduction with desired panels
    [introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    [self.view addSubview:introductionView];

    
}


#pragma mark - Introduction Delegate

-(void)introduction:(IntroductionView *)introductionView didChangeToPanel:(IntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %d", panelIndex);
    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:0.65]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:0.65]];
    }
    
}

- (void)introduction:(IntroductionView *)introductionView didFinishWithType:(FinishType)finishType {
    NSLog(@"Introduction did finish");
}
         
- (void)locationManager:(CLLocationManager*)manager didEnterRegion:(CLRegion *)region {
    
    // We entered a region, now start looking for our target beacons!
    self.statusLabel.text = @"Finding paired phone.";
    [self.locationManager startRangingBeaconsInRegion:self.myBeaconRegion];
}
         
- (void)locationManager:(CLLocationManager*)manager didExitRegion:(CLRegion *)region
{
    // Exited the region
    self.statusLabel.text = @"None found.";
    [self.locationManager stopRangingBeaconsInRegion:self.myBeaconRegion];
}
         
- (void)locationManager:(CLLocationManager*)manager didRangeBeacons:(NSArray*)beacons inRegion:(CLBeaconRegion*)region {
    
    // Beacon found!
    self.statusLabel.text = @"iPhone found!";
            
    CLBeacon *foundBeacon = [beacons firstObject];
            
    // You can retrieve the beacon data from its properties
    //NSString *uuid = foundBeacon.proximityUUID.UUIDString;
    //NSString *major = [NSString stringWithFormat:@"%@", foundBeacon.major];
    //NSString *minor = [NSString stringWithFormat:@"%@", foundBeacon.minor];
}

- (IBAction)buzzButton:(id)sender {
    //animation for morph effect
    [self.buttonView startCanvasAnimation];
    // Get the beacon data to advertise
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    
    // Start the peripheral manager
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
    
    // Check if beacon monitoring is available for this device
    // NOT NEEDED ACTUALLY ERGO SUPPORTED MESSAGE
}

@end