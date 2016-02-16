//
//  MainViewController.m
//  PLCtest
//
//  Created by 易停科技－18 on 16/1/12.
//  Copyright © 2016年 易停科技－18. All rights reserved.
//

#import "MainViewController.h"
#import <AsyncSocket.h>
@interface MainViewController ()<AsyncSocketDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *backLabel;
@property (weak, nonatomic) IBOutlet UITextView *postText;
@property (weak, nonatomic) IBOutlet UITextField *ipText;
@property (weak, nonatomic) IBOutlet UITextField *portText;
@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet UILabel *socketLight;
@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (strong ,nonatomic) AsyncSocket *socket;
@property (nonatomic)BOOL me;
@end

@implementation MainViewController

- (IBAction)postBtnClick:(id)sender {
    if(![self.socket isConnected])
    {
        [self.socket connectToHost:self.ipText.text onPort:[self.portText.text integerValue] error:nil];
    }else
    {
        [self.socket writeData:[[self.postText.text stringByAppendingString:@"/r/n"] dataUsingEncoding:NSUTF8StringEncoding]  withTimeout:-1 tag:1];
        [self.socket readDataWithTimeout:-1 tag:3];
    }
}
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    self.socketLight.backgroundColor = [UIColor greenColor];
    [self.socket writeData:[[self.postText.text stringByAppendingString:@"/r/n"] dataUsingEncoding:NSUTF8StringEncoding]  withTimeout:-1 tag:1];
    [self.socket readDataWithTimeout:-1 tag:2];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(readRepeats:) userInfo:nil repeats:YES];
}
-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err
{
    self.messageText.text = [NSString stringWithFormat:@"%@\n%ld\n%@\n%@",err.domain,err.code,err.userInfo,err.localizedDescription];
}
-(void)onSocketDidDisconnect:(AsyncSocket *)sock
{
    self.socketLight.backgroundColor = [UIColor redColor];
    if (self.me) {
        [self.socket connectToHost:self.ipText.text onPort:[self.portText.text integerValue] error:nil];
    }
}
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    self.socketLight.backgroundColor = [UIColor purpleColor];
}
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    self.backLabel.text = [NSString stringWithFormat:@" %@\n%@",data,[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    NSLog(@"%@",data);
//    [self.socket readDataWithTimeout:-1 tag:2];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initial];
    
}
-(void)readRepeats:(NSTimer*)timer
{
    [self.socket readDataWithTimeout:-1 tag:2];
    if (![self.socket isConnected]) {
        [timer invalidate];
    }
}
-(void)initial
{
    self.ipText.keyboardType = UIKeyboardTypeASCIICapable;
    self.portText.keyboardType = UIKeyboardTypeASCIICapable;
    self.postText.keyboardType = UIKeyboardTypeASCIICapable;
    self.socket = [[AsyncSocket alloc] initWithDelegate:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didNotWrite)];
    [self.view addGestureRecognizer:tap];
    self.postText.delegate = self;
}
-(void)textViewDidChange:(UITextView *)textView
{
    const char *ch = [self.postText.text cStringUsingEncoding:NSASCIIStringEncoding];
    self.xLabel.text = @"";
    for(int i = 0; i < strlen(ch); i ++ )
    {
        self.xLabel.text = [self.xLabel.text stringByAppendingFormat:@"%x",ch[i]];
    }
    
}
-(void)didNotWrite
{
    [self.view endEditing:YES];
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
