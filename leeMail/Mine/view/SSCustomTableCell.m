//
//  SSCustomTableCell.m
//  leeMail
//
//  Created by F S on 2019/7/9.
//  Copyright © 2019 F S. All rights reserved.
//

#import "SSCustomTableCell.h"

@implementation SSCustomTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)setDetailTextColor:(UIColor *)detailTextColor{
    _detailTextColor = detailTextColor;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self customImageView];
    [self customTextLable];
}

-(void)customImageView{
    CGFloat height = CGRectGetHeight(self.contentView.frame) - 16 > 60 ? 60 : CGRectGetHeight(self.contentView.frame) - 27;
    self.imageView.bounds = CGRectMake(CGRectGetMinX(self.contentView.frame) + 15,10,height,height);
    self.imageView.frame = CGRectMake(CGRectGetMinX(self.contentView.frame) + 15,10,height,height);
    self.imageView.center = CGPointMake(CGRectGetMinX(self.contentView.frame) + 15 + height/2, CGRectGetHeight(self.contentView.frame)/2);
    self.imageView.contentMode =UIViewContentModeScaleAspectFit;
}

-(void)customTextLable{
    //    self.textLabel.font = [UIFont systemFontOfSize:16];
    //    self.textLabel.textColor = [UIColor YQtitleColor51];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.textColor = _detailTextColor ? _detailTextColor : [UIColor YQsubTitleColor136];
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = self.imageView.image ? CGRectGetMaxX(self.imageView.frame) + 10 : 15;
    self.textLabel.frame = tmpFrame;
    
}

@end
