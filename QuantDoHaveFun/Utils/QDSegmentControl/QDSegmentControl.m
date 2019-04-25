//
//  QDSegmentControl.m
//  QDINFI
//
//  Created by ZengTark on 2017/12/15.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import "QDSegmentControl.h"

@implementation QDSegmentControl

- (instancetype)init
{
    if (self = [super init]) {
        [self setupSegmentControl];
    }
    return self;
}

- (instancetype)initWithSectionImages:(NSArray<UIImage *> *)sectionImages sectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages titlesForSections:(NSArray<NSString *> *)sectiontitles{
    if (self = [super initWithSectionImages:sectionImages sectionSelectedImages:sectionSelectedImages titlesForSections:sectiontitles]) {
        [self setupSegmentControl];
    }
    return self;
}

- (id)initWithSectionTitles:(NSArray<NSString *> *)sectiontitles
{
    if (self = [super initWithSectionTitles:sectiontitles]) {
        [self setupSegmentControl];
    }
    return self;
}

- (void)setupSegmentControl
{
    self.selectionIndicatorHeight = 2.0f;
    self.titleTextAttributes = @{NSForegroundColorAttributeName: APP_GRAYCOLOR, NSFontAttributeName: QDFont(14)};
    self.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    QDWeakSelf(self);
    weakself.backgroundColor = [UIColor whiteColor];
    weakself.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: APP_BLACKCOLOR, NSFontAttributeName: QDFont(14)};
    weakself.selectionIndicatorColor = APP_BLUECOLOR;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
