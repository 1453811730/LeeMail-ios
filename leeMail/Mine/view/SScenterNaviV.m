//
//  SScenterNaviV.m
//  leeMail
//
//  Created by F S on 2019/7/9.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SScenterNaviV.h"

@implementation SScenterNaviV

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.rightBtnV = [[SSbadgeBtnV alloc] initWithFrame:CGRectMake(frame.size.width-64, 0, 64, 44)];
        self.rightBtnV.imageV.image = [UIImage imageNamed:@"xiaoxi"];
        [self.rightBtnV.imageV sizeToFit];
        [self addSubview:self.rightBtnV];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
