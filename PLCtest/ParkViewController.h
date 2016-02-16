//
//  ParkViewController.h
//  PLCtest
//
//  Created by 易停科技－18 on 16/1/18.
//  Copyright © 2016年 易停科技－18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkViewController : UIViewController
@property (strong,nonatomic) plcModel *plcmodel;
@property (strong,nonatomic) NSString *parkStr;
@property (strong ,nonatomic) NSString *takeStr;
@property (strong ,nonatomic) NSString *chooseseStr;
@end
