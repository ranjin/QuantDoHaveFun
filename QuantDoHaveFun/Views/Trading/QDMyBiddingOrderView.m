//
//  QDPickOrderView.m
//  TravelPoints
//
//  Created by WJ-Shao on 2019/3/14.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDMyBiddingOrderView.h"
#import "QDDateUtils.h"
#import "QDOrderField.h"
@implementation QDMyBiddingOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = APP_WHITECOLOR;
        _topView.layer.cornerRadius = 2;
        _topView.layer.masksToBounds = YES;
        [self addSubview:_topView];
        
        _statusImg = [[UIImageView alloc] init];
        _statusImg.image = [UIImage imageNamed:@"orderStatus_withdraw"];
        [_topView addSubview:_statusImg];
        
        _statusLab = [[UILabel alloc] init];
        _statusLab.font = QDFont(16);
        _statusLab.textColor = APP_BLACKCOLOR;
        [_topView addSubview:_statusLab];
        
        _dealLab = [[UILabel alloc] init];
        _dealLab.text = @"已成交";
        _dealLab.font = QDFont(13);
        _dealLab.textColor = APP_GRAYTEXTCOLOR;
        [_topView addSubview:_dealLab];
        
        _deal = [[UILabel alloc] init];
        _deal.text = @"0";
        _deal.font = QDFont(13);
        _deal.textColor = APP_BLUECOLOR;
        [_topView addSubview:_deal];
        
        _dealTextLab = [[UILabel alloc] init];
        _dealTextLab.text = @"个";
        _dealTextLab.font = QDFont(13);
        _dealTextLab.textColor = APP_GRAYTEXTCOLOR;
        [_topView addSubview:_dealTextLab];
        
        _frozenLab = [[UILabel alloc] init];
        _frozenLab.text = @"冻结";
        _frozenLab.font = QDFont(13);
        _frozenLab.textColor = APP_GRAYTEXTCOLOR;
        [_topView addSubview:_frozenLab];
        
        _frozen = [[UILabel alloc] init];
        _frozen.text = @"0";
        _frozen.font = QDFont(13);
        _frozen.textColor = APP_BLUECOLOR;
        [_topView addSubview:_frozen];
        
        _frozenTextLab = [[UILabel alloc] init];
        _frozenTextLab.text = @"个";
        _frozenTextLab.font = QDFont(13);
        _frozenTextLab.textColor = APP_GRAYTEXTCOLOR;
        [_topView addSubview:_frozenTextLab];
        
        _centerView = [[UIView alloc] init];
        _centerView.layer.cornerRadius = 2;
        _centerView.layer.masksToBounds = YES;
        _centerView.backgroundColor = APP_WHITECOLOR;
        [self addSubview:_centerView];
        
        _operationImg = [[UIImageView alloc] init];
        _operationImg.image = [UIImage imageNamed:@"balance_detail"];
        [_centerView addSubview:_operationImg];
        
        _operationType = [[UILabel alloc] init];
        _operationType.font = QDBoldFont(14);
        _operationType.textColor = APP_GRAYTEXTCOLOR;
        [_centerView addSubview:_operationType];
        
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [_centerView addSubview:_topLine];
        
        _lab1 = [[UILabel alloc] init];
        _lab1.text = @"金额";
        _lab1.font = QDFont(14);
        _lab1.textColor = APP_GRAYLINECOLOR;
        [_centerView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] init];
        _lab2.text = @"¥";
        _lab2.font = QDBoldFont(20);
        _lab2.textColor = APP_ORANGETEXTCOLOR;
        [_centerView addSubview:_lab2];
        
        _lab3 = [[UILabel alloc] init];
        _lab3.text = @"20000";
        _lab3.font = QDBoldFont(24);
        _lab3.textColor = APP_ORANGETEXTCOLOR;
        [_centerView addSubview:_lab3];
        
        _lab4 = [[UILabel alloc] init];
        _lab4.text = @"数量";
        _lab4.font = QDFont(13);
        _lab4.textColor = APP_GRAYLINECOLOR;
        [_centerView addSubview:_lab4];
        
        _lab5 = [[UILabel alloc] init];
        _lab5.text = @"2000";
        _lab5.font = QDFont(13);
        _lab5.textColor = APP_GRAYTEXTCOLOR;
        [_centerView addSubview:_lab5];
        
        _lab6 = [[UILabel alloc] init];
        _lab6.text = @"单价";
        _lab6.font = QDFont(13);
        _lab6.textColor = APP_GRAYLINECOLOR;
        [_centerView addSubview:_lab6];
        
        _lab7 = [[UILabel alloc] init];
        _lab7.text = @"¥10.00";
        _lab7.font = QDFont(13);
        _lab7.textColor = APP_GRAYTEXTCOLOR;
        [_centerView addSubview:_lab7];
        
        _lab8 = [[UILabel alloc] init];
        _lab8.text = @"手续费";
        _lab8.font = QDFont(13);
        _lab8.textColor = APP_GRAYLINECOLOR;
        [_centerView addSubview:_lab8];
        
        _lab9 = [[UILabel alloc] init];
        _lab9.text = @"¥0.00";
        _lab9.font = QDFont(13);
        _lab9.textColor = APP_GRAYTEXTCOLOR;
        [_centerView addSubview:_lab9];
        
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = APP_LIGTHGRAYLINECOLOR;
        [_centerView addSubview:_bottomLine];
        
        _bdNumLab = [[UILabel alloc] init];
        _bdNumLab.text = @"发布单号:";
        _bdNumLab.textColor = APP_GRAYTEXTCOLOR;
        _bdNumLab.font = QDFont(13);
        [_centerView addSubview:_bdNumLab];
        
        _bdNum = [[UILabel alloc] init];
        _bdNum.text = @"O181204B13855";
        _bdNum.textAlignment = NSTextAlignmentRight;
        _bdNum.textColor = APP_GRAYTEXTCOLOR;
        _bdNum.font = QDFont(13);
        [_centerView addSubview:_bdNum];
        
        _bdTimeLab = [[UILabel alloc] init];
        _bdTimeLab.text = @"发布时间:";
        _bdTimeLab.textColor = APP_GRAYTEXTCOLOR;
        _bdTimeLab.font = QDFont(13);
        [_centerView addSubview:_bdTimeLab];
        
        _bdTime = [[UILabel alloc] init];
        _bdTime.text = @"2018-11-20 11:30:11";
        _bdTime.textAlignment = NSTextAlignmentRight;
        _bdTime.textColor = APP_GRAYTEXTCOLOR;
        _bdTime.font = QDFont(13);
        [_centerView addSubview:_bdTime];
        
        _withdrawBtn = [[UIButton alloc] init];
        [_withdrawBtn setTitle:@"我不卖了" forState:UIControlStateNormal];
        [_withdrawBtn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        _withdrawBtn.backgroundColor = APP_WHITECOLOR;
        _withdrawBtn.titleLabel.font = QDFont(16);
        _withdrawBtn.layer.cornerRadius = 12;
        _withdrawBtn.layer.masksToBounds = YES;
        [self addSubview:_withdrawBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).offset(20);
        make.height.mas_equalTo(90);
        make.width.mas_equalTo(335);
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).offset(21);
        make.left.equalTo(_topView.mas_left).offset(15);

    }];
    
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_statusImg);
        make.left.equalTo(_statusImg.mas_right).offset(7);
    }];
    
    [_dealLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(38);
        make.top.equalTo(_topView.mas_top).offset(49);
    }];

    [_deal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealLab);
        make.left.equalTo(_dealLab.mas_right).offset(4);
    }];

    [_dealTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealLab);
        make.left.equalTo(_deal.mas_right).offset(4);
    }];

    [_frozenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_dealTextLab);
        make.left.equalTo(_dealTextLab.mas_right).offset(10);
    }];

    [_frozen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_frozenLab);
        make.left.equalTo(_frozenLab.mas_right).offset(4);
    }];

    [_frozenTextLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_frozen);
        make.left.equalTo(_frozen.mas_right).offset(4);
    }];

    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.width.equalTo(_topView);
        make.top.equalTo(_topView.mas_bottom).offset(20);
        make.height.mas_equalTo(244);
    }];

    [_operationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.mas_top).offset(17);
        make.left.equalTo(_centerView.mas_left).offset(15);
    }];
    
    [_operationType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_operationImg);
        make.left.equalTo(_operationImg.mas_right).offset(9);
    }];

    [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_centerView);
        make.top.equalTo(_centerView.mas_top).offset(48);
        make.width.mas_equalTo(305);
        make.height.mas_equalTo(1);
    }];

    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_operationType);
        make.top.equalTo(_topLine.mas_bottom).offset(20);
    }];

    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lab1);
        make.top.equalTo(_lab1.mas_bottom).offset(8);
    }];

    [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_lab2);
        make.left.equalTo(_lab2.mas_right);
    }];

    [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_centerView.mas_left).offset(180);
        make.centerY.equalTo(_lab1);
    }];

    [_lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lab4.mas_right);
        make.centerY.equalTo(_lab4);
    }];

    [_lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lab4.mas_bottom).offset(5);
        make.left.equalTo(_lab4);
    }];

    [_lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lab6.mas_right);
        make.centerY.equalTo(_lab6);
    }];

    [_lab8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lab6.mas_bottom).offset(5);
        make.left.equalTo(_lab4);
    }];

    [_lab9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_lab8.mas_right);
        make.centerY.equalTo(_lab8);
    }];

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.and.height.equalTo(_topLine);
        make.top.equalTo(_centerView.mas_top).offset(159);
    }];

    [_bdNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomLine);
        make.top.equalTo(_bottomLine.mas_bottom).offset(20);
    }];

    [_bdNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bdNumLab);
        make.right.equalTo(_bottomLine);
    }];

    [_bdTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bdNumLab);
        make.top.equalTo(_bdNumLab.mas_bottom).offset(6);
    }];

    [_bdTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bdTimeLab);
        make.right.equalTo(_topLine);
    }];

    [_withdrawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_centerView.mas_bottom).offset(24);
        make.width.mas_equalTo(356);
        make.height.mas_equalTo(50);
    }];
}

/**
 QD_WaitForPurchase = 0,    //待付款
 QD_HavePurchased = 1,      //已付款
 QD_HaveFinished = 2,       //已完成
 QD_OverTimeCanceled = 3,   //超时取消
 QD_ManualCanceled = 4      //手工取消
 */
- (void)loadViewWithModel:(BiddingPostersDTO *)model{
    if ([model.postersStatus intValue] == 7) {  //待付款情况
        }else{
            //未成交与部分成交的时候 并且
            switch ([model.postersStatus integerValue]) {
                case QD_ORDERSTATUS_NOTTRADED:
                    self.statusLab.text = @"未成交";
                    self.statusImg.image = [UIImage imageNamed:@"trade_dealed"];
                    self.withdrawBtn.hidden = NO;
                    break;
                case QD_ORDERSTATUS_PARTTRADED:
                    self.statusLab.text = @"部分成交";
                    self.statusImg.image = [UIImage imageNamed:@"trade_dealed"];
                    self.withdrawBtn.hidden = NO;
                    break;
                case QD_ORDERSTATUS_ALLTRADED:
                    self.statusLab.text = @"全部成交";
                    self.statusImg.image = [UIImage imageNamed:@"trade_dealed"];
                    self.withdrawBtn.hidden = YES;
                    break;
                case QD_ORDERSTATUS_ALLCANCELED:
                    self.statusLab.text = @"全部撤单";
                    self.statusImg.image = [UIImage imageNamed:@"orderStatus_withdraw"];
                    self.withdrawBtn.hidden = YES;
                    break;
                case QD_ORDERSTATUS_PARTCANCELED:
                    self.operationImg.image = [UIImage imageNamed:@"orderStatus_withdraw"];
                    self.statusLab.text = @"部分成交部分撤单";
                    self.withdrawBtn.hidden = YES;
                    break;
                case QD_ORDERSTATUS_ISCANCELED:
                    self.statusImg.image = [UIImage imageNamed:@"orderStatus_withdraw"];
                    self.statusLab.text = @"已取消";
                    self.withdrawBtn.hidden = YES;
                    break;
                case QD_ORDERSTATUS_INTENTION:
                    self.statusLab.text = @"意向单";
                    self.withdrawBtn.hidden = YES;
                    break;
                default:
                    break;
            }
        }
        if ([model.postersType isEqualToString:@"0"]) {
            _operationType.text = @"买入";
        }else{
            _operationType.text = @"卖掉";
        }
        _deal.text = [NSString stringWithFormat:@"%@", model.tradedVolume];
        _frozen.text = [NSString stringWithFormat:@"%@", model.frozenVolume];
        _lab5.text = [NSString stringWithFormat:@"%@个", model.volume];
        _lab7.text = [NSString stringWithFormat:@"¥%@", model.price];
        _lab3.text = [NSString stringWithFormat:@"%.2f", [model.volume doubleValue] * [model.price doubleValue]];
        if ([model.postersType isEqualToString:@"0"]) {
            //分买入与卖出挂单手续费
            _lab8.hidden = YES;
            _lab9.hidden = YES;
        }else{
            _lab8.hidden = NO;
            _lab9.hidden = NO;
            _lab9.text = [NSString stringWithFormat:@"¥%@", model.askFee];
        }
        _bdNum.text = model.postersId;
        _bdTime.text = [QDDateUtils timeStampConversionNSString:model.createTime];
}
@end
