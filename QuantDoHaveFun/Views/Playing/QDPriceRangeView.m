//
//  QDPriceRangeView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/1.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDPriceRangeView.h"

#define labSpace 20
#define labWidth 25

@implementation QDPriceRangeView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textColor = APP_BLACKCOLOR;
        _priceLab.font = QDFont(16);
        _priceLab.text = @"价格";
        [self addSubview:_priceLab];
        
        _priceDetailLab = [[UILabel alloc] init];
        _priceDetailLab.textColor = APP_GRAYTEXTCOLOR;
        _priceDetailLab.font = QDFont(14);
        _priceDetailLab.text = @"150-不限";
        [self addSubview:_priceDetailLab];
        
        _slider = [[SFDualWaySlider alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH*0.82, 60) minValue:0 maxValue:900 blockSpaceValue:100];
        _slider.backgroundColor = APP_WHITECOLOR;
        _slider.progressRadius = 5;
        [_slider.minIndicateView setTitle:@"0"];
        [_slider.maxIndicateView setTitle:@"不限"];
        _slider.lightColor = APP_BLUECOLOR;
        _slider.progressLeftSpace = 0;
        _slider.spaceInBlocks = 1;
        _slider.minIndicateView.backIndicateColor = APP_BLUECOLOR;
        _slider.maxIndicateView.backIndicateColor = APP_BLUECOLOR;
//        _slider.indicateViewOffset = 2;
//        _slider.indicateViewWidth = 2;
        _slider.sliderValueChanged = ^(CGFloat minValue, CGFloat maxValue) {
            if (maxValue < 900) {
                _priceDetailLab.text = [NSString stringWithFormat:@"%.f-%.f", minValue, maxValue];
            }else{
                _priceDetailLab.text = [NSString stringWithFormat:@"%.f-不限", minValue];
            }
            NSLog(@"minValue = %.f, maxValue = %.f", minValue, maxValue);
        };
        _slider.getMinTitle = ^NSString *(CGFloat minValue) {
            if (floor(minValue) == 0.f) {
                return @"0";
            }else{
                return [NSString stringWithFormat:@"%.f",floor(minValue)];
            }
        };

        _slider.getMaxTitle = ^NSString *(CGFloat maxValue) {
            if (floor(maxValue) == 900.f) {
                return @"不限";
            }else{
                return [NSString stringWithFormat:@"%.f",floor(maxValue)];
            }
        };
        [self addSubview:_slider];
        
        _resetBtn = [[UIButton alloc] init];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = QDFont(20);
        _resetBtn.layer.borderColor = APP_GRAYLINECOLOR.CGColor;
        _resetBtn.layer.borderWidth = 0.2;
        
        [_resetBtn setTitleColor:APP_GRAYTEXTCOLOR forState:UIControlStateNormal];
        [self addSubview:_resetBtn];
        
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:APP_WHITECOLOR forState:UIControlStateNormal];
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.5, 58);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[[UIColor colorWithHexString:@"#159095"] CGColor],(id)[[UIColor colorWithHexString:@"#3CC8B1"] CGColor]]];//渐变数组
        [_confirmBtn.layer addSublayer:gradientLayer];
        _confirmBtn.titleLabel.font = QDFont(19);
        [self addSubview:_confirmBtn];
        
        _leftLab = [[UILabel alloc] init];
        [self makeLabAttri:_leftLab withStr:@"0"];
        [self addSubview:_leftLab];
        
        _rightLab = [[UILabel alloc] init];
        [self makeLabAttri:_rightLab withStr:@"不限"];
        [self addSubview:_rightLab];
        
        _lab1 = [[UILabel alloc] init];
        [self makeLabAttri:_lab1 withStr:@"150"];
        [self addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] init];
        [self makeLabAttri:_lab2 withStr:@"300"];
        [self addSubview:_lab2];
        
        _lab3 = [[UILabel alloc] init];
        [self makeLabAttri:_lab3 withStr:@"450"];
        [self addSubview:_lab3];
        
        _lab4 = [[UILabel alloc] init];
        [self makeLabAttri:_lab4 withStr:@"600"];
        [self addSubview:_lab4];
        
        _lab5 = [[UILabel alloc] init];
        [self makeLabAttri:_lab5 withStr:@"750"];
        [self addSubview:_lab5];
        
        _lab6 = [[UILabel alloc] init];
        [self makeLabAttri:_lab6 withStr:@"900"];
        [self addSubview:_lab6];
    }
    return self;
}

- (void)makeLabAttri:(UILabel *)lab withStr:(NSString *)labStr{
    lab.text = labStr;
    lab.textColor = APP_GRAYTEXTCOLOR;
    lab.font = QDFont(12);
    lab.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCREEN_WIDTH*0.05);
        make.top.equalTo(self.mas_top).offset(SCREEN_HEIGHT*0.05);
    }];
    
    [_priceDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-(SCREEN_WIDTH*0.05));
        make.centerY.equalTo(_priceLab);
    }];

    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH*0.82);
        make.top.equalTo(_priceLab.mas_bottom).offset(15);
        make.height.mas_equalTo(60);
    }];
    
    [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH*0.5);
        make.height.mas_equalTo(58);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH*0.5);
        make.height.mas_equalTo(58);
    }];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_slider.mas_left).offset(-5);
        make.top.equalTo(_slider.mas_bottom).offset(7);
        make.width.mas_equalTo(labWidth);
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_slider.mas_right).offset(5);
        make.centerY.and.width.equalTo(_leftLab);
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.width.equalTo(_leftLab);
        make.left.equalTo(_leftLab.mas_right).offset(labSpace+5);
    }];
    
    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.width.equalTo(_lab1);
        make.left.equalTo(_lab1.mas_right).offset(labSpace+10);
    }];
    
    [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.width.equalTo(_lab2);
        make.left.equalTo(_lab2.mas_right).offset(labSpace+10);
    }];
    
    [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.width.equalTo(_lab3);
        make.left.equalTo(_lab3.mas_right).offset(labSpace+5);
    }];
    
    [_lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.and.width.equalTo(_lab4);
        make.left.equalTo(_lab4.mas_right).offset(labSpace);
    }];
    
//    [_lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.and.width.equalTo(_lab5);
//        make.left.equalTo(_lab5.mas_right).offset(labSpace+20);
//    }];
    
}
@end
