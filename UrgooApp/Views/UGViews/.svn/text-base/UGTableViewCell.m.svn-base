//
//  UGTableViewCell.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTableViewCell.h"

@implementation UGTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)ugTableViewCellWithTableView:(UITableView *)tableView
{
    UGTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ugtableviewcellStr];
    if (!cell) {
        cell = [[UGTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ugtableviewcellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
