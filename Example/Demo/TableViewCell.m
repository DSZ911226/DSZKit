//
//  TableViewCell.m
//  Demo
//
//  Created by zhilvmac on 2017/8/28.
//  Copyright © 2017年 zjwist. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation TableViewCell



#pragma mark - 系统方法

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.textColor = [UIColor redColor];;
        
        [self addSubview:self.dateLabel];
        self.dateLabel.frame = CGRectMake(14, 15, 150, 12);
    
        
    }
    return self;


}



- (void)setModel:(Firstmodel *)model {
    _model = model;
    self.dateLabel.text = model.name;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
