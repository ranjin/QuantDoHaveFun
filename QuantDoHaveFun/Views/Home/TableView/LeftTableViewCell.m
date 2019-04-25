//
//  LeftTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "LeftTableViewCell.h"

#define defaultColor rgba(253, 212, 49, 1)

@interface LeftTableViewCell ()

@property (nonatomic, strong) UIView *yellowView;

@end

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.yellowView = [[UIView alloc] initWithFrame:CGRectMake(5, 15, 3, 15)];
        self.yellowView.backgroundColor = APP_BLUECOLOR;
        [self.contentView addSubview:self.yellowView];
        
        self.name = [[UILabel alloc] init];
        self.name.font = [UIFont systemFontOfSize:15];
        self.name.textColor = APP_GRAYCOLOR;
        self.name.highlightedTextColor = APP_BLUECOLOR;
        [self.contentView addSubview:self.name];
        [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.yellowView);
            make.left.equalTo(self.yellowView.mas_right).offset(9);
        }];
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state

    self.contentView.backgroundColor = selected ? APP_LIGTHGRAYLINECOLOR : [UIColor whiteColor];
    self.highlighted = selected;
    self.name.highlighted = selected;
    self.yellowView.hidden = !selected;
}

@end
