//
//  ParkViewController.m
//  PLCtest
//
//  Created by 易停科技－18 on 16/1/18.
//  Copyright © 2016年 易停科技－18. All rights reserved.
//

#import "ParkViewController.h"
#import "MainViewController.h"
#import <AsyncSocket.h>
@interface ParkViewController ()<AsyncSocketDelegate>
@property (nonatomic ,strong)AsyncSocket *socket;
@property (weak, nonatomic) IBOutlet UILabel *oneL;
@property (weak, nonatomic) IBOutlet UILabel *twoL;
@property (weak, nonatomic) IBOutlet UILabel *threeL;
@end

@implementation ParkViewController
- (IBAction)easyPark:(id)sender {
    self.twoL.backgroundColor = [UIColor redColor];
    self.threeL.backgroundColor = [UIColor redColor];
    if (!self.socket.isConnected) {
        [self.socket connectToHost:self.plcmodel.plcIP onPort:[self.plcmodel.plcPort intValue] error:nil];
    }
    [self.socket writeData:[[self.parkStr stringByAppendingString:@"/r/n"] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];
    [self.socket readDataWithTimeout:-1 tag:2];
}
- (IBAction)easyTake:(id)sender {
    self.twoL.backgroundColor = [UIColor redColor];
    self.threeL.backgroundColor = [UIColor redColor];
    if (!self.socket.isConnected) {
        [self.socket connectToHost:self.plcmodel.plcIP onPort:[self.plcmodel.plcPort intValue] error:nil];
    }
    [self.socket writeData:[[self.takeStr stringByAppendingString:@"/r/n"] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];
    [self.socket readDataWithTimeout:-1 tag:2];
}
- (IBAction)manualTake:(id)sender {
    self.twoL.backgroundColor = [UIColor redColor];
    self.threeL.backgroundColor = [UIColor redColor];
    if (!self.socket.isConnected) {
        [self.socket connectToHost:self.plcmodel.plcIP onPort:[self.plcmodel.plcPort intValue] error:nil];
    }
    [self.socket writeData:[[self.chooseseStr stringByAppendingString:@"/r/n"] dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:1];
    [self.socket readDataWithTimeout:-1 tag:2];
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    self.oneL.backgroundColor = [UIColor redColor];
    self.twoL.backgroundColor = [UIColor redColor];
    self.threeL.backgroundColor = [UIColor redColor];
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    self.oneL.backgroundColor = [UIColor yellowColor];

}
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    self.twoL.backgroundColor = [UIColor greenColor];
}
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    self.threeL.backgroundColor = [UIColor purpleColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initial];
}
-(void)initial
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"OLD TEST" style:UIBarButtonItemStyleDone target:self action:@selector(oldTest)];
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
}
-(void)oldTest
{
    [self.navigationController pushViewController:[MainViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
