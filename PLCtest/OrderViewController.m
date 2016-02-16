//
//  OrderViewController.m
//  PLCtest
//
//  Created by 易停科技－18 on 16/1/16.
//  Copyright © 2016年 易停科技－18. All rights reserved.
//

#import "OrderViewController.h"
#import "ParkViewController.h"
#define k_scrollY self.plcScroll.frame.size.height
@interface OrderViewController ()
@property (weak, nonatomic) IBOutlet UITextField *parkCode;
@property (weak, nonatomic) IBOutlet UITextField *takeCode;
@property (weak, nonatomic) IBOutlet UITextField *chossesCode;
@property (weak, nonatomic) IBOutlet UIScrollView *plcScroll;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initial];
}
-(void)initial
{
    self.navigationItem.title = @"Order Set";
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKey)]];
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"initCode"];
    NSLog(@"%@",dic);
    if(dic)
    {
        self.parkCode.text = dic[@"parkCode"];
        self.takeCode.text = dic[@"takeCode"];
        self.chossesCode.text = dic[@"chossesCode"];
    }
    
    for (NSInteger i = 0;i < self.plcArr.count ; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0+ k_scrollY * i, 0, k_scrollY, k_scrollY)];
        btn.tag = 100+i;
        btn.backgroundColor = [UIColor colorWithRed:arc4random()%254/255.0f green:arc4random()%254/255.0f blue:arc4random()%254/255.0f alpha:1.0f];
        [btn setTitle:[NSString stringWithFormat:@"PLC%ld",i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.plcScroll addSubview:btn];
    }
    
    self.plcScroll.contentSize = CGSizeMake(k_scrollY * self.plcArr.count,0);
}
-(void)btnClick:(UIButton*)sender
{
    if ([NSUserDefaults standardUserDefaults]) {
        NSDictionary *initCode = @{@"parkCode":self.parkCode.text,
                                   @"takeCode":self.takeCode.text,
                                   @"chossesCode":self.chossesCode.text
                                   };
        [[NSUserDefaults standardUserDefaults] setObject:initCode forKey:@"initCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    ParkViewController *main = [[ParkViewController alloc] init];
    main.plcmodel = self.plcArr[sender.tag - 100];
    main.parkStr = self.parkCode.text;
    main.takeStr = self.takeCode.text;
    main.chooseseStr = self.chossesCode.text;
    [self.navigationController pushViewController:main animated:YES];
}
-(void)hideKey
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
