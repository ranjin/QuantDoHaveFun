//
//  QDPopMenu.m
//  TravelPoints
//
//  Created by Charles Ran on 2019/02/20.
//  Copyright © 2019年 quantdo. All rights reserved.
//

#import "QDPopMenu.h"
#import "QDPopMenuCell.h"

@interface QDPopMenu ()<UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate>
{
    UITableView *_menuTableView;
}

@end

@implementation QDPopMenu

- (instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *popover = self.popoverPresentationController;
        popover.delegate = self;
        _defaultIndex = -1;
        _permittedArrowDirections = UIPopoverArrowDirectionUnknown;
        _menuCellHeight = 48;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popoverPresentationController.backgroundColor = APP_WHITECOLOR;
    _menuTableView = [[UITableView alloc] init];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    _menuTableView.showsVerticalScrollIndicator = NO;

    _menuTableView.separatorColor = [UIColor clearColor];
    _menuTableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _menuTableView.backgroundColor = APP_WHITECOLOR;
    [self.view addSubview:_menuTableView];
    
    [_menuTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    self.preferredContentSize = self.menuContentSize;
    UIPopoverPresentationController *popover = self.popoverPresentationController;
    if (_permittedArrowDirections == UIPopoverArrowDirectionUnknown) {
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    }
    else {
        popover.permittedArrowDirections = _permittedArrowDirections;
    }
    popover.sourceView = self.sourceView;
    popover.sourceRect = self.sourceRect;
}

- (void)showMenuFrom:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController) {
        [viewController presentViewController:self animated:animated completion:^{
            
        }];
    }
}

- (void)showMenuFromSourceView:(UIView *)sourceView sourceReact:(CGRect)sourceRect viewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.sourceView = sourceView;
    self.sourceRect = sourceRect;
    [self showMenuFrom:viewController animated:animated];
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

#pragma mark - UIPopoverPresentationControllerDelegate
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController
{
    if ([_delegate respondsToSelector:@selector(dismissPopMenu:)]) {
        [_delegate dismissPopMenu:self];
    }
}

#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _menuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _menuCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"QDPopMenuCell";
    QDPopMenuCell *cell = (QDPopMenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[QDPopMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    if (_showPropName) {
        cell.menuTitleLabel.text = [[_menuArray objectAtIndex:indexPath.row] objectForKey:_showPropName];
    }
    else {
        cell.menuTitleLabel.text = [_menuArray objectAtIndex:indexPath.row];
    }
    if (indexPath.row == self.defaultIndex) {
        cell.textLabel.textColor = APP_BLACKCOLOR;
        cell.selectImg.hidden = NO;
    }
    else {
        cell.textLabel.textColor = APP_GRAYTEXTCOLOR;
        cell.selectImg.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QDPopMenuCell *selectedCell = (QDPopMenuCell *)[_menuTableView cellForRowAtIndexPath:indexPath];
    _defaultIndex = indexPath.row;
    selectedCell.backgroundColor = APP_GRAYBACKGROUNDCOLOR;
    [selectedCell.selectImg setHidden:NO];
    if ([_delegate respondsToSelector:@selector(popMenu:didSelectedMenu:atIndex:)]) {
        [_delegate popMenu:self didSelectedMenu:[_menuArray objectAtIndex:indexPath.row] atIndex:indexPath.row];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end

