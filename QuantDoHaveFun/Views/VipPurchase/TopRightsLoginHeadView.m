//
//  TopRightsLoginHeadView.m
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/28.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "TopRightsLoginHeadView.h"
#import "SDWebImageManager.h"
#import "UIButton+WebCache.h"

@implementation TopRightsLoginHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _topBlueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 360, 119)];
        _topBlueView.backgroundColor = APP_BLUECOLOR;
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, 360, 119);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.0),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#B5FBDD"] CGColor],(id)[[UIColor colorWithHexString:@"#5EE8BC"] CGColor]]];//渐变数组
        [_topBlueView.layer addSublayer:gradientLayer];
        _topBlueView.layer.shadowColor = [UIColor colorWithRed:32/255.0 green:158/255.0 blue:115/255.0 alpha:0.3].CGColor;
        _topBlueView.layer.shadowOffset = CGSizeMake(0,0);
        _topBlueView.layer.shadowOpacity = 1;
        _topBlueView.layer.shadowRadius = 10;
        _topBlueView.layer.cornerRadius = 5;
        _topBlueView.layer.masksToBounds = YES;
        [self addSubview:_topBlueView];
        
        _headPic = [[UIButton alloc] init];
        _headPic.layer.cornerRadius = 17;
        _headPic.layer.masksToBounds = YES;
        [_topBlueView addSubview:_headPic];
        [_headPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(33);
            make.top.equalTo(self.mas_top).offset(18);
            make.width.and.height.mas_equalTo(34);
        }];
        
        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"Hi,李先生";
        _nameLab.textColor = APP_BLUETEXTCOLOR;
        _nameLab.font = QDFont(16);
        [_topBlueView addSubview:_nameLab];
        
        _vipTypeLab = [[UILabel alloc] init];
        _vipTypeLab.text = @"Lv";
        _vipTypeLab.textColor = APP_BLUETEXTCOLOR;
        _vipTypeLab.font = QDFont(16);
        [_topBlueView addSubview:_vipTypeLab];
        _protocolLab = [[UILabel alloc] init];
        // 下划线
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"会员协议" attributes:attribtDic];
        //赋值
        _protocolLab.attributedText = attribtStr;
        _protocolLab.textColor = APP_LIGHTBLUETEXTCOLOR;
        _protocolLab.font = QDFont(12);
        [_topBlueView addSubview:_protocolLab];
        
        _vipProgressLab = [[UILabel alloc] init];
        _vipProgressLab.text = @"升级还需75成长值";
        _vipProgressLab.textColor = APP_LIGHTBLUETEXTCOLOR;
        _vipProgressLab.font = QDFont(12);
        [_topBlueView addSubview:_vipProgressLab];
        
        _leftCircleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_circleImg"]];
        [self addSubview:_leftCircleImg];
        
        _rightCircleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_rightImg"]];
        [self addSubview:_rightCircleImg];
        
        _progressView = [[MQGradientProgressView alloc] initWithFrame:CGRectMake(0, 0, 258, 4)];
        _progressView.colorArr = @[(id)[UIColor colorWithHexString:@"#DBFFA8"].CGColor,(id)[UIColor colorWithHexString:@"#DBFFA8"].CGColor];
        [self addSubview:_progressView];
        
        _leftLevelLab = [[UILabel alloc] init];
        _leftLevelLab.textColor = APP_BLUETEXTCOLOR;
        _leftLevelLab.font = QDBoldFont(14);
        [self addSubview:_leftLevelLab];
        
        _leftLevel = [[UILabel alloc] init];
        _leftLevel.textColor = APP_LIGHTBLUETEXTCOLOR;
        _leftLevel.font = QDFont(12);
        [self addSubview:_leftLevel];
        
        _rightLevelLab = [[UILabel alloc] init];
        _rightLevelLab.textColor = APP_BLUETEXTCOLOR;
        _rightLevelLab.font = QDBoldFont(14);
        [self addSubview:_rightLevelLab];
        
        _rightLevel = [[UILabel alloc] init];
        _rightLevel.textColor = APP_LIGHTBLUETEXTCOLOR;
        _rightLevel.font = QDFont(12);
        [self addSubview:_rightLevel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_headPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(33);
        make.top.equalTo(self.mas_top).offset(18);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headPic.mas_right).offset(12);
        make.centerY.equalTo(_headPic);
    }];
    
    [_vipTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-28);
        make.centerY.equalTo(_nameLab);
    }];
    
    [_protocolLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_nameLab);
        make.top.equalTo(_nameLab.mas_bottom).offset(6);
    }];
    
    [_vipProgressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_protocolLab);
        make.right.equalTo(self.mas_right).offset(-21);
    }];
    
    [_leftCircleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(65);
        make.top.equalTo(self.mas_top).offset(83);
        make.width.and.height.mas_equalTo(10);
    }];
    
    [_rightCircleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftCircleImg);
        make.right.equalTo(self.mas_right).offset(-(27));
        make.width.and.height.equalTo(_leftCircleImg);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftCircleImg);
        make.left.equalTo(_leftCircleImg.mas_right);
        make.right.equalTo(_rightCircleImg.mas_left);
        make.height.mas_equalTo(4);
    }];
    
    
    [_leftLevelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftCircleImg.mas_bottom).offset(6);
        make.left.equalTo(_leftCircleImg);
    }];
    
    [_leftLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftLevelLab);
        make.left.equalTo(_leftLevelLab.mas_right);
    }];
    
    [_rightLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_leftLevel);
        make.right.equalTo(_topBlueView.mas_right).offset(-12);
    }];
    
    [_rightLevelLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_rightLevel);
        make.right.equalTo(_rightLevel.mas_left);
    }];
}

- (void)loadVipViewWithModel:(QDMemberDTO *)member{
    if (member.iconUrl == nil) {
        [self.headPic setImage:[UIImage imageNamed:@"icon_headerPic"] forState:UIControlStateNormal];
    }else{
        [self.headPic sd_setImageWithURL:[NSURL URLWithString:member.iconUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_headerPic"]];
    }
    //当前经验值 两个等级
    self.nameLab.text = member.userName;
    self.vipProgressLab.text = [NSString stringWithFormat:@"升级还需%d成长值", [member.maxLevelValue intValue] - [member.userLevelValue intValue]];
    NSString *currentLevel = [NSString stringWithFormat:@"Lv%@", member.userLevel];
    self.vipTypeLab.text = currentLevel;
    NSString *nextLevel = [NSString stringWithFormat:@"Lv%d", [member.userLevel intValue] + 1];
    NSString *minLevelValue = [NSString stringWithFormat:@"(%@)",  member.minLevelValue];
    NSString *maxLevelValue = [NSString stringWithFormat:@"(%@)", member.maxLevelValue];
    self.leftLevelLab.text = currentLevel;
    self.leftLevel.text = minLevelValue;
    
    self.rightLevelLab.text = nextLevel;
    self.rightLevel.text = maxLevelValue;
    //进度值
    CGFloat ss = [member.userLevelValue floatValue] / [member.maxLevelValue floatValue];
    _progressView.progress = ss;
    QDLog(@"ss = %.2f", ss);
}

@end
