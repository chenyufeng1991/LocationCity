//
//  ViewController.m
//  CoreLocation
//
//  Created by helmsmanmac on 15/8/16.
//  Copyright (c) 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //检测定位功能是否开启
  if([CLLocationManager locationServicesEnabled]){
    
    if(!_locationManager){
      
      self.locationManager = [[CLLocationManager alloc] init];
      
      if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
        
      }
      
      //设置代理
      [self.locationManager setDelegate:self];
      //设置定位精度
      [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
      //设置距离筛选
      [self.locationManager setDistanceFilter:100];
      //开始定位
      [self.locationManager startUpdatingLocation];
      //设置开始识别方向
      [self.locationManager startUpdatingHeading];
      
    }
    
  }else{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil
                                                         message:@"您没有开启定位功能"
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil, nil];
    [alertView show];
  }
}

#pragma mark - CLLocationManangerDelegate
//定位成功以后调用
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  
  [self.locationManager stopUpdatingLocation];
  CLLocation* location = locations.lastObject;

  [self reverseGeocoder:location];
}


#pragma mark Geocoder
//反地理编码
- (void)reverseGeocoder:(CLLocation *)currentLocation {
  
  CLGeocoder* geocoder = [[CLGeocoder alloc] init];
  [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
    
    if(error || placemarks.count == 0){
      NSLog(@"error = %@",error);
    }else{
      
      CLPlacemark* placemark = placemarks.firstObject;
      NSLog(@"placemark:%@",[[placemark addressDictionary] objectForKey:@"City"]);
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你的位置" message:[[placemark addressDictionary] objectForKey:@"City"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
      
      [alert show];
      
    }
    
  }];
}

@end
