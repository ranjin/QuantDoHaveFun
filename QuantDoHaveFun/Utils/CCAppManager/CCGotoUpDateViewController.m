
#import "CCGotoUpDateViewController.h"

@interface CCGotoUpDateViewController ()
@end

@implementation CCGotoUpDateViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"Launch"];
    [self.view addSubview:imageV];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(popUpAlert)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self popUpAlert];
}

- (void)popUpAlert {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发现需要升级的版本，现在去更新?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self gotoUpdate:nil];
}

- (void)gotoUpdate:(id)sender {
    NSString *urlStr = @"itms-apps://itunes.apple.com/cn/app/id1456067852?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
}
@end

