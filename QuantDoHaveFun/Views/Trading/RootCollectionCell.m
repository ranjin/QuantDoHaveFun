//
//  TestCollectionCell.m
//  DKSTableCollcetionView
//
//  Created by aDu on 2017/10/10.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import "RootCollectionCell.h"

@interface RootCollectionCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation RootCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"¥";
        _priceLab.font = QDBoldFont(18);
        _priceLab.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_priceLab];

        _price = [[UILabel alloc] init];
        _price.text = @"34.00";
        _price.font = QDBoldFont(24);
        _price.textColor = APP_ORANGETEXTCOLOR;
        [self.contentView addSubview:_price];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        _lineView.alpha = 0.4;
        [self.contentView addSubview:_lineView];
        
        _singlePriceLab = [[UILabel alloc] init];
        _singlePriceLab.text = @"单价:";
        _singlePriceLab.textColor = APP_GRAYLINECOLOR;
        _singlePriceLab.font = QDFont(12);
        [self.contentView addSubview:_singlePriceLab];
        
        _headPic = [[UIImageView alloc] init];
        _headPic.image = [UIImage imageNamed:@"icon_headerPic"];
        _headPic.layer.cornerRadius = SCREEN_WIDTH*0.03;
        _headPic.layer.masksToBounds = YES;
        [self.contentView addSubview:_headPic];

        _nameLab = [[UILabel alloc] init];
        _nameLab.text = @"四叶草8766";
        _nameLab.font = QDFont(12);
        [self.contentView addSubview:_nameLab];
        
        _amountLab = [[UILabel alloc] init];
        _amountLab.text = @"数量";
        _amountLab.font = QDFont(12);
        _amountLab.textColor = APP_GRAYLINECOLOR;
        [self.contentView addSubview:_amountLab];
        
        _amount = [[UILabel alloc] init];
        _amount.text = @"1000";
        _amount.font = QDFont(12);
        _amount.textColor = APP_BLACKCOLOR;
        [self.contentView addSubview:_amount];
        
        _statusLab = [[UILabel alloc] init];
        _statusLab.textColor = APP_BLACKCOLOR;
        _statusLab.text = @"可零售";
        _statusLab.textAlignment = NSTextAlignmentCenter;
        _statusLab.font = QDFont(12);
        [self.contentView addSubview:_statusLab];
        
        _sell = [[UIButton alloc] init];
        _sell.backgroundColor = [UIColor colorWithHexString:@"#E8FFFC"];
        [_sell setTitle:@"我要了" forState:UIControlStateNormal];
        [_sell setTitleColor:[UIColor colorWithHexString:@"#00C0AC"] forState:UIControlStateNormal];
        _sell.titleLabel.font = QDBoldFont(14);
        _sell.layer.cornerRadius = 12.3;
        _sell.layer.masksToBounds = YES;
        [self.contentView addSubview:_sell];
        
//        //shadowColor阴影颜色
        self.contentView.layer.cornerRadius = 3;
//        self.layer.shadowColor = [UIColor colorWithHexString:@"#DDDDDD"].CGColor;
        self.contentView.backgroundColor = APP_WHITECOLOR;
//        //shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
//        self.layer.shadowOffset = CGSizeMake(0,0);
//
//        //阴影透明度，默认0
//        self.layer.shadowOpacity = 1;
//
//        //阴影半径，默认3
        self.layer.shadowRadius = 3;
        self.layer.masksToBounds = YES;
//
//        //路径阴影(借助贝塞尔曲线)
//        UIBezierPath *path = [UIBezierPath bezierPath];
//
//        float width = self.bounds.size.width;
//        float height = self.bounds.size.height;
//        float x = self.bounds.origin.x;
//        float y = self.bounds.origin.y;
//        float addWH = 10;
//
//        CGPoint topLeft      = self.bounds.origin;
//        CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
//        CGPoint topRight     = CGPointMake(x+width,y);
//
//        CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
//
//        CGPoint bottomRight  = CGPointMake(x+width,y+height);
//        CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
//        CGPoint bottomLeft   = CGPointMake(x,y+height);
//
//
//        CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
//
//        [path moveToPoint:topLeft];
//        //添加四个二元曲线
//        [path addQuadCurveToPoint:topRight
//                     controlPoint:topMiddle];
//        [path addQuadCurveToPoint:bottomRight
//                     controlPoint:rightMiddle];
//        [path addQuadCurveToPoint:bottomLeft
//                     controlPoint:bottomMiddle];
//        [path addQuadCurveToPoint:topLeft
//                     controlPoint:leftMiddle];
//        //设置阴影路径
//        self.layer.shadowPath = path.CGPath;

    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [_headPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(8);
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.width.and.height.mas_equalTo(24);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headPic);
        make.left.equalTo(_headPic.mas_right).offset(9);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(_headPic.mas_bottom).offset(8);
        make.width.mas_equalTo(164);
        make.height.mas_equalTo(1);
    }];
    
    [_singlePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headPic);
        make.top.equalTo(_lineView.mas_bottom).offset(24);
    }];
    
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_singlePriceLab);
        make.left.equalTo(_singlePriceLab.mas_right).offset(9);
    }];

    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_priceLab.mas_right);
        make.bottom.equalTo(_priceLab);
    }];

    [_amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_singlePriceLab);
        make.top.equalTo(_singlePriceLab.mas_bottom).offset(18);
    }];

    [_amount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_amountLab);
        make.top.equalTo(_amountLab.mas_bottom).offset(9);
    }];

    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_amount);
        make.left.equalTo(self.contentView.mas_left).offset(104);
    }];

    [_sell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(14);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.mas_equalTo(63);
        make.height.mas_equalTo(25);
    }];
}

- (void)loadDataWithDataArr:(BiddingPostersDTO *)infoModel andTypeStr:(NSString *)str{
    self.nameLab.text = infoModel.userId;
    self.price.text = [NSString stringWithFormat:@"%.2lf", [infoModel.price doubleValue]];
    self.amount.text = infoModel.surplusVolume;
    if ([str isEqualToString:@"1"]) {
        [self.sell setTitle:@"我要了" forState:UIControlStateNormal];
    }else{
        [self.sell setTitle:@"卖给ta" forState:UIControlStateNormal];
    }
    if ([infoModel.isPartialDeal isEqualToString:@"0"]) {
        self.statusLab.hidden = YES;
    }else{
        self.statusLab.hidden = NO;
    }
}
@end
