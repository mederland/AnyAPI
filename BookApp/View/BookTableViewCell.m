//
//  BookTableViewCell.m
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import "BookTableViewCell.h"

@implementation BookTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    
    return self;
}

-(void)setUp {
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setImage:[UIImage imageNamed:@"question-mark"]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setNumberOfLines:0];
    [label setText:@"Book Name"];
    
    self.posterView = imageView;
    self.titleLabel = label;
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:label];
    
    [[imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8] setActive:YES];
    [[imageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:8] setActive:YES];
    [[imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8] setActive:YES];
    
    [[imageView.heightAnchor constraintEqualToConstant:150] setActive:YES];
    [[imageView.widthAnchor constraintEqualToConstant:150] setActive:YES];
    
    [[label.leadingAnchor constraintEqualToAnchor:imageView.trailingAnchor constant:8] setActive:YES];
    [[label.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-8] setActive:YES];
    [[label.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor] setActive:YES];
    
}

@end

