//
//  QDDropDownItemCell.m
//  QuantDoHaveFun
//
//  Created by lidi on 2019/5/8.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import "QDDropDownItemCell.h"
#import "UIView+LDCategory.h"

@interface QDDropDownItemCell ()
@property(nonatomic,strong)UILabel *titleLabel;
@end

@implementation QDDropDownItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView.layer setCornerRadius:4];
        [self.contentView LD_addBorderWithBorderColor:LD_colorRGBValue(0xeeeeee) borderWidth:1];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.contentView.mas_centerX);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(self.contentView.mas_width);
            make.height.mas_equalTo(20);
        }];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = QDFont(14);
        self.titleLabel.textColor = [UIColor blackColor];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.titleLabel.textColor = [UIColor whiteColor];
        self.contentView.backgroundColor = LD_colorRGBValue(0x00C0AC);
        [self.contentView LD_addBorderWithBorderColor:LD_colorRGBValue(0x00C0AC) borderWidth:1];
    } else {
        self.titleLabel.textColor = [UIColor blackColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView LD_addBorderWithBorderColor:LD_colorRGBValue(0xeeeeee) borderWidth:1];
    }
    NSLog(@"----selected:  %d",selected);
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = _title;
}

@end
