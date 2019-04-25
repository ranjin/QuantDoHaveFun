//
//  SYCollectionCell.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "SYCollectionCell.h"

@implementation SYCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _textLabel = [[UILabel alloc] init];
    _textLabel.font = [UIFont systemFontOfSize:13];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLabel];
    _textLabel.layer.cornerRadius = 4.f;
    _textLabel.layer.masksToBounds = YES;
    _textLabel.backgroundColor = [UIColor colorWithHexString:@"#EEF3F6"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.contentView.bounds;
}

@end
