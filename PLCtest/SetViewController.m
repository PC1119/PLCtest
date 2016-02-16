//
//  SetViewController.m
//  PLCtest
//
//  Created by 易停科技－18 on 16/1/15.
//  Copyright © 2016年 易停科技－18. All rights reserved.
//

#import "SetViewController.h"
#import "OrderViewController.h"
@interface SetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *plcLabel;
@property (weak, nonatomic) IBOutlet UITextField *ipText;
@property (weak, nonatomic) IBOutlet UITextField *portText;
@property (nonatomic ,strong)NSMutableArray *plcArr;
@end

@implementation SetViewController
-(NSMutableArray *)plcArr
{
    if (!_plcArr) {
        _plcArr = [NSMutableArray array];
    }
    return _plcArr;
}
- (IBAction)addPlc:(id)sender {
    plcModel *model = [[plcModel alloc] init];
    model.plcIP = self.ipText.text;
    model.plcPort = self.portText.text;
    [self.plcArr addObject:model];
    [self refreshPlcLabel];
}
-(void)refreshPlcLabel
{
    self.plcLabel.text = [self.plcLabel.text stringByAppendingFormat:@"%@    %@\n",self.ipText.text,self.portText.text];
}
- (IBAction)startTest:(id)sender {
    OrderViewController *order = [OrderViewController new];
    order.plcArr = self.plcArr;
    [self.navigationController pushViewController:order animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initial];
}
-(void)initial
{
    self.navigationItem.title = @"SET";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"RESET" style:UIBarButtonItemStyleDone target:self action:@selector(resetPlc)];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hindeKey)]];
}
-(void)resetPlc
{
    [self.plcArr removeAllObjects];
    self.plcLabel.text = @"";
}
-(void)hindeKey
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
