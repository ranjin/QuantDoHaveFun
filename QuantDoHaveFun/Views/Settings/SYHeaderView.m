//
//  SYHeaderView.m
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import "SYHeaderView.h"

@implementation SYHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#F9FAFC"];
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(16, 0, self.frame.size.width - 32, self.frame.size.height);
}
@end
