//
//  QDCitySelectedViewController.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/18.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "QDCitySelectedViewController.h"
#import "QDLocationTopSelectView.h"
#import "QDCurrentLocationView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "QDHotelsInAreaViewController.h"
#import <TYAlertView.h>
@interface QDCitySelectedViewController ()<UITextFieldDelegate, DZNEmptyDataSetDelegate, DZNEmptyDataSetSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) QDLocationTopSelectView *topView;
@property (nonatomic, strong) QDCurrentLocationView *currentLocationView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITableView *resultVC;
@property (nonatomic, strong) NSMutableArray *results;
@property (nonatomic, strong) NSString *currentCityStr;


@end

@implementation QDCitySelectedViewController{
    NSArray *_hotCitys;
    NSString *_currentLocationInfo;
    NSString *_cityStr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    _results = [[NSMutableArray alloc] init];
//    [self setSearchController];
    [self setTableView];
    [self prepareData];
    [self locate];
}

//- (void)setSearchController {
//    self.resultVc = [[UITableViewController alloc]init];
//    _searchVc = [[SYSearchController alloc]initWithSearchResultsController:self.resultVc];
//    _searchVc.delegate = self;
//    _searchVc.searchResultsUpdater = self;
//    _searchVc.searchBar.delegate = self;
//    _searchVc.resultDelegate = self;
//
//    //设置UISearchController的显示属性，以下3个属性默认为YES
//    //搜索时，背景变暗色
//    _searchVc.dimsBackgroundDuringPresentation = NO;
//    //搜索时，背景变模糊
//    _searchVc.obscuresBackgroundDuringPresentation = NO;
//    //隐藏导航栏
//    _searchVc.hidesNavigationBarDuringPresentation = NO;
//
//    _searchVc.searchBar.frame = CGRectMake(0, 24, SCREEN_WIDTH, SCREEN_HEIGHT*0.05);
//    [self.view addSubview:self.searchVc.searchBar];
//}

- (void)setTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.37, SCREEN_WIDTH, SCREEN_HEIGHT*0.63) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor colorWithHexString:@"#F4F4F4"];
    _tableView.sectionIndexColor = [UIColor grayColor]; //设置默认时索引值颜色
}

- (void)currentLocation:(UIGestureRecognizer *)ges{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)initUI{
    _topView = [[QDLocationTopSelectView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight - 34, SCREEN_WIDTH, SCREEN_HEIGHT*0.05)];
    [_topView.cancelBtn addTarget:self action:@selector(cancelDidClick) forControlEvents:UIControlEventTouchUpInside];
    _topView.inputTF.delegate = self;
    [_topView.inputTF addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_topView];

    _currentLocationView = [[QDCurrentLocationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.17, SCREEN_WIDTH, SCREEN_HEIGHT*0.2)];
    _currentLocationView.detailLocationLab.text = _currentLocationInfo;
    _currentLocationView.cityLab.text = _cityStr;
    [self.view addSubview:_currentLocationView];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectCurrentLocation:)];
    [_currentLocationView addGestureRecognizer:tapGes];
    _resultVC = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.05 + SafeAreaTopHeight - 34, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _resultVC.emptyDataSetDelegate = self;
    _resultVC.emptyDataSetSource = self;
    _resultVC.separatorStyle = UITableViewCellSeparatorStyleNone;
    _resultVC.delegate = self;
    _resultVC.dataSource = self;
    [_resultVC setHidden:YES];
    _resultVC.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_resultVC];
}

- (void)selectCurrentLocation:(UIGestureRecognizer *)ges{
    [_delegate getChoosedAreaName:_currentCityStr];
    [self dismissViewControllerAnimated:YES completion:nil];
//    self.selectCity = ^(NSString * _Nonnull cityName) {
//        cityName = _currentLocationInfo;
//    };
    QDLog(@"123");
}
- (void)prepareData {
    _historyCitys = [NSKeyedUnarchiver unarchiveObjectWithFile:SYHistoryCitysPath];
    NSArray *tempIndex = @[];
    
    if (!_cityDict) {
        if (!_citys) {
            NSArray *citys = [self arrayWithPathName:@"city"];
            //    NSArray *citydatas = [self arrayWithPathName:@"citydata"];
            
            __block NSMutableArray *city = @[].mutableCopy;
            [citys enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [city addObject:obj[@"name"]];
            }];
            _citys = city.copy;
        }
        _cityNames = [SYPinyinSort sortWithChineses:_citys];
        tempIndex = [[SYPinyinSort defaultPinyinSort] indexArray];
    } else {
        
        NSArray *index = [_cityDict allKeys];
        tempIndex = [index sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        
        NSMutableArray *mArr = @[].mutableCopy;
        [tempIndex enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [mArr addObject:self.cityDict[obj]];
        }];
        
        _cityNames = mArr.copy;
    }
    
    NSMutableArray *sortCitys = @[].mutableCopy;
    NSMutableArray *sortIndex = @[].mutableCopy;
    
    [sortIndex addObject:@"#"];
    [sortCitys addObject:self.hotCitys];
    _kCount++;
    
    [sortIndex addObjectsFromArray:tempIndex];
    [sortCitys addObjectsFromArray:_cityNames];
    
    _indexArray = sortIndex.copy;
    _cityDicts = [NSMutableDictionary dictionaryWithObjects:sortCitys forKeys:sortIndex];
}

- (void)saveHistoryCitys:(NSString *)cityName {
    NSMutableArray *marr = @[].mutableCopy;
    [marr addObjectsFromArray:self.historyCitys];
    [marr removeObject:cityName];
    [marr insertObject:cityName atIndex:0];
    
    if (marr.count > 4) [marr removeObjectsInRange:NSMakeRange(4, marr.count - 4)];
    self.historyCitys = [marr copy];
    
    [NSKeyedArchiver archiveRootObject:self.historyCitys toFile:SYHistoryCitysPath];
    if (!_selectCity) return;
    _selectCity(cityName);
    [self cancelDidClick];
}

#pragma mark - events
- (void)cancelDidClick {
    [_topView.inputTF resignFirstResponder];
    if (_resultVC.hidden) {
        [self dismissViewControllerAnimated:YES completion:nil];

//        [self.navigationController.view addSubview:self.navigationController.navigationBar];
//        [_searchVc dismissViewControllerAnimated:NO completion:nil];
    }else{
        [_resultVC setHidden:YES];
        [_tableView setHidden:NO];
    }
//    if (self.presentingViewController) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

#pragma mark - Delegate
#pragma mark - UISearchResultsUpdating
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
//    NSString *searchString = [searchController.searchBar text];
//    NSMutableArray *dataArray = @[].mutableCopy;
//    //过滤数据
//    for (NSArray *arr in self.cityNames) {
//        for (NSString *city in arr) {
//            if ([city rangeOfString:searchString].location != NSNotFound) {
//                [dataArray addObject:city];
//                continue;
//            }
//            NSString *pinyin = [[SYChineseToPinyin pinyinFromChiniseString:city] lowercaseString];
//            if ([pinyin hasPrefix:[searchString lowercaseString]]) {
//                [dataArray addObject:city];
//                continue;
//            }
//        }
//    }
//
//    if (dataArray.count <= 0) {
//        [dataArray addObject:@"抱歉，未找到相关位置，可尝试修改后重试"];
//    }
//
//    //刷新表格
//
//    _searchVc.maskView.hidden = YES;
//    if ([searchController.searchBar.text isEqualToString:@""]) _searchVc.maskView.hidden = NO;
//    self.searchVc.results = dataArray;
////    self.resultVc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
////    _.tableView.scrollIndicatorInsets = self.resultVc.tableView.contentInset;
////    [self.resultVc.tableView reloadData];
//}

#pragma mark - SYSearchResultControllerDelegate
//- (void)resultViewController:(SYSearchController *)resultVC didSelectFollowCity:(NSString *)cityName {
//    self.searchVc.searchBar.text = @"";
//    [self saveHistoryCitys:cityName];
//}

#pragma mark - UISearchBarDelegate
// 修改SearchBar的Cancel Button 的Title
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar; {
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn = [searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView == _resultVC){
        return 1;
    }else{
        return _cityDicts.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        if (section < _kCount) return 1;
        NSArray *categoryCitys = _cityDicts[_indexArray[section]];
        return categoryCitys.count;
    }else if(tableView == _resultVC){
        return _results.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _resultVC) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.textLabel.text = self.results[indexPath.row];
        cell.textLabel.font = QDFont(15);
        return cell;
    }else if (tableView == _tableView){
        NSArray *categoryCitys = _cityDicts[_indexArray[indexPath.section]];
        if (indexPath.section < _kCount) {
            SYCitysCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYCitysCell"];
            if (!cell) {
                __weak typeof(self) weakSelf = self;
                cell = [[SYCitysCell alloc] initWithReuseIdentifier:@"SYCitysCell"];
                cell.selectCity = ^(NSString *cityName) {
                    __strong typeof(weakSelf) strongSelf = self;
                    [strongSelf saveHistoryCitys:cityName];
                };
            }
            cell.citys = categoryCitys;
            return cell;
        }
        
        SYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYTableViewCell"];
        if (!cell) {
            cell = [[SYTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SYTableViewCell"];
        }
        cell.textLabel.font = QDFont(15);
        cell.isShowSeparator = YES;
        if (indexPath.row >= [categoryCitys count] - 1) cell.isShowSeparator = NO;
        cell.textLabel.text = categoryCitys[indexPath.row];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _resultVC) {
        return 44;
    }else{
        if (indexPath.section < _kCount) {
            NSArray *categoryCitys = _cityDicts[_indexArray[indexPath.section]];
            CGFloat h = [SYCitysCell heightForCitys:categoryCitys];
            return indexPath.section == _kCount - 1 ? h + 10 : h;
        }
        return SCREEN_HEIGHT*0.08;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _resultVC) {
        return 0.01;
    }else{
        return SCREEN_HEIGHT*0.07;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _resultVC) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }else{
        static NSString *headerViewId = @"SYHeaderViewId";
        SYHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
        if (!headerView) {
            headerView = [[SYHeaderView alloc] initWithReuseIdentifier:headerViewId];
        }
        NSString *title = self.indexArray[section];
        if ([title isEqualToString:@"#"]) {
            title = @"热门城市";
        }
        if (section == 0) {
            SYHotCityHeaderView *hotView = [[SYHotCityHeaderView alloc] init];
            return hotView;
        }else{
            headerView.titleLabel.text = title;
            return headerView;
        }
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.indexArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _resultVC) {
        QDLog(@"results = %@", _results);
        NSString *ss = _results[indexPath.row];
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate getChoosedAreaName:ss];
    }else{
        if (indexPath.section < _kCount) return;
        NSArray *categoryCitys = _cityDicts[_indexArray[indexPath.section]];
        [self saveHistoryCitys:categoryCitys[indexPath.row]];
    }
}

//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

#pragma mark - lazy load
- (NSArray *)arrayWithPathName:(NSString *)pathName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"SYCity" ofType:@"bundle"];
    NSBundle *syBundle = [NSBundle bundleWithPath:bundlePath];
    NSString *path = [syBundle pathForResource:pathName ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

#pragma mark - locate
- (void)locate {
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
        }
        [_locationManager startUpdatingLocation]; //开启定位
//        [_tableView reloadData];
    }else {
        //提示用户无法进行定位操作
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"定位不成功 ,请确认开启定位" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

#pragma mark - CLLocationManagerDelegate
/**
 *  只要定位到用户的位置，就会调用（调用频率特别高）
 *  @param locations : 装着CLLocation对象
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *currentLocation = [locations lastObject];    
    //根据经纬度反向地理编译出地址信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error) {
        for (CLPlacemark * placemark in array) {
            
            NSDictionary *address = [placemark addressDictionary];
            
            //  Country(国家)  State(省)  City（市）
            NSLog(@"#####%@",address);
            
            NSLog(@"%@", [address objectForKey:@"Country"]);
            
            NSLog(@"%@", [address objectForKey:@"State"]);
            
            NSLog(@"%@", [address objectForKey:@"City"]);
            _currentCityStr = [address objectForKey:@"City"];
            _currentLocationView.cityLab.text = [address objectForKey:@"City"];
            if (address != NULL) {
                _currentLocationInfo = [NSString stringWithFormat:@"%@%@%@", [address objectForKey:@"City"], [address objectForKey:@"SubLocality"], [address objectForKey:@"Street"]];
                _currentLocationView.detailLocationLab.text = _currentLocationInfo;
            }
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied){
        //访问被拒绝
        [WXProgressHUD showErrorWithTittle:@"位置访问被拒绝"];
        _currentLocationView.detailLocationLab.text = @"访问被拒绝,定位失败";
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //无法获取位置信息
        [WXProgressHUD showErrorWithTittle:@"无法获取位置信息"];
        _currentLocationView.detailLocationLab.text = @"无法获取位置信息,定位失败";
        QDLog(@"kCLErrorLocationUnknown");
    }
    TYAlertView *alertView = [[TYAlertView alloc] initWithTitle:@"尚未打开定位" message:@"是否在设置中打开定位?"];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancel handler:^(TYAlertAction *action) {
    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }]];
    
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleCancel forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleBlod forState:UIControlStateNormal];
    [alertView setButtonTitleColor:APP_BLUECOLOR forActionStyle:TYAlertActionStyleDestructive forState:UIControlStateNormal];
    [alertView show];
}

- (void)setBackView:(UIView *)backView {
    if (_backView == backView) return;
    _backView = backView;
    if ([backView isKindOfClass:[UIButton class]]) {
        [(UIButton *)backView addTarget:self action:@selector(cancelDidClick) forControlEvents:UIControlEventTouchUpInside];
    }else {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelDidClick)];
        [backView addGestureRecognizer:tapGes];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backView];
}

- (void)setBackImageName:(NSString *)backImageName {
    if ([_backImageName isEqualToString:backImageName]) return;
    _backImageName = backImageName;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:backImageName] style:UIBarButtonItemStyleDone target:self action:@selector(cancelDidClick)];
}



- (void)setHotCitys:(NSArray *)hotCitys {
    if (_hotCitys == hotCitys) return;
    _hotCitys = hotCitys;
    if (_cityDicts) {
        [_cityDicts setObject:hotCitys forKey:@"*"];
    }
}

- (NSArray *)hotCitys {
    if (!_hotCitys) {
        _hotCitys = @[@"北京",@"三亚",@"上海",@"广州",@"成都",@"青岛",@"南京",@"杭州",@"厦门",@"深圳",@"重庆",@"大连",@"香港",@"台北"];
    }
    return _hotCitys;
}

- (void)setCitys:(NSArray *)citys {
    if (_citys == citys) return;
    _citys = citys;
}

#pragma mark - 头部取消按钮
//- (void)cancelSelect:(UIButton *)sender{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [_topView.inputTF resignFirstResponder];
//}

- (void)dealloc {
//    _searchVc.delegate = nil;
//    _searchVc.searchResultsUpdater = nil;
//    _searchVc.searchBar.delegate = nil;
//    _searchVc.resultDelegate = nil;
    
    _indexArray = nil;
    _historyCitys = nil;
    _cityDicts = nil;
    
    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
        _locationManager = nil;
        _locationManager.delegate = nil;
    }
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _maskView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.2];
        [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelKeyboard)]];
    }
    return _maskView;
}

- (void)cancelKeyboard {
    [_topView.inputTF resignFirstResponder];
//    [_searchVc.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
    [UIView animateWithDuration:0.2 animations:^{
//        self.maskView.hidden = YES;
    }];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [self.view addSubview:self.maskView];
//    [self.maskView setHidden:NO];
    [self.resultVC setHidden:NO];
    [_tableView setHidden:YES];
//    [self.resultVC reloadEmptyDataSet];
//    [self.view addSubview:_maskView];
    QDLog(@"123");
}

#pragma mark - DZNEmtpyDataSet Delegate

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return [UIImage imageNamed:@"emptySource"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = @"暂无相关信息";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - 开始变化  应该实时的根据text去查找

- (void)textFieldTextChange:(UITextField *)textField{
    [_resultVC setHidden:NO];
    [_tableView setHidden:YES];
    QDLog(@"textFieldTextChange");
    NSString *searchString = [textField text];
    NSMutableArray *dataArray = @[].mutableCopy;
    //过滤数据
    for (NSArray *arr in self.cityNames) {
        for (NSString *city in arr) {
            if ([city rangeOfString:searchString].location != NSNotFound) {
                [dataArray addObject:city];
                continue;
            }
            NSString *pinyin = [[SYChineseToPinyin pinyinFromChiniseString:city] lowercaseString];
            if ([pinyin hasPrefix:[searchString lowercaseString]]) {
                [dataArray addObject:city];
                continue;
            }
        }
    }
    
    if (dataArray.count <= 0) {
        [_resultVC reloadData];
        [_tableView setHidden:YES];
        [_resultVC reloadEmptyDataSet];
    }
    
    //刷新表格
    
//    _maskView.hidden = YES;
    _results = dataArray;
    [_resultVC reloadData];
    //    self.resultVc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    _.tableView.scrollIndicatorInsets = self.resultVc.tableView.contentInset;
    //    [self.resultVc.tableView reloadData];
}
@end
